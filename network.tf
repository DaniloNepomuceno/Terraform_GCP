resource "google_compute_network" "loca-wep-app-vpc-qas" {
  name = var.vpc_name
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "loca-wep-app-subnetwork-qas" {
  depends_on    = [var.vpc_name]
  name          = "loca-wep-app-subnetwork-qas"
  ip_cidr_range = "40.40.40.0/24"
  region        = var.gcp_region
  network       = var.vpc_name
}

resource "google_compute_address" "ip_address" {
  name = "ip-address"
}