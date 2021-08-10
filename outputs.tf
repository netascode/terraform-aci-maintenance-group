output "dn" {
  value       = aci_rest.maintMaintGrp.id
  description = "Distinguished name of `maintMaintGrp` object."
}

output "name" {
  value       = aci_rest.maintMaintGrp.content.name
  description = "Maintenance group name."
}
