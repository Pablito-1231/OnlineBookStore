# Uso del script `apply-on-delete-cascade.sql`

Este directorio contiene un script para aplicar `ON DELETE CASCADE` en las foreign keys
relevantes de la base de datos `onlinebookstore` (local XAMPP/MySQL). No se realizan
commits automáticos: tú harás el commit cuando quieras.

Archivos:
- `apply-on-delete-cascade.sql`: Script que detecta y reemplaza FKs en `shopping_cart`
  y `authorities` por constraints con `ON DELETE CASCADE`.

Precauciones y pasos recomendados
1. Backup (ya creado por el asistente):
   - Archivo: `backup_before_ondelete_2025-11-27.sql` en la raíz del repo.
   - Para restaurar (si es necesario):
     ```powershell
     & 'C:\xampp\mysql\bin\mysql.exe' -u root onlinebookstore < .\backup_before_ondelete_2025-11-27.sql
     ```

2. Ejecutar el script (desde PowerShell):
   ```powershell
   & 'C:\xampp\mysql\bin\mysql.exe' -u root onlinebookstore < .\scripts\apply-on-delete-cascade.sql
   ```
   - Alternativa: abrir `mysql.exe` y ejecutar manualmente el contenido para revisión.

3. Verificación rápida desde PowerShell:
   ```powershell
   & 'C:\xampp\mysql\bin\mysql.exe' -u root -N -e "SELECT CONSTRAINT_NAME, DELETE_RULE FROM information_schema.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA='onlinebookstore' AND CONSTRAINT_NAME IN ('fk_shopping_cart_book','fk_shopping_cart_customer','fk_authorities_user');"
   ```
   Debes ver `DELETE_RULE = CASCADE` para las constraints listadas.

4. Tests: ya ejecuté la suite `mvnw -Dspring.profiles.active=test-mysql test` y pasó.
   Igualmente, si vas a probar localmente después de aplicar el script, ejecuta:
   ```powershell
   $env:SPRING_PROFILES_ACTIVE='test-mysql'
   .\mvnw.cmd -B test
   ```

5. Commit y auditoría:
   - Si quieres añadir el script al control de versiones, los comandos sugeridos:
     ```powershell
     git add scripts/apply-on-delete-cascade.sql scripts/README.md
     git commit -m "Add script and README to apply ON DELETE CASCADE for shopping_cart and authorities"
     git push
     ```
   - Yo no hago el commit por ti, como pediste.

Notas adicionales
- El script intenta detectar y eliminar la primera FK detectada que referencia la tabla objetivo.
  Si tu esquema tiene múltiples constraints de la misma referencia, inspección manual puede ser necesaria.
- Si tu entorno de MySQL usa autenticación distinta (usuario/contraseña, puerto diferente), ajusta
  los comandos anteriores.

Contacto
- Si quieres, puedo crear un `PR` con este cambio o aplicarlo en un branch diferente antes de
  que lo merges; dime cómo prefieres proceder.
