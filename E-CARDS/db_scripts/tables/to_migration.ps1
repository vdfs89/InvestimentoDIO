# --- Migration de Tabelas ---
$DB_USER = "root"
$DB_PASS = "MnhaSenha"
$DB_NAME = "db_tcgpokemon_cards"
$SQL_FILE = "F:\\DIO\\Santander\\InvestimentoDIO\\E-CARDS\\db_scripts\\tables\\002_create_tables_migration.sql"
$MYSQL_PATH = "C:\\Program Files\\MySQL\\MySQL Server 9.5\\bin\\mysql.exe"

Clear-Host
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "   MIGRATION DE TABELAS - PROJETO E-CARDS      " -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan

if (!(Test-Path $SQL_FILE)) {
    Write-Host "[!] Migration não encontrada: $SQL_FILE" -ForegroundColor Red
    exit
}

$command = "& '$MYSQL_PATH' -u $DB_USER --password=$DB_PASS $DB_NAME < '$SQL_FILE'"
Invoke-Expression $command

if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] Tabelas criadas com sucesso!" -ForegroundColor Green
} else {
    Write-Host "[ERRO] Falha na criação das tabelas." -ForegroundColor Red
}

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "         MIGRATION FINALIZADA                 " -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan