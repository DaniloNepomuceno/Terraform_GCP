variable "gcp_project" {
    default = "sturdy-index-323220"
}

variable "gcp_region" {
    default = "southamerica-east1"
}

variable "gcp_zone" {
    default = "southamerica-east1-a"
}

variable "vpc_name" {
    default = "loca-wep-app-vpc-qas"
}

variable "subnetwork_name" {
    default = "loca-wep-app-subnetwork-qas"
}

variable "tunnel_name" {
    default = "tunnel-gcp-to-aws"
}

variable "gateway_name" {
    default = "gateway-tunnel-gcp-to-aws"
}

variable "vpn_static_ip_name" {
    default = "vpn-static-ip"
}

variable "aws_ipaddr" {
    default = "18.229.88.89"
}