# Terraform State
- Terraform must store state about your managed infrastructure and configuration
- This state is used by Terraform to map real world resources to your configuration (.tf files), keep track of metadata, and to improve performance for large infrastructures
- This state is stored by default in a local file named "terraform.tfstate", but it can also be stored remotely, which works better in a team environment.
- The primary purpose of Terraform state is to store bindings between objects in a remote system and resource instances declared in your configuration.
- When Terraform creates a remote object in response to a change of configuration, it will record the identity of that remote object against a particular resource instance, and then potentially update or delete that object in response to future configuration changes
## Resource Behavior
- Terraform Resource
  + `Create Resource`: Create resources that exist in the configuration but are `not associated` with a real infrastructure object in the state.
  + `Destroy Resource`: Destroy resources that `exist in the state` but no longer exist in the configuration
  + `Update in-place Resources`: Update `in-place resources` whose arguments have changed
  + `Destroy and re-create`: Destroy and re-create resources whose arguments have changed but which cannot be updated in-place due to remote API limitations