# --- Configurações do Ambiente ---
$DB_USER = "root"
$DB_PASS = "MnhaSenha"
$DB_NAME = "db_tcgpokemon_cards"
$SQL_PATH = "F:\E-CARDS\db_scripts" # Caminho onde estão seus .sql
$MYSQL_PATH = "C:\Program Files\MySQL\MySQL Server 9.5\bin\mysql.exe"

# 1. Limpar o console para começar do zero
Clear-Host
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "   MIGRATION TOOL - PROJETO E-CARDS (MYSQL 9.5) " -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan

# 2. Capturar arquivos .sql ordenados por nome
$scripts = Get-ChildItem -Path "$SQL_PATH\*.sql" | Sort-Object Name

if ($scripts.Count -eq 0) {
    Write-Host "[!] Nenhum script encontrado em: $SQL_PATH" -ForegroundColor Red
    return
}

# 3. Execução Sequencial
foreach ($script in $scripts) {
    Write-Host "`n[EXECUTANDO] -> $($script.Name)" -ForegroundColor Yellow
    
    # Comando de execução via MySQL Client
    $command = "& '$MYSQL_PATH' -u $DB_USER --password=$DB_PASS $DB_NAME < '$($script.FullName)'"
    Invoke-Expression $command

    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Concluído com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "[ERRO] Falha no script $($script.Name). Abortando migração." -ForegroundColor Red
        break
    }
}

Write-Host "`n===============================================" -ForegroundColor Cyan
Write-Host "         PROCESSO DE MIGRAÇÃO FINALIZADO       " -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
