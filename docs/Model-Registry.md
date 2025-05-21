# Azure ML Model Registry and Feature Store Setup

This document describes the setup and architecture of the centralized Model Registry and Feature Store used in the MLOps Accelerator.

## Model Registry

### Purpose
The Model Registry provides a central repository for storing, versioning, and managing ML models across all environments. It enables governance, lineage tracking, and promotes models through environments.

### Implementation
The Model Registry is provisioned in the shared environment and accessed by all other environments (dev, test, prod). This is implemented as an Azure ML Registry resource with appropriate permissions:

- **Shared environment**: Hosts the central Model Registry
- **Other environments**: Connect to the shared registry via registry connections
- **Permissions**: Dev can register, all environments can read

### Architecture Diagram
```
Dev Environment    ------> Shared Environment <------    Prod Environment
  ML Workspace              Model Registry              ML Workspace
  (Register/Read)          (Central Storage)           (Read Only)
```

## Feature Store

### Purpose
The Feature Store provides a centralized repository for storing, discovering and serving machine learning features. It ensures consistency of features across training and inference pipelines.

### Implementation
The Feature Store is provisioned as a specialized Azure ML workspace with `kind=FeatureStore` in the shared environment:

- **Shared environment**: Hosts the central Feature Store
- **Offline Storage**: Configured for batch feature access
- **Spark Runtime**: Uses Spark 3.3 for feature computation
- **Access**: Available to all environments with appropriate permissions

### Key Capabilities
- Feature registration and discovery
- Centralized feature definitions
- Time-travel capabilities for point-in-time correct training
- Batch feature serving for model training
