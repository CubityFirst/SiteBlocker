# This code is messy. It's not perfect.
# Written by michael.burr@REDACTED.com
# No License, No Warranty, Good Luck.

# Download & Prep URL List for Blocking
$response = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/CubityFirst/SiteBlocker/main/lists/notifications.txt"
$content = $response.Content
$URLs = $content -split '\r?\n'

<# LEGACY - UNCOMMENT THIS IF YOU WANT TO HARD-SET SPECIFIC URLs
$URLs = @(
  "example.com",
  "oraxtech.com"
)
#>

$Browsers = @("Microsoft\Edge","Google\Chrome")

# Actual Notification Blocking
foreach ($Browser in $Browsers) {

  $RegistryPath = "HKLM:\Software\Policies\$Browser\NotificationsBlockedForUrls"

  if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
  }

  foreach ($URL in $URLs) {
    $PropertySplat = @{
      Path = $RegistryPath
      Name = $URLs.IndexOf($URL)
      Value = $URL
      PropertyType = "String"
    }

    New-ItemProperty @PropertySplat
  }
}
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("Hi, This is an automatic notification from REDACTED. We've deployed a change to your device that will fix your notification issues. Please restart your device to ensure the change takes place.", 0, "REDACTED Notification", 64)