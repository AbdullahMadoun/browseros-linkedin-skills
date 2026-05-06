param(
  [string]$BrowserOsSkillsPath = "$env:USERPROFILE\.browseros\skills",
  [switch]$Overwrite,
  [switch]$Prune
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$sourceSkills = Join-Path $repoRoot "skills"
$manifestName = ".browseros-linkedin-skills.manifest"

if (-not (Test-Path -LiteralPath $sourceSkills)) {
  throw "Cannot find source skills directory: $sourceSkills"
}

New-Item -ItemType Directory -Force -Path $BrowserOsSkillsPath | Out-Null

$installed = @()
$skipped = @()
$pruned = @()
$seen = @{}

$skillManifests = Get-ChildItem -LiteralPath $sourceSkills -Recurse -File -Filter "SKILL.md" | Sort-Object FullName

$skillManifests | ForEach-Object {
  $source = $_.Directory.FullName
  $skillName = $_.Directory.Name
  $target = Join-Path $BrowserOsSkillsPath $skillName

  if ($seen.ContainsKey($skillName)) {
    throw "Duplicate skill folder name found: $skillName"
  }
  $seen[$skillName] = $true

  if ((Test-Path -LiteralPath $target) -and -not $Overwrite) {
    $skipped += $skillName
    return
  }

  New-Item -ItemType Directory -Force -Path $target | Out-Null
  Copy-Item -Path (Join-Path $source "*") -Destination $target -Recurse -Force
  $installed += $skillName
}

Write-Output "BrowserOS skills path: $BrowserOsSkillsPath"
Write-Output "Installed or updated: $($installed.Count)"
$installed | ForEach-Object { Write-Output "  + $_" }
Write-Output "Skipped existing: $($skipped.Count)"
$skipped | ForEach-Object { Write-Output "  = $_" }

if ($Prune) {
  $manifestPath = Join-Path $BrowserOsSkillsPath $manifestName
  if (Test-Path -LiteralPath $manifestPath) {
    Get-Content -LiteralPath $manifestPath | ForEach-Object {
      $installedName = $_.Trim()
      if ([string]::IsNullOrWhiteSpace($installedName) -or $installedName -eq "builtin") {
        return
      }
      if ($seen.ContainsKey($installedName)) {
        return
      }
      $target = Join-Path $BrowserOsSkillsPath $installedName
      if (-not (Test-Path -LiteralPath $target -PathType Container)) {
        return
      }
      Remove-Item -LiteralPath $target -Recurse -Force
      $pruned += $installedName
    }
  } else {
    Write-Output "Prune skipped: no previous repo manifest at $manifestPath"
  }
}

$manifestPath = Join-Path $BrowserOsSkillsPath $manifestName
$seen.Keys | Sort-Object | Set-Content -LiteralPath $manifestPath -Encoding UTF8

Write-Output "Pruned stale repo skills: $($pruned.Count)"
$pruned | ForEach-Object { Write-Output "  - $_" }

if ($skipped.Count -gt 0 -and -not $Overwrite) {
  Write-Output "Run with -Overwrite to update existing skill directories."
}
