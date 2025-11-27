-- apply-on-delete-cascade.sql
-- Created: 2025-11-27
-- Purpose: Safely replace existing foreign keys on `shopping_cart` and `authorities`
-- with explicit ON DELETE CASCADE constraints. This script attempts to detect and drop
-- the existing FK constraints (by referenced table), then re-creates stable-named FKs
-- with ON DELETE CASCADE.

-- IMPORTANT:
-- 1) Run against the `onlinebookstore` database. By default it will use the current
--    connection's database (DATABASE()). If you need a different DB, edit the
--    WHERE TABLE_SCHEMA='onlinebookstore' clauses below or connect to that DB.
-- 2) A backup was created before changes: ./backup_before_ondelete_2025-11-27.sql
-- 3) This script is idempotent for typical cases: it will drop any FK that references
--    the same referenced table and then re-create the desired named FK.

-- Disable foreign key checks while changing constraints
SET @OLD_FK_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;

-- Helper: drop a single FK on a table that references a given referenced_table (if any)
-- Drops the first matching FK (if multiple exist, run again or inspect information_schema).

-- Drop any FK on shopping_cart that references book
SELECT CONSTRAINT_NAME INTO @c FROM information_schema.KEY_COLUMN_USAGE
 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'shopping_cart' AND REFERENCED_TABLE_NAME = 'book' LIMIT 1;
SET @sql = IF(@c IS NULL, 'SELECT 1', CONCAT('ALTER TABLE shopping_cart DROP FOREIGN KEY `', @c, '`'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Drop any FK on shopping_cart that references customer
SELECT CONSTRAINT_NAME INTO @c FROM information_schema.KEY_COLUMN_USAGE
 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'shopping_cart' AND REFERENCED_TABLE_NAME = 'customer' LIMIT 1;
SET @sql = IF(@c IS NULL, 'SELECT 1', CONCAT('ALTER TABLE shopping_cart DROP FOREIGN KEY `', @c, '`'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Drop any FK on authorities that references users (username)
SELECT CONSTRAINT_NAME INTO @c FROM information_schema.KEY_COLUMN_USAGE
 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'authorities' AND REFERENCED_TABLE_NAME = 'users' LIMIT 1;
SET @sql = IF(@c IS NULL, 'SELECT 1', CONCAT('ALTER TABLE authorities DROP FOREIGN KEY `', @c, '`'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Re-create stable-named FKs with ON DELETE CASCADE
ALTER TABLE shopping_cart
  ADD CONSTRAINT fk_shopping_cart_book FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE;

ALTER TABLE shopping_cart
  ADD CONSTRAINT fk_shopping_cart_customer FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE;

ALTER TABLE authorities
  ADD CONSTRAINT fk_authorities_user FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE;

-- Restore foreign key checks
SET FOREIGN_KEY_CHECKS = @OLD_FK_CHECKS;

-- Verify (run as separate queries if you want human-readable output):
-- SELECT CONSTRAINT_NAME, DELETE_RULE FROM information_schema.REFERENTIAL_CONSTRAINTS
--  WHERE CONSTRAINT_SCHEMA = DATABASE() AND CONSTRAINT_NAME IN ('fk_shopping_cart_book','fk_shopping_cart_customer','fk_authorities_user');

-- End of script
