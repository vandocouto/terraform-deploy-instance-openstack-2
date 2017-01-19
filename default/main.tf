
// resource da rede pública
resource "openstack_compute_floatingip_v2" "externa" {
  pool = "externa"
}

// resource do disco 2
resource "openstack_blockstorage_volume_v2" "volume_1" {
  region = "${var.region}"
  size = 50
  image_id = "${var.imagem_id}"
}

// resource da instância
resource "openstack_compute_instance_v2" "terraform-openstack" {
  image_name = "${var.image}"
  flavor_name = "${var.flavor}"
  key_pair = "${var.key_pair}"
  count = "${var.instancia}"
  name = "${format("terraform-openstack-%02d", (count.index + 1))}"
  floating_ip = "${openstack_compute_floatingip_v2.externa.address}"

  // network
  network {
    name = "network_internal"
    uuid = "${var.network_uuid}"
  }

  // security group
  security_groups = [
    "${var.security_group}"]

  // criando o primeiro disco e atrelando a imagem nele
  block_device {
    uuid = "${openstack_blockstorage_volume_v2.volume_1.id}"
    source_type = "volume"
    boot_index = 0
    destination_type = "volume"
    delete_on_termination = true
  }

  // criando um segundo disco
  block_device {
    source_type = "blank"
    destination_type = "volume"
    boot_index = 1
    volume_size = 50
    delete_on_termination = true
  }

  // informando o local e qual a chave key-pair
  provisioner "remote-exec" {
    connection {
      user = "${var.ssh_user_name}"
      private_key = "${file(var.ssh_key_file)}"
    }

    // ajustando o hostname da instância no /etc/hosts
    inline = [
      "sudo sed -i s/'127.0.0.1 localhost'/'127.0.0.1 localhost ${self.name}'/g /etc/hosts"
    ]
  }
}

// recebendo qual o ip público a instância recebeu
output "floating_public_ip" {
  value = "${openstack_compute_instance_v2.terraform-openstack.0.floating_ip}"
}


