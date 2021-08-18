provider "google" {
  credentials = "service-account-loca.json"
  project = var.gcp_project
  region  = var.gcp_region
}