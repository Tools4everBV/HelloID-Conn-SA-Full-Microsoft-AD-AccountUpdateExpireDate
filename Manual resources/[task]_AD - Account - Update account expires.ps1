# variables configured in form:
$user = $form.gridUsers
$blnExpDate = $form.blnExpDate
$expireDate = $form.expireDate

# Set debug logging
$VerbosePreference = "SilentlyContinue"
$InformationPreference = "Continue"
$WarningPreference = "Continue"

# Set TLS to accept TLS, TLS 1.1 and TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12

try {
    $actionMessage = "updating AD account expiration date for user [$($user.UserPrincipalName)] with objectguid [$($user.ObjectGuid)]"

    # Determine the expiration date value
    if ($blnExpDate -ne 'true') {
        $newExpDate = $null
    }
    else {
        # Convert to DateTime and get only the date part (strips time)
        # Then add 1 day to ensure account works the whole selected day
        # Result: Account expires at 00:00:00 on the day AFTER the selected date
        $newExpDate = ([Datetime]$expireDate).Date.AddDays(1)
    }

    $splatSetADAccountExpirationParams = @{
        Identity = $user.ObjectGuid
        DateTime = $newExpDate
    }
    
    $null = Set-ADAccountExpiration @splatSetADAccountExpirationParams
    
    $Log = @{
        Action            = "UpdateAccount" # optional. ENUM (undefined = default) 
        System            = "ActiveDirectory" # optional (free format text) 
        Message           = "Successfully updated account expiration date for AD user [$($user.UserPrincipalName)] to [$newExpDate]" # required (free format text) 
        IsError           = $false # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
        TargetDisplayName = $user.UserPrincipalName # optional (free format text) 
        TargetIdentifier  = $user.ObjectGuid # optional (free format text) 
    }
    #send result back  
    Write-Information -Tags "Audit" -MessageData $log    
}
catch {
    $ex = $PSItem
    $auditMessage = "Error $($actionMessage). Error: $($ex.Exception.Message)"
    $warningMessage = "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"    

    $Log = @{
        Action            = "UpdateAccount" # optional. ENUM (undefined = default) 
        System            = "ActiveDirectory" # optional (free format text) 
        Message           = "Error $($actionMessage). Error Message: $auditMessage" # required (free format text) 
        IsError           = $true # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
        TargetDisplayName = $user.UserPrincipalName # optional (free format text) 
        TargetIdentifier  = $user.ObjectGuid # optional (free format text) 
    }
    #send result back  
    Write-Information -Tags "Audit" -MessageData $log      
    Write-Warning $warningMessage   
    Write-Error $auditMessage
}
