# Ставит инструменты, нужные навыкам (без прав администратора):
#   - Portable Git (bash) -> ~/tools/git        : хуки на bash (design-taste-frontend), скрипты task-observer
#   - Chrome for Testing  -> ~/tools/chrome-win64: проверки страниц в браузере (design-taste-frontend)
# и прописывает CLAUDE_CODE_GIT_BASH_PATH и CHROME_PATH в env ~/.claude/settings.json.
# Запуск: powershell -ExecutionPolicy Bypass -File .\setup-tools.ps1
# Уже установленное пропускается. После запуска перезапустите Claude.

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$tools = Join-Path $env:USERPROFILE 'tools'
$tmp = Join-Path $env:TEMP 'claude-config-tools'
New-Item -ItemType Directory -Force $tools, $tmp | Out-Null

# --- Portable Git ---
$bash = Join-Path $tools 'git\bin\bash.exe'
if (-not (Test-Path $bash)) {
    $rel = Invoke-RestMethod 'https://api.github.com/repos/git-for-windows/git/releases/latest' -Headers @{ 'User-Agent' = 'claude-config' }
    $asset = $rel.assets | Where-Object { $_.name -match '^PortableGit-.*-64-bit\.7z\.exe$' } | Select-Object -First 1
    $file = Join-Path $tmp $asset.name
    Write-Host "Скачиваю $($asset.name) ($([math]::Round($asset.size/1mb,1)) МБ)..."
    Invoke-WebRequest $asset.browser_download_url -OutFile $file -UseBasicParsing
    $sig = Get-AuthenticodeSignature $file
    if ($sig.Status -ne 'Valid' -or $sig.SignerCertificate.Subject -notmatch 'Johannes Schindelin') { throw "Подпись Git не прошла проверку: $($sig.Status) $($sig.SignerCertificate.Subject)" }
    $hash = (Get-FileHash $file -Algorithm SHA256).Hash.ToLower()
    if ($rel.body -notmatch [regex]::Escape($hash)) { throw 'SHA-256 Git не совпадает с опубликованным в релизе' }
    Start-Process -FilePath $file -ArgumentList "-o`"$(Join-Path $tools 'git')`"", '-y' -Wait -NoNewWindow
    Write-Host "OK  Portable Git -> $bash"
} else { Write-Host "OK  Portable Git уже есть" }

# --- Chrome for Testing ---
$chrome = Join-Path $tools 'chrome-win64\chrome.exe'
if (-not (Test-Path $chrome)) {
    $cft = Invoke-RestMethod 'https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json'
    $url = ($cft.channels.Stable.downloads.chrome | Where-Object platform -eq 'win64').url
    $zip = Join-Path $tmp 'chrome-win64.zip'
    Write-Host "Скачиваю Chrome for Testing $($cft.channels.Stable.version)..."
    Invoke-WebRequest $url -OutFile $zip -UseBasicParsing
    Expand-Archive $zip -DestinationPath $tools -Force
    Write-Host "OK  Chrome for Testing -> $chrome"
} else { Write-Host "OK  Chrome for Testing уже есть" }

# --- env в settings.json ---
$settingsPath = Join-Path $env:USERPROFILE '.claude\settings.json'
New-Item -ItemType Directory -Force (Split-Path $settingsPath) | Out-Null
$settings = if (Test-Path $settingsPath) { Get-Content $settingsPath -Raw -Encoding UTF8 | ConvertFrom-Json } else { New-Object PSObject }
if (-not $settings) { $settings = New-Object PSObject }
if (-not ($settings.PSObject.Properties.Name -contains 'env')) { $settings | Add-Member -NotePropertyName env -NotePropertyValue (New-Object PSObject) }
foreach ($kv in @(@('CLAUDE_CODE_GIT_BASH_PATH', $bash), @('CHROME_PATH', $chrome))) {
    if ($settings.env.PSObject.Properties.Name -contains $kv[0]) { $settings.env.($kv[0]) = $kv[1] }
    else { $settings.env | Add-Member -NotePropertyName $kv[0] -NotePropertyValue $kv[1] }
}
if (Test-Path $settingsPath) { Copy-Item $settingsPath "$settingsPath.bak" -Force }
[IO.File]::WriteAllText($settingsPath, ($settings | ConvertTo-Json -Depth 20), (New-Object Text.UTF8Encoding $false))
Write-Host "OK  env прописан в $settingsPath (старая версия: settings.json.bak)"
Write-Host 'Готово. Перезапустите Claude.'
