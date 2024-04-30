script "terraform" "drift" "detect" {
  name        = "Terraform Drift Check"
  description = "Detect drifts in Terraform configuration and synchronize it to Terramate Cloud."

  job {
    commands = [
      ["terraform", "plan", "-out", "drift.tfplan", "-detailed-exitcode", "-lock=false", {
        cloud_sync_drift_status        = true
        cloud_sync_terraform_plan_file = "drift.tfplan"
      }],
    ]
  }
}

script "terraform" "drift" "reconcile" {
  name        = "Terraform Drift Reconciliation"
  description = "Reconciles drifts in all changed stacks."

  job {
    commands = [
      ["terraform", "plan", "-out", "drift.tfplan", "-detailed-exitcode", "-lock=false", {
        cloud_sync_drift_status        = true
        cloud_sync_terraform_plan_file = "drift.tfplan"
      }],
    ]
  }
}
