script "terraform" "init" {
  name        = "Terraform Init"
  description = "Download all Terraform providers and module."

  job {
    commands = [
      ["terraform", "init", "-lock-timeout=5m"],
    ]
  }
}
