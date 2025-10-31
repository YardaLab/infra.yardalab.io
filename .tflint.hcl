config {
  format = "compact"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}
