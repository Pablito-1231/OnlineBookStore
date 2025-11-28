-- Seed 120 realistic books (adds to existing data). Use only for development.
USE onlinebookstore;
SET FOREIGN_KEY_CHECKS=0;

-- This script rotates through a list of real titles/authors/genres and inserts book_detail + book.
-- Prices and quantities are random-ish using RAND().

-- Titles list (36 items)
SET @titles = NULL;

-- We'll generate 120 inserts by cycling through the list and appending a unique suffix to title.

-- Insert statements follow:
-- We'll define an array of seed data inside the script by repeating entries.
-- Format per entry: title | author | genre
SET @seed1 = 'Don Quixote|Miguel de Cervantes|Classic';
SET @seed2 = 'Pride and Prejudice|Jane Austen|Classic';
SET @seed3 = '1984|George Orwell|Dystopia';
SET @seed4 = 'To Kill a Mockingbird|Harper Lee|Fiction';
SET @seed5 = 'The Great Gatsby|F. Scott Fitzgerald|Classic';
SET @seed6 = 'Moby Dick|Herman Melville|Adventure';
SET @seed7 = 'War and Peace|Leo Tolstoy|Historical';
SET @seed8 = 'The Hobbit|J.R.R. Tolkien|Fantasy';
SET @seed9 = 'Crime and Punishment|Fyodor Dostoevsky|Classic';
SET @seed10 = 'The Catcher in the Rye|J.D. Salinger|Fiction';
SET @seed11 = 'Brave New World|Aldous Huxley|Dystopia';
SET @seed12 = 'Jane Eyre|Charlotte Brontë|Classic';
SET @seed13 = 'The Odyssey|Homer|Epic';
SET @seed14 = 'The Brothers Karamazov|Fyodor Dostoevsky|Philosophical';
SET @seed15 = 'Anna Karenina|Leo Tolstoy|Classic';
SET @seed16 = 'The Lord of the Rings|J.R.R. Tolkien|Fantasy';
SET @seed17 = 'The Alchemist|Paulo Coelho|Fiction';
SET @seed18 = 'The Little Prince|Antoine de Saint-Exupéry|Children';
SET @seed19 = 'Frankenstein|Mary Shelley|Horror';
SET @seed20 = 'Dracula|Bram Stoker|Horror';
SET @seed21 = 'The Kite Runner|Khaled Hosseini|Fiction';
SET @seed22 = 'One Hundred Years of Solitude|Gabriel García Márquez|Magical Realism';
SET @seed23 = 'Les Misérables|Victor Hugo|Historical';
SET @seed24 = 'The Picture of Dorian Gray|Oscar Wilde|Philosophical';
SET @seed25 = 'Wuthering Heights|Emily Brontë|Classic';
SET @seed26 = 'The Road|Cormac McCarthy|Post-Apocalyptic';
SET @seed27 = 'Meditations|Marcus Aurelius|Philosophy';
SET @seed28 = 'Siddhartha|Hermann Hesse|Philosophical';
SET @seed29 = 'The Book Thief|Markus Zusak|Historical';
SET @seed30 = 'The Chronicles of Narnia|C.S. Lewis|Fantasy';
SET @seed31 = 'Beloved|Toni Morrison|Fiction';
SET @seed32 = 'The Handmaid''s Tale|Margaret Atwood|Dystopia';
SET @seed33 = 'Life of Pi|Yann Martel|Fiction';
SET @seed34 = 'A Tale of Two Cities|Charles Dickens|Historical';
SET @seed35 = 'The Stranger|Albert Camus|Philosophical';
SET @seed36 = 'Slaughterhouse-Five|Kurt Vonnegut|Satire';

-- Now loop-style generation: create 120 inserts by cycling seed1..36
SET @i = 1;
WHILE @i <= 120 DO
	SET @idx = ((@i - 1) % 36) + 1;
	SET @seed = CASE @idx
		WHEN 1 THEN @seed1 WHEN 2 THEN @seed2 WHEN 3 THEN @seed3 WHEN 4 THEN @seed4 WHEN 5 THEN @seed5 WHEN 6 THEN @seed6
		WHEN 7 THEN @seed7 WHEN 8 THEN @seed8 WHEN 9 THEN @seed9 WHEN 10 THEN @seed10 WHEN 11 THEN @seed11 WHEN 12 THEN @seed12
		WHEN 13 THEN @seed13 WHEN 14 THEN @seed14 WHEN 15 THEN @seed15 WHEN 16 THEN @seed16 WHEN 17 THEN @seed17 WHEN 18 THEN @seed18
		WHEN 19 THEN @seed19 WHEN 20 THEN @seed20 WHEN 21 THEN @seed21 WHEN 22 THEN @seed22 WHEN 23 THEN @seed23 WHEN 24 THEN @seed24
		WHEN 25 THEN @seed25 WHEN 26 THEN @seed26 WHEN 27 THEN @seed27 WHEN 28 THEN @seed28 WHEN 29 THEN @seed29 WHEN 30 THEN @seed30
		WHEN 31 THEN @seed31 WHEN 32 THEN @seed32 WHEN 33 THEN @seed33 WHEN 34 THEN @seed34 WHEN 35 THEN @seed35 WHEN 36 THEN @seed36 END;
  
	SET @parts = @seed; -- format Title|Author|Genre
	SET @title = SUBSTRING_INDEX(@parts, '|', 1);
	SET @author = SUBSTRING_INDEX(SUBSTRING_INDEX(@parts, '|', 2), '|', -1);
	SET @genre = SUBSTRING_INDEX(@parts, '|', -1);
	SET @uniqueTitle = CONCAT(@title, ' - ADD ', @i);
	SET @isbn = CONCAT('978', LPAD(FLOOR(RAND()*10000000000),10,'0'));
	SET @synopsis = CONCAT(@title, ' is a ', LOWER(@genre), ' by ', @author, '. A compelling read.');
	SET @detail = CONCAT('Author: ', @author, '; ISBN: ', @isbn, '; Genre: ', @genre, '; Synopsis: ', @synopsis);
	SET @price = ROUND(8 + RAND()*42, 2);
	SET @qty = FLOOR(5 + RAND()*96);

	INSERT INTO book_detail (detail, sold, type) VALUES (@detail, 0, IF(@i % 3 = 0, 'HARDCOVER', IF(@i % 3 = 1, 'PAPERBACK', 'EBOOK')));
	SET @last = LAST_INSERT_ID();
	INSERT INTO book (name, price, quantity, book_detail_id) VALUES (@uniqueTitle, @price, @qty, @last);

	SET @i = @i + 1;
END WHILE;

SET FOREIGN_KEY_CHECKS=1;

-- End of seed script
