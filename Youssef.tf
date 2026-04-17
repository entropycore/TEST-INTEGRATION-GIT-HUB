
echo test test salamo ealaykom khoty

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

resource "null_resource" "vm1" {
  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]

    command = <<EOT
$VBox = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

& $VBox createvm --name VM1-DevOps --register
& $VBox modifyvm VM1-DevOps --memory 2048 --cpus 2
& $VBox createmedium disk --filename VM1.vdi --size 25000
& $VBox storagectl VM1-DevOps --name "SATA Controller" --add sata
& $VBox storageattach VM1-DevOps --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium VM1.vdi
& $VBox startvm VM1-DevOps
EOT
  }
}

