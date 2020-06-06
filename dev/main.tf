provider "azurerm" {
    version = "~>2.0"
    features {}
}

module "my_rsgp" {
  source = "../modules/resource_group"
  rsgp_name = var.name
  rsgp_location = var.location
  rsgp_tag = var.tag
  
 

}

module "my_vnet" {
source = "../modules/vnet"
vnet_name = "${var.name}_vnet"
vnet_location = var.location
rsgp_name = var.name
vnet_tag = var.tag
subnet_name = "${var.name}_subnet"

}

module "my_vm" {
source = "../modules/vm"
ssh_port_no = 5252
nsgp_location = var.location
nsgp_name = "${var.name}_nsgp"
azni_name = "${var.name}_azni"
rsgp_name =  var.name
subn_id = "${module.my_vnet.sub_id}"
rsgp_tag = var.tag

}

module "my_dashboard" {
  source = "../modules/dashboard"
  rsgp_name = var.name
  vi_id = "${module.my_vm.vm_id}"
  email_id = "prashantrakh20@rediffmail.com"
  rs_id = "${module.my_vm.vm_id}"


  
  
}









