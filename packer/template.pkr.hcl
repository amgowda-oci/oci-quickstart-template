
variable "availibilty_domain" {
  type    = string
  default = "${env("PACKER_availibilty_domain")}"
}

variable "base_image_ocid" {
  type    = string
  default = "ocid1.image.oc1.iad.aaaaaaaa6tp7lhyrcokdtf7vrbmxyp2pctgg4uxvt4jz4vc47qoc2ec4anha"
}

variable "compartment_ocid" {
  type    = string
  default = "${env("PACKER_compartment_ocid")}"
}

variable "my_secret" {
  type    = string
  default = "${env("PACKER_my_secret")}"
}

variable "shape" {
  type    = string
  default = "VM.Standard2.1"
}

variable "ssh_username" {
  type    = string
  default = "opc"
}

variable "subnet_ocid" {
  type    = string
  default = "${env("PACKER_subnet_ocid")}"
}

variable "type" {
  type    = string
  default = "oracle-oci"
}

source "oracle-oci" "autogenerated_1" {
  availability_domain = "${var.availibilty_domain}"
  base_image_ocid     = "${var.base_image_ocid}"
  compartment_ocid    = "${var.compartment_ocid}"
  shape               = "${var.shape}"
  ssh_username        = "${var.ssh_username}"
  subnet_ocid         = "${var.subnet_ocid}"
}

build {
  sources = ["source.oracle-oci.autogenerated_1"]

  provisioner "shell" {
    expect_disconnect = "true"
    inline            = ["cd ~", "echo Hello World!", "echo ${var.my_secret} > /dev/null", "touch foobar.txt"]
  }

  provisioner "shell" {
    script = "installer.sh"
  }

  provisioner "shell" {
    script = "cleanup.sh"
  }

}
