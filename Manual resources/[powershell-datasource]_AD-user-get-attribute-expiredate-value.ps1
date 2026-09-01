# Variables configured in datasource
$selectedUser = $datasource.selectedUser

# Fixed values
$propertiesToSelect = @(
    "ObjectGuid",
    "UserPrincipalName",
    "AccountExpirationDate"
) # Properties to select from Microsoft AD, comma separated

# Set debug logging
$VerbosePreference = "SilentlyContinue"
$InformationPreference = "Continue"
$WarningPreference = "Continue"

try {
    $actionMessage = "querying AD user [$($selectedUser.UserPrincipalName)] to get AccountExpirationDate"

    $getADUserSplatParams = @{
        Filter      = "UserPrincipalName -eq '$($selectedUser.UserPrincipalName)'"
        Properties  = $propertiesToSelect
        Verbose     = $false
        ErrorAction = "Stop"
    }
    
    $adUser = Get-ADUser @getADUserSplatParams | Select-Object -Property $propertiesToSelect

    Write-Information "Queried AD user [$($selectedUser.UserPrincipalName)]. Result: $(if ($null -ne $adUser) { 'Found' } else { 'Not found' })"

    if ($null -ne $adUser) {
        # Default date for datetime selector (use current date if no expiration date is set)
        if (-not [String]::IsNullOrEmpty($adUser.AccountExpirationDate)) {
            $expDate = Get-Date $adUser.AccountExpirationDate -Format s
        }
        else {
            $expDate = Get-Date -Format s
        }
        
        Write-Information "Account AccountExpirationDate for user [$($selectedUser.UserPrincipalName)]: $expDate"
        
        # Output result
        Write-Output @{ 
            expireDate = "$expDate"
        }
    }
    else {
        Write-Warning "AD user [$($selectedUser.UserPrincipalName)] not found"
        
        # Output default date
        $expDate = Get-Date -Format s
        Write-Output @{ 
            expireDate = "$expDate"
        }
    }
}
catch {
    $ex = $PSItem
    $auditMessage = "Error $($actionMessage). Error: $($ex.Exception.Message)"
    $warningMessage = "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"

    Write-Warning $warningMessage
    Write-Error $auditMessage
    
    # Output default date on error
    $expDate = Get-Date -Format s
    Write-Output @{ 
        expireDate = "$expDate"
    }
}
