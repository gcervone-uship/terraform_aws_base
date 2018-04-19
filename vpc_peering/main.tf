##############################################################################
#                                                                            #
#                        SETUP VPC PEERING BOTH SIDES                        #
#                                                                            #
##############################################################################

#
# Requester's side of the connection.
#
provider "aws" {
  alias = "peer"
}

resource "aws_vpc_peering_connection" "peer" {
  count = "${var.enable_vpc_peering}"

  vpc_id        = "${var.my_vpcid}"
  peer_vpc_id   = "${var.peer_vpcid}"
  peer_owner_id = "${var.peer_vpc_owner_id}"
  peer_region   = "${var.peer_vpc_region}"
  auto_accept   = false

  tags = "${var.common_tags}"
}

#
# Accepter's side of the connection.
#
provider "aws" {}

resource "aws_vpc_peering_connection_accepter" "peer" {
  count = "${var.enable_vpc_peering}"

  provider                  = "aws.peer"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags = "${var.common_tags}"
}

##############################################################################
#                                                                            #
#                          POPULATE ROUTING TABLES                           #
#                                                                            #
##############################################################################

locals {
  my_route_table_ids         = "${concat(var.my_private_route_table_ids, var.my_public_route_table_ids)}"
  my_route_table_ids_count   = "${var.my_private_route_table_ids_count + var.my_public_route_table_ids_count}"
  peer_route_table_ids       = "${concat(var.peer_private_route_table_ids, var.peer_public_route_table_ids)}"
  peer_route_table_ids_count = "${var.peer_private_route_table_ids_count + var.peer_public_route_table_ids_count}"

  # Workaround below needed because resource may have count=0 -- https://www.terraform.io/upgrade-guides/0-11.html#referencing-attributes-from-resources-with-count-0
  vpc_peering_connection_id = "${element(concat(aws_vpc_peering_connection.peer.*.id, list("")), 0)}"
}

#
# Populate our routing tables with routes to peer
#
resource "aws_route" "local_to_peer" {
  count                     = "${var.enable_vpc_peering_route_table_updates ? local.my_route_table_ids_count : 0}"
  route_table_id            = "${element(local.my_route_table_ids, count.index)}"
  destination_cidr_block    = "${var.peer_vpc_cidr_block}"
  vpc_peering_connection_id = "${local.vpc_peering_connection_id}"

  timeouts {
    create = "5m"
  }
}

#
# Populate peer's routing tables with routes to us
#
resource "aws_route" "peer_to_local" {
  count = "${var.enable_vpc_peering_route_table_updates ? local.peer_route_table_ids_count : 0}"

  provider = "aws.peer"

  route_table_id            = "${element(local.peer_route_table_ids, count.index)}"
  destination_cidr_block    = "${var.my_vpc_cidr_block}"
  vpc_peering_connection_id = "${local.vpc_peering_connection_id}"

  timeouts {
    create = "5m"
  }
}
