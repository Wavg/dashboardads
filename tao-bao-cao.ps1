<#
  tao-bao-cao.ps1 — Sinh dashboard HTML từ 1 file dữ liệu JSON + template.
  Cách dùng:
    .\tao-bao-cao.ps1                         # dùng file JSON mới nhất trong data\
    .\tao-bao-cao.ps1 -DataFile data\2026-06-15_2026-06-21.json
  Kết quả:
    - reports\dashboard_<ten-file>.html   (lưu trữ theo tuần)
    - index.html                          (luôn = bản mới nhất)
#>
param([string]$DataFile)

$ErrorActionPreference = "Stop"
$root      = Split-Path -Parent $MyInvocation.MyCommand.Path
$tpl       = Join-Path $root "template\dashboard-template.html"
$dataDir   = Join-Path $root "data"
$reportDir = Join-Path $root "reports"
if (-not (Test-Path $reportDir)) { New-Item -ItemType Directory -Path $reportDir | Out-Null }

# Chọn file dữ liệu: nếu không truyền -DataFile thì lấy JSON mới nhất trong data\
if (-not $DataFile) {
  $latest = Get-ChildItem $dataDir -Filter *.json | Sort-Object Name -Descending | Select-Object -First 1
  if (-not $latest) { throw "Khong tim thay file JSON nao trong thu muc data\" }
  $DataFile = $latest.FullName
}
if (-not (Test-Path $DataFile)) { throw "Khong thay file du lieu: $DataFile" }

$base     = [System.IO.Path]::GetFileNameWithoutExtension($DataFile)
$template = Get-Content $tpl -Raw -Encoding UTF8
$json     = Get-Content $DataFile -Raw -Encoding UTF8

# Kiem tra JSON hop le truoc khi chen
try { $null = $json | ConvertFrom-Json } catch { throw "File JSON bi loi cu phap: $($_.Exception.Message)" }

$html = $template.Replace("{{DATA}}", $json)

$enc = New-Object System.Text.UTF8Encoding($false)   # UTF-8 khong BOM
$out = Join-Path $reportDir ("dashboard_" + $base + ".html")
[System.IO.File]::WriteAllText($out, $html, $enc)
[System.IO.File]::WriteAllText((Join-Path $root "index.html"), $html, $enc)

Write-Host "Da tao bao cao tu: $DataFile" -ForegroundColor Green
Write-Host "  -> $out"
Write-Host "  -> index.html (ban moi nhat)"
