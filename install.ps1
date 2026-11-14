# Устанавливает навыки, агентов, команды, правила и CLAUDE.md из этого репозитория в ~/.claude
# Запуск:  powershell -ExecutionPolicy Bypass -File .\install.ps1
# Существующие файлы с тем же именем сохраняются в ~/.claude/backups/claude-config-<дата>

$ErrorActionPreference = 'Stop'
$src    = $PSScriptRoot
$dst    = Join-Path $env:USERPROFILE '.claude'
$backup = Join-Path $dst ("backups\claude-config-" + (Get-Date -Format 'yyyyMMdd-HHmmss'))

New-Item -ItemType Directory -Force $dst | Out-Null

foreach ($dir in 'skills', 'agents', 'commands', 'rules') {
    $from = Join-Path $src $dir
    if (-not (Test-Path $from)) { continue }
    $to = Join-Path $dst $dir
    New-Item -ItemType Directory -Force $to | Out-Null
    foreach ($item in Get-ChildItem $from) {
        $target = Join-Path $to $item.Name
        if (Test-Path $target) {
            $bdir = Join-Path $backup $dir
            New-Item -ItemType Directory -Force $bdir | Out-Null
            Move-Item $target (Join-Path $bdir $item.Name)
        }
        Copy-Item $item.FullName $target -Recurse
        Write-Host "OK  $dir\$($item.Name)"
    }
}

$md = Join-Path $src 'CLAUDE.md'
if (Test-Path $md) {
    $target = Join-Path $dst 'CLAUDE.md'
    if (Test-Path $target) {
        New-Item -ItemType Directory -Force $backup | Out-Null
        Copy-Item $target (Join-Path $backup 'CLAUDE.md')
    }
    Copy-Item $md $target -Force
    Write-Host "OK  CLAUDE.md"
}

if (Test-Path $backup) { Write-Host "Старые версии сохранены в $backup" }
Write-Host "Готово. Перезапустите Claude Code, чтобы навыки подхватились."
