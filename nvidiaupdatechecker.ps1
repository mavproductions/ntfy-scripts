# Checking currently installed driver version
Write-Host "Attempting to detect currently installed driver version..."
try {
    $VideoController = Get-CimInstance -ClassName Win32_VideoController | Where-Object { $_.Name -match "NVIDIA" }
    $ins_version = ($VideoController.DriverVersion.Replace('.', '')[-5..-1] -join '').insert(3, '.')
}
catch {
    Write-Host -ForegroundColor Yellow "Unable to detect a compatible Nvidia device."
    Write-Host "Press any key to exit..."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}
Write-Host "Installed version `t$ins_version"


# Checking latest driver version
$uri = 'https://gfwsl.geforce.com/services_toolkit/services/com/nvidia/services/AjaxDriverService.php' +
'?func=DriverManualLookup' +
'&psid=120' + # Geforce RTX 30 Series
'&pfid=934' +  # RTX 3060 Ti
'&osID=57' + # Windows 10 64bit
'&languageCode=1033' + # en-US; seems to be "Windows Locale ID"[1] in decimal
'&isWHQL=1' + # WHQL certified
'&dch=1' + # DCH drivers (the new standard)
'&sort1=0' + # sort: most recent first(?)
'&numberOfResults=1' # single, most recent result is enough

$response = Invoke-WebRequest -Uri $uri -Method GET -UseBasicParsing
$payload = $response.Content | ConvertFrom-Json
$version =  $payload.IDS[0].downloadInfo.Version
Write-Output "Latest version `t`t$version"

# Comparing installed driver version to latest driver version from Nvidia
if ($version -eq $ins_version) {
    Write-Host "The installed version is the same as the latest version."
    Write-Host "Press any key to exit..."
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

# Checking Windows version and bitness
if ([Environment]::OSVersion.Version -ge (new-object 'Version' 10, 0)) {
    $windowsVersion = "win10-win11"
} else {
    $windowsVersion = "win8-win7"
}

if ([Environment]::Is64BitOperatingSystem) {
    $windowsArchitecture = "64bit"
} else {
    $windowsArchitecture = "32bit"
}

# Prepare the message
if ($version) {
    $BodyMessage = "Nvidia Driver Update: New driver version $version is available for download."
} else {
    $BodyMessage = "Nvidia Driver Update: No new updates available."
}

# Prepare the request
$Request = @{
    Method = "POST"
        URI = "https://ntfy.sh/youShouldSelfHostOrBuyPremium"
        Headers = @{
        ## See Ntfy - Authentication for more info (https://docs.ntfy.sh/publish/#authentication)
            # Authorization = "Bearer <tokenHere>" ##Powershell 5 and earlier example
    }
    Body = $BodyMessage
}

# Send the CURL command
Invoke-RestMethod @Request
