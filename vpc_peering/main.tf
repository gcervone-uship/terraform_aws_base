# Use by the aws_vpc_peering_connection_accepter
provider "aws" {
  alias = "peer"
}

# Used by the aws_vpc_peering_connection
provider "aws" {
}


# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  count = "${var.enable_vpc_peering}"

  vpc_id        = "${var.my_vpcid}"
  peer_vpc_id   = "${var.peer_vpcid}"
  peer_owner_id = "${var.peer_vpc_owner_id}"
  peer_region = "${var.peer_vpc_region}"
  auto_accept   = false

  tags = "${var.common_tags}"
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  count = "${var.enable_vpc_peering}"

  provider                  = "aws.peer"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags = "${var.common_tags}"
}

#
# Populate our routing tables with routes to peer
#
resource "aws_route" "local_to_peer" {
  count = "${var.enable_vpc_peering_route_table_updates ? length(var.my_public_route_table_ids) : 0}"
  route_table_id            = "${element(var.my_public_route_table_ids, count.index)}"
  destination_cidr_block    = "${var.peer_vpc_cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}


#
# Populate peer's routing tables with routes to us
#
resource "aws_route" "peer_to_local" {
  count = "${var.enable_vpc_peering_route_table_updates ? var.peer_public_route_table_ids_count : 0}"

  provider = "aws.peer"

  route_table_id            = "${element(var.peer_public_route_table_ids, count.index)}"
  destination_cidr_block    = "${var.my_vpc_cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}