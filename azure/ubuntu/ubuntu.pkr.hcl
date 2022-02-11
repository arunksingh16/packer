source "azure-arm" "my-example" {
  client_id           = "${var.client_id}"
  client_secret       = "${var.client_secret}"

  tenant_id           = "${var.tenant_id}"
  subscription_id     = "${var.subscription_id}"

  #################### VHD Options ####################
  #resource_group_name = "${var.resource_grp}"
  #storage_account     = "${var.storage_accnt}"
  #capture_container_name = "images"
  #capture_name_prefix    = "packer"
  #####################################################

  # Specify the managed image name where the result of the Packer build will be saved. 
  # The image name must not exist ahead of time
  # Managed Image options
  managed_image_name                 = "${var.managed_image_name}"
  managed_image_resource_group_name  = "${var.resource_grp}"
  managed_image_storage_account_type = "Standard_LRS"

  os_type = "Linux"
  # az vm image list-publishers --location westus
  image_publisher = "Canonical"
  # az vm image list-offers --location westus --publisher Canonical
  image_offer = "UbuntuServer"
  # az vm image list-skus --location westus --publisher Canonical --offer UbuntuServer
  image_sku = "18.04-LTS"
  # To have Packer create a resource group you must provide: az account list-locations
  location = "East US"
  # name assigned to the temporary resource group created during the build. If this value is not set, a random value will be assigned
  temp_resource_group_name = "rg-tmp-packer"
  vm_size                  = "Standard_DS2_v2"
  shared_image_gallery_destination {
    subscription         = "${var.subscription_id}"
    resource_group       = "${var.resource_grp}"
    gallery_name         = "PackerGallery"
    image_name           = "PackerPOC"
    image_version        = "1.0.0"
    replication_regions  = ["eastus", "eastus2", "southcentralus"]
    storage_account_type = "Standard_LRS"
  }
  azure_tags = {
    app  = "packer"
    type = "images"
  }
}

build {
  sources = ["sources.azure-arm.my-example"]
  provisioner "file" {
    source      = "web_assets"
    destination = "/tmp"
  }

}
