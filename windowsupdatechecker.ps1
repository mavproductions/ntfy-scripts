Import-Module PSWindowsUpdate

# Get all updates
$AllUpdates = Get-WindowsUpdate

# Filter for updates with status '-D-----'
$PendingUpdates = $AllUpdates | Where-Object { $_.Status -eq '-D-----' }

if ($PendingUpdates) {
    # Updates are found with status '-D-----'
    $BodyMessage = "Windows Update: There are updates pending installation."

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
    Invoke-RestMethod @Request
} else {
    Write-Output "Windows Update: No updates available."
}

Exit

# Get the current PowerShell process
$CurrentProcess = Get-Process -Id $PID

# Stop the PowerShell process
$CurrentProcess | Stop-Process -Force