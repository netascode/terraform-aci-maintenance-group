module "aci_maintenance_group" {
  source = "netascode/maintenance-group/aci"

  name     = "UG1"
  node_ids = [101]
}
