resource "linode_stackscript" "plantuml" {
  label       = "plantuml-bootstrap"
  description = "Install Docker and run PlantUML server."
  script      = file("${path.module}/stackscript.sh")
  images      = ["linode/ubuntu22.04"]
}

resource "linode_instance" "plantuml" {
  label     = "plantuml-server"
  region    = "eu-central"
  type      = "g6-nanode-1"
  image     = "linode/ubuntu22.04"
  root_pass = var.root_password

  stackscript_id   = linode_stackscript.plantuml.id
  stackscript_data = {}
}

