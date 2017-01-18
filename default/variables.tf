// variaveis

// quantas instâncias serão criadas
variable "instancia" {
 default = 1
}

// qual imagem será usada
variable "image" {
  default = "ubuntu16"
}

// id da imagem
variable "imagem_id" {
  default = "860338bb-fc63-4124-8973-4f238fa379df"
}

// flavor
variable "flavor" {
  default = "m2.medium"
}

// região
variable "region" {
  default = "RegionOne"
}

// key_pair (chave)
variable "key_pair" {
  default = "infra"
}

// security group
variable "security_group" {
  default = "default"
}

/*variable "floating_ip" {
  default = "192.168.3.153"
}*/

// network-id
variable "network_uuid" {
  default = "db4d047e-2ae2-4bf7-8323-668de66275b3"
}

// usuario default para o ssh (ubuntu)
variable "ssh_user_name" {
  default = "ubuntu"
}

// local da chave key-pair
variable "ssh_key_file" {
  default = "../chave/infra.pem"
}

// id do external GW do projeto no Openstack
variable "external_gateway" {
  default = "11702078-9429-4ada-bf84-d9166bd368f8"
}






