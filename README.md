# HelloID-Conn-SA-Full-AD-AccountUpdateExpireDate

| :information_source: Information |
|:---|
| This repository contains the connector and configuration code only. The implementer is responsible for acquiring the connection details such as username, password, certificate, etc. You might even need to sign a contract or agreement with the supplier before implementing this connector. Please contact the client's application manager to coordinate the connector requirements. |

## Description
_HelloID-Conn-SA-Full-AD-AccountUpdateExpireDate_ is a delegated form designed for use with HelloID Service Automation (SA). It can be imported into HelloID and customized according to your requirements.

By using this delegated form, you can manage Active Directory account expiration dates. The following options are available:

1. Search for and select the target Active Directory (AD) user account by Name, DisplayName, UPN, or Mail address.
2. View basic attributes of the selected AD user account.
3. View the current account expiration status and date.
4. Enable or disable account expiration and specify a new expiration date with comprehensive audit logging.

## Getting started

### Requirements

• **Active Directory Access**:
  The connector requires access to an Active Directory domain with sufficient permissions to modify account expiration settings. A service account with appropriate AD permissions is necessary.

• **HelloID Agent**:
  A HelloID Agent must be installed and configured to communicate with the Active Directory domain.

• **PowerShell module 'ActiveDirectory'**:
  The HelloID Agent must have PowerShell available with Active Directory module support.

### Connection settings

The following user-defined variables are used by the connector.

| Setting | Description | Mandatory |
|---------|-------------|-----------|
| ADusersSearchOU | Array of Active Directory OUs for scoping AD user accounts in the search result of this form | Yes |

## Remarks

### User Search

• **Search Functionality:** Users can search for accounts using a wildcard (`*`) to return all users within the specified OUs, or by entering partial text to search across Name, DisplayName, UserPrincipalName, and Mail attributes.

• **The search scope is limited to the OUs defined in the `ADusersSearchOU` variable.**

### Account Expiration

• **Date Format:** The form uses DateTime picker for selecting expiration dates.

• **Clearing Expiration:** To set an account to never expire, disable the account expiration toggle.

• **Immediate Effect:** Changes to account expiration take effect immediately in Active Directory.

## Development resources

### PowerShell Module
This connector uses the ActiveDirectory PowerShell module for managing Active Directory user account expiration settings.

- [ActiveDirectory Module Documentation](https://learn.microsoft.com/en-us/powershell/module/activedirectory/)

### Cmdlets
The following PowerShell cmdlets are used by the connector:

| Cmdlet | Description |
| --- | --- |
| Get-ADUser | Retrieves Active Directory user accounts |
| Set-ADUser | Modifies Active Directory user account properties |
| Set-ADAccountExpiration | Sets the expiration date for an Active Directory account |

### Cmdlet documentation
- [Get-ADUser](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-aduser)
- [Set-ADUser](https://learn.microsoft.com/en-us/powershell/module/activedirectory/set-aduser)
- [Set-ADAccountExpiration](https://learn.microsoft.com/en-us/powershell/module/activedirectory/set-adaccountexpiration)

## Getting help

| :bulb: Tip |
|:---|
| For more information on Delegated Forms, please refer to our [documentation](https://docs.helloid.com/en/service-automation/delegated-forms.html) pages. |

## HelloID docs
The official HelloID documentation can be found at: [https://docs.helloid.com/](https://docs.helloid.com/)
