# Workshop Configuration Changes

This document outlines infrastructure changes made for workshop convenience. These modifications prioritize ease of use over production security and should be reverted after the workshop.

## Changes Made

### 1. Network Security Group (NSG) Rules
- **Added**: Outbound internet access for package downloads (pip, conda)
- **Added**: Inbound/outbound Azure services communication
- **Location**: `terraform/modules/networking/main.tf`

### 2. Storage Account Access
- **Changed**: Default action from "Deny" to "Allow" 
- **Impact**: Removes restrictive network policies
- **Location**: `terraform/modules/storage/main.tf`

### 3. Production Environment
- **Changed**: `public_network_access_enabled = true`
- **Impact**: Enables cross-environment model promotion demos
- **Location**: `terraform/environments/prod/main.tf`

### 4. Registry Permissions
- **Added**: `AzureML Registry User` role for test/prod environments
- **Added**: `Contributor` role for all environments
- **Impact**: Enables seamless model promotion workflow
- **Location**: `terraform/modules/registry_connection/main.tf`

### 5. Subnet Service Endpoints
- **Added**: `Microsoft.MachineLearningServices` endpoint
- **Impact**: Improved ML service connectivity
- **Location**: `terraform/modules/networking/main.tf`

## Post-Workshop Actions

After the workshop, consider reverting these changes for production environments:
- Restore restrictive storage network policies
- Disable public network access in production
- Remove broad registry permissions
- Review NSG rules for minimal required access

All workshop changes are marked with `# WORKSHOP:` comments in the code.