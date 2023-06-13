# This code is messy. It's not perfect.
# Written by michael.burr@REDACTED.com
# No License, No Warranty, Good Luck.

$urlArray = @('example.com','test.example.com')
$browserArray = @("Google\Chrome","Microsoft\Edge")

# Download from Github
$response = Invoke-WebRequest -Uri "GITHUB_URL"
$content = $response.Content
# Split Request
$urlArray = $content -split '\r?\n'

# Prep Registry for addition of URL Blocks

# Create the registry path for Google Chrome if it doesn't exist
foreach ($browser in $browserArray) {
$browserRegistryPath = "HKLM:\Software\Policies\$browser"
    if (-not (Test-Path $browserRegistryPath)) {
        New-Item -Path $browserRegistryPath -Force | Out-Null
    }
}

# Loop to apply Registry Entries
foreach ($url in $urlArray) {
New-ItemProperty -Path "$chromeRegistryPath\NotificationsBlockedForUrls" -Name $urlArray.IndexOf($url) -Value $url -PropertyType "String"
New-ItemProperty -Path "$edgeRegistryPath\NotificationsBlockedForUrls" -Name $urlArray.IndexOf($url) -Value $url -PropertyType "String"
}
# Send a message to the user, since it's a Local Machine addition, this will require a restart.
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("Hi, This is an automatic notification from REDACTED. We've deployed a change to your device that will fix your notification issues. Please restart your device to ensure the change takes place.", 0, "REDACTED Notification", 64)