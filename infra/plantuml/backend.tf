terraform {
  cloud {
    organization = "YardaLab"

    workspaces {
      name = "infra"
    }
  }
}
