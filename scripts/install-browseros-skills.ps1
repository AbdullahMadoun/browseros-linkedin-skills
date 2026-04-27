param(
  [string]$BrowserOsSkillsPath = "$env:USERPROFILE\.browseros\skills",
  [switch]$Overwrite
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$sourceSkills = Join-Path $repoRoot "skills"

if (-not (Test-Path -LiteralPath $sourceSkills)) {
  throw "Cannot find source skills directory: $sourceSkills"
}

New-Item -ItemType Directory -Force -Path $BrowserOsSkillsPath | Out-Null

$installed = @()
$skipped = @()

Get-ChildItem -Directory -LiteralPath $sourceSkills | Sort-Object Name | ForEach-Object {
  $source = $_.FullName
  $target = Join-Path $BrowserOsSkillsPath $_.Name

  if ((Test-Path -LiteralPath $target) -and -not $Overwrite) {
    $skipped += $_.Name
    return
  }

  New-Item -ItemType Directory -Force -Path $target | Out-Null
  Copy-Item -Path (Join-Path $source "*") -Destination $target -Recurse -Force
  $installed += $_.Name
}

Write-Output "BrowserOS skills path: $BrowserOsSkillsPath"
Write-Output "Installed or updated: $($installed.Count)"
$installed | ForEach-Object { Write-Output "  + $_" }
Write-Output "Skipped existing: $($skipped.Count)"
$skipped | ForEach-Object { Write-Output "  = $_" }

if ($skipped.Count -gt 0 -and -not $Overwrite) {
  Write-Output "Run with -Overwrite to update existing skill directories."
}
