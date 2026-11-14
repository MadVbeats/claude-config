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

# Большие каталоги, которые навыки читают по запросу (клонируются, а не хранятся в этом репозитории)
$dataRepos = @{
    'anthropic-cybersecurity-skills' = 'https://github.com/mukul975/anthropic-cybersecurity-skills.git'
}
$dataDir = Join-Path $dst 'skill-data'
New-Item -ItemType Directory -Force $dataDir | Out-Null
foreach ($name in $dataRepos.Keys) {
    $target = Join-Path $dataDir $name
    if (Test-Path (Join-Path $target '.git')) {
        git -C $target pull -q --depth 1
        Write-Host "OK  skill-data\$name (обновлён)"
    } else {
        git clone -q --depth 1 $dataRepos[$name] $target
        Write-Host "OK  skill-data\$name (склонирован)"
    }
}

if (Test-Path $backup) { Write-Host "Старые версии сохранены в $backup" }
Write-Host "Готово. Перезапустите Claude Code, чтобы навыки подхватились."
