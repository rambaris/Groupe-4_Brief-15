output "Cle_publique" {
  value     = module.ModuleEnfant.pub
  sensitive = true
}

output "Cle_privee" {
    value   = module.ModuleEnfant.private
    sensitive = true
}
