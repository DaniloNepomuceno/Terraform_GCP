resource "google_compute_instance" "instance-web-app-qas" {
  depends_on   = [var.subnetwork_name]
  name         = "instance-web-app-qas"
  machine_type = "n2-standard-2"
  zone         = var.gcp_zone
 

  tags = ["allow-ssh"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20210702"
      size  =  "15"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = var.vpc_name
    subnetwork  = var.subnetwork_name
    access_config {
      nat_ip = google_compute_address.ip_address.address
    }
  }
}