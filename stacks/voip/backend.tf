terraform {
  cloud {
    organization = "YardaLab"

    workspaces {
      tags = ["infra", "voip"]
    }
  }
}
