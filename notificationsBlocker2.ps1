$URLs = @(
  "example.com",
  "oraxtech.com"
)

$Browsers = @(
  "Microsoft\Edge",
  "Google\Chrome"
)

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