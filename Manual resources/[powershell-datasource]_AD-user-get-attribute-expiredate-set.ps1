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
    $actionMessage = "querying AD user [$($selectedUser.UserPrincipalName)] to check AccountExpirationDate status"

    $getADUserSplatParams = @{
        Filter      = "UserPrincipalName -eq '$($selectedUser.UserPrincipalName)'"
        Properties  = $propertiesToSelect
        Verbose     = $false
        ErrorAction = "Stop"
    }
    
    $adUser = Get-ADUser @getADUserSplatParams | Select-Object -Property $propertiesToSelect

    Write-Information "Queried AD user [$($selectedUser.UserPrincipalName)]. Result: $(if ($null -ne $adUser) { 'Found' } else { 'Not found' })"

    if ($null -ne $adUser) {
        $expDate = $adUser.AccountExpirationDate
        
        if ([String]::IsNullOrEmpty($expDate) -eq $true) {
            $expireDateSet = $false
        }
        else {
            $expireDateSet = $true
        }
        
        Write-Information "Account AccountExpirationDate for user [$($selectedUser.UserPrincipalName)]: $(if ($expireDateSet) { "Set to [$expDate]" } else { 'Not set' })"
        
        # Output result
        Write-Output @{ 
            expireDateSet = $expireDateSet
        }
    }
    else {
        Write-Warning "AD user [$($selectedUser.UserPrincipalName)] not found"
        Write-Output @{ 
            expireDateSet = $false
        }
    }
}
catch {
    $ex = $PSItem
    $auditMessage = "Error $($actionMessage). Error: $($ex.Exception.Message)"
    $warningMessage = "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"

    Write-Warning $warningMessage
    Write-Error $auditMessage
    
    # Output default values on error
    Write-Output @{ 
        expireDateSet = $false
    }
}
