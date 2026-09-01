# Change Log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com), and this project adheres to [Semantic Versioning](https://semver.org).

## [2.0.0] - 2026-08-11

### Added
- Added comprehensive audit logging for all account expiration operations
- Added detailed error handling and logging with line number information
- Added TLS protocol configuration (TLS 1.0, 1.1, 1.2) for secure connections
- Added user search across multiple attributes (Name, DisplayName, UserPrincipalName, Mail)
- Added improved date handling logic to ensure account works the whole selected day
- Added comprehensive configuration files for all data sources and tasks
- Added GitHub workflows for creating releases and verifying changelog

### Changed
- **BREAKING**: Refactored task script to use ObjectGuid for reliable user identification instead of UserPrincipalName
- **BREAKING**: Renamed data source files with more descriptive naming convention including "AD - Account - Update account expires" prefix
- **BREAKING**: Renamed task file from `[task]_AD Account - Update account expires.ps1` to `[task]_AD - Account - Update account expires.ps1`
- Updated task to use ObjectGuid as TargetIdentifier instead of SID for improved reliability
- Enhanced error messages with detailed context including line numbers and user information
- Improved form task to log all errors to HelloID audit system with structured logging
- Updated data sources with improved error handling and verbose logging
- Refactored user search functionality with wildcard support across multiple AD attributes
- Updated README with comprehensive documentation including requirements, connection settings, and development resources
- Converted GitHub callout syntax to table format for better compatibility with text editors
- Improved documentation structure for clarity and consistency
- Updated all-in-one setup script with new resource naming and structure
- Updated manual resources with enhanced PowerShell scripts
- Improved dynamic form configuration to reflect enhanced user search and expiration functionalities

### Removed
- Removed obsolete data source files for basic user attribute queries
- Removed legacy wildcard search PowerShell script
- Removed redundant Get-ADUser lookup (now using ObjectGuid directly from form data)

### Fixed
- Fixed account expiration operations to use ObjectGuid instead of UserPrincipalName for reliable identification
- Fixed date handling to ensure account remains active for the entire selected expiration date

## [1.0.2] - 2022-08-02

### Added
- Added version number to the release
- Updated with audit logging capabilities to track all changes made to AD account expiration dates

### Changed
- Updated with code for SA agent support

## [1.0.1] - 2021-11-03

### Added
- Added version number to the release

### Changed
- Updated all-in-one setup script

## [1.0.0] - 2020-09-07

### Added
- Initial release of HelloID-Conn-SA-Full-AD-AccountUpdateExpireDate
- AD account expiration date management functionality
- Search and select target AD user account
- View basic AD user account attributes
- Enable or disable account expiration
- Specify account expiration date
- Update AD user account expiration date
