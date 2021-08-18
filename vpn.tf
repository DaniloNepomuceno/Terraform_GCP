resource "google_compute_vpn_tunnel" "tunnel-gcp-to-aws" {
  name          = var.tunnel_name
  peer_ip       = var.aws_ipaddr
  shared_secret = "BfrSJsQegdgrULYDgKRIK_UhavN7_8q_"

  target_vpn_gateway = google_compute_vpn_gateway.gateway-tunnel-gcp-to-aws.id
  local_traffic_selector = ["40.40.40.0/24"]
  remote_traffic_selector = ["30.30.30.0/24"]

  depends_on = [
    google_compute_forwarding_rule.fr_esp,
    google_compute_forwarding_rule.fr_udp500,
    google_compute_forwarding_rule.fr_udp4500,
  ]
}

resource "google_compute_vpn_gateway" "gateway-tunnel-gcp-to-aws" {
  name    = var.gateway_name
  network = var.vpc_name
}

resource "google_compute_address" "vpn_static_ip" {
  name = var.vpn_static_ip_name
}

resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "fr-esp"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.gateway-tunnel-gcp-to-aws.id
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.gateway-tunnel-gcp-to-aws.id
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.gateway-tunnel-gcp-to-aws.id
}

resource "google_compute_route" "route1" {
  name       = "route1"
  network    = var.vpc_name
  dest_range = "30.30.30.0/24"
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel-gcp-to-aws.id
}