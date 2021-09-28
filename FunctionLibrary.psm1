
function Install-PSModule {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ModuleName
    )

    if (Get-Module -ListAvailable -Name $ModuleName) {
        Write-Host "$ModuleName installed OK" -ForegroundColor Green
    }
    else {
        Write-Host "$ModuleName not installed" -ForegroundColor Yellow
        Write-Host "Installing..." -ForegroundColor Yellow
        try {
            # Set PowerShell Gallery to trusted
            Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
            # Install module with current user to avoid running as admin
            Install-Module -Name $ModuleName -Scope CurrentUser -ErrorAction Stop
        }
        catch {
            #If the install fails, write the message to the screen
            $ErrorMessage = $_.Exception.Message
            Write-Host "Failed to install $ModuleName" -ForegroundColor Red
            Write-Host $ErrorMessage -ForegroundColor Red
        }   
    }
}
