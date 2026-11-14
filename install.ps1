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

# Плагины из маркетплейсов: дописываем enabledPlugins в ~/.claude/settings.json, остальное не трогаем
$pluginsFile = Join-Path $src 'enabled-plugins.json'
if (Test-Path $pluginsFile) {
    $settingsPath = Join-Path $dst 'settings.json'
    $settings = if (Test-Path $settingsPath) { Get-Content $settingsPath -Raw -Encoding UTF8 | ConvertFrom-Json } else { New-Object PSObject }
    if (-not $settings) { $settings = New-Object PSObject }
    if (-not ($settings.PSObject.Properties.Name -contains 'enabledPlugins')) {
        $settings | Add-Member -NotePropertyName enabledPlugins -NotePropertyValue (New-Object PSObject)
    }
    $wanted = Get-Content $pluginsFile -Raw -Encoding UTF8 | ConvertFrom-Json
    foreach ($p in $wanted.PSObject.Properties) {
        if ($settings.enabledPlugins.PSObject.Properties.Name -contains $p.Name) { $settings.enabledPlugins.($p.Name) = $p.Value }
        else { $settings.enabledPlugins | Add-Member -NotePropertyName $p.Name -NotePropertyValue $p.Value }
        Write-Host "OK  plugin $($p.Name)"
    }
    # Общие переменные окружения (без секретов!) из settings-env.json
    $envFile = Join-Path $src 'settings-env.json'
    if (Test-Path $envFile) {
        if (-not ($settings.PSObject.Properties.Name -contains 'env')) { $settings | Add-Member -NotePropertyName env -NotePropertyValue (New-Object PSObject) }
        $wantedEnv = Get-Content $envFile -Raw -Encoding UTF8 | ConvertFrom-Json
        foreach ($e in $wantedEnv.PSObject.Properties) {
            if ($settings.env.PSObject.Properties.Name -contains $e.Name) { $settings.env.($e.Name) = $e.Value }
            else { $settings.env | Add-Member -NotePropertyName $e.Name -NotePropertyValue $e.Value }
            Write-Host "OK  env $($e.Name)"
        }
    }
    if (Test-Path $settingsPath) {
        New-Item -ItemType Directory -Force $backup | Out-Null
        Copy-Item $settingsPath (Join-Path $backup 'settings.json')
    }
    [IO.File]::WriteAllText($settingsPath, ($settings | ConvertTo-Json -Depth 20), (New-Object Text.UTF8Encoding $false))
}

# Большие каталоги, которые навыки читают по запросу (клонируются, а не хранятся в этом репозитории)
$dataRepos = @{
    'anthropic-cybersecurity-skills' = 'https://github.com/mukul975/anthropic-cybersecurity-skills.git'
    'awesome-mcp-servers'            = 'https://github.com/punkpeye/awesome-mcp-servers.git'
    'claude-code-best-practice'      = 'https://github.com/shanraisshan/claude-code-best-practice.git'
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
