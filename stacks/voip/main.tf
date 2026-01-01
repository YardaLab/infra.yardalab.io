module "voip_server" {
  source = "git::https://github.com/YardaLab/infra.yardalab.io.git//modules/voip-server?ref=v0.1.0-voip"

  name          = var.name
  environment   = var.environment
  region        = var.region
  instance_type = var.instance_type
  image         = var.image

  hostname    = var.hostname
  enable_ipv6 = var.enable_ipv6
  tags        = var.tags
}
