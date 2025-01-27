### Environments are where code is deployed and executed for a specific purpose.

### Each environment will have its own access control, networking, configuration,and dependencies.

### Factors for picking environment granularity are release independence, testboundary, access control, and isolation.

### The Kubernetes Namespace is a natural construct to implement an environment.

### Since a namespace is equivalent to an environment, deploying to a specific environment is merely specifying the namespace.

### Inter-environment traffic can be controlled by network policy.

### Preprod and prod should follow the same security best practices and operationvigor.

### Separation of the Git repo for Kubernetes manifest and the Git repo for code ishighly recommended to allow codes changes.

### A single branch works well with tooling like Kustomize for overlay.

### Monorepo for config works well for startups; multirepo works well for large enterprises.

### Helm is a package manager.

### Kustomize is a built-in config management tool, part of kubectl.

### Choosing the right config management tools should be based on the following criteria: declarative, maintainability,readability, flexibility

### Durable environments are always on for others to use, and ephemeral environ-ments are for short-lived testing previewing.

