# Use by the aws_vpc_peering_connection_accepter
provider "aws" {
  alias = "peer"
}

# Used by the aws_vpc_peering_connection
provider "aws" {
}


# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = "${var.my_vpcid}"
  peer_vpc_id   = "${var.peer_vpcid}"
  peer_owner_id = "${var.peer_vpc_owner_id}"
  peer_region = "${var.peer_vpc_region}"
  auto_accept   = false

  tags = "${var.common_tags}"
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = "aws.peer"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags = "${var.common_tags}"
}