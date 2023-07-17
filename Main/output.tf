output "Cle_publique" {
  value     = module.ModuleEnfant.pub
  sensitive = true
}

output "Cle_privee" {
    value   = module.ModuleEnfant.private
    sensitive = true
}

output "IP_worker_0" {
  value = module.ChildResources.IP_pub_worker_0
}

output "IP_worker_1" {
  value = module.ChildResources.IP_pub_worker_1
}

output "IP_manager" {
  value = module.ChildResources.IP_pub_manager
}
