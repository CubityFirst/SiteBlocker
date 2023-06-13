# Download & Prep URL List for Unblocking (This is a awful solution, looking to see if I can get a count of keys)
$response = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/CubityFirst/SiteBlocker/main/lists/notifications.txt"
$content = $response.Content
$URLs = $content -split '\r?\n'

$Browsers = @("Microsoft\Edge","Google\Chrome")

# Undo
foreach ($Browser in $Browsers) {

  $RegistryPath = "HKLM:\Software\Policies\$Browser\NotificationsBlockedForUrls"

  if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
  }

  foreach ($URL in $URLs) {
    $PropertySplat = @{
      Path = $RegistryPath
      Name = $URLs.IndexOf($URL)
    }

    Remove-ItemProperty @PropertySplat
  }
}