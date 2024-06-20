$PCName = [System.Environment]::MachineName # Netbios Name
#$PCName = BobandAlice-PC # Hard-coded PC Name

$Request = @{
    Method = "POST"
    URI = "https://ntfy.sh/youShouldSelfHostOrBuyPremium"
    Headers = @{
    ## See Ntfy - Authentication for more info (https://docs.ntfy.sh/publish/#authentication)
        # Authorization = "Bearer <tokenHere>" ##Powershell 5 and earlier example
    }
    Body = "Login Made: " + $PCName
}
Invoke-RestMethod @Request

Exit

# Get the current PowerShell process
$CurrentProcess = Get-Process -Id $PID

# Stop the PowerShell process
$CurrentProcess | Stop-Process -Force