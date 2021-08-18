resource "google_compute_firewall" "firewall-rule-allow-ssh" {
  depends_on    = [var.vpc_name]
  name    = "allow-ssh"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["22","80"]
  }

  target_tags = ["allow-ssh"]
}