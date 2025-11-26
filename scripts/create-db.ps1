<#
  Script para compilar y ejecutar `scripts/CreateDb.java`.
  Uso: Ejecutar desde la raíz del proyecto (PowerShell):
    .\scripts\create-db.ps1
  El script busca el conector MySQL en el repositorio local de Maven y lo utiliza en el classpath.
#>

$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
# El script está en <projectRoot>/scripts, por lo que usamos esa carpeta como base
$javaFile = Join-Path $projectRoot 'CreateDb.java'
$binDir = Join-Path $projectRoot 'bin'

# Encontrar el driver mysql connector en el repo local (~/.m2/repository)
$connector = Get-ChildItem "$env:USERPROFILE\\.m2\\repository\\com\\mysql\\mysql-connector-j" -Recurse -Filter "mysql-connector-j-*.jar" -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if (-not $connector) {
    Write-Error "No se encontró mysql-connector-j en $env:USERPROFILE\\.m2\\repository. Ejecuta mvn package o descarga el conector.";
    exit 1
}

# Preparar bin dir
if (-Not (Test-Path $binDir)) { New-Item -ItemType Directory -Path $binDir | Out-Null }

Write-Output "Compilando $javaFile..."
javac -cp "$($connector.FullName)" -d "$binDir" "$javaFile"

Write-Output "Ejecutando CreateDb..."
java -cp "$binDir;$($connector.FullName)" CreateDb

if ($LASTEXITCODE -eq 0) { Write-Output 'CreateDb ejecutado correctamente.' } else { Write-Error 'CreateDb devolvió un error.'; exit $LASTEXITCODE }
