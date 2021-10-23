resource "aci_rest" "maintMaintP" {
  dn         = "uni/fabric/maintpol-${var.name}"
  class_name = "maintMaintP"
  content = {
    name      = var.name
    adminSt   = "untriggered"
    graceful  = "no"
    notifCond = "notifyOnlyOnFailures"
    runMode   = "pauseOnlyOnFailures"
  }
}

resource "aci_rest" "maintRsPolScheduler" {
  dn         = "${aci_rest.maintMaintP.dn}/rspolScheduler"
  class_name = "maintRsPolScheduler"
  content = {
    tnTrigSchedPName = "default"
  }
}

resource "aci_rest" "maintMaintGrp" {
  dn         = "uni/fabric/maintgrp-${var.name}"
  class_name = "maintMaintGrp"
  content = {
    name = var.name
    type = "range"
  }
}

resource "aci_rest" "maintRsMgrpp" {
  dn         = "${aci_rest.maintMaintGrp.dn}/rsmgrpp"
  class_name = "maintRsMgrpp"
  content = {
    tnMaintMaintPName = var.name
  }
}

resource "aci_rest" "fabricNodeBlk" {
  for_each   = toset([for id in var.node_ids : tostring(id)])
  dn         = "${aci_rest.maintMaintGrp.dn}/nodeblk-${each.value}"
  class_name = "fabricNodeBlk"
  content = {
    name  = each.value
    from_ = each.value
    to_   = each.value
  }
}
