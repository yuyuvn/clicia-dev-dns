workflow "Deploy workflow" {
  on = "push"
  resolves = [
    "Deploy 2",
    "Deploy 1",
  ]
}

action "Master" {
  uses = "actions/bin/filter@d820d56839906464fb7a57d1b4e1741cf5183efa"
  args = "branch master"
}

action "GitHub Action for Google Cloud SDK auth" {
  uses = "actions/gcloud/auth@1a017b23ef5762d20aeb3972079a7bce2c4a8bfe"
  needs = ["Master"]
  secrets = ["GCLOUD_AUTH"]
}

action "Deploy 1" {
  uses = "actions/gcloud/cli@1a017b23ef5762d20aeb3972079a7bce2c4a8bfe"
  needs = ["GitHub Action for Google Cloud SDK auth"]
  args = "compute --project ria-scarlet-191001 ssh --zone us-east1-b coredns --command 'rm -rf clicia-dev-dns; git clone https://github.com/yuyuvn/clicia-dev-dns.git; cd clicia-dev-dns; make deploy'"
}

action "Deploy 2" {
  uses = "actions/gcloud/cli@1a017b23ef5762d20aeb3972079a7bce2c4a8bfe"
  needs = ["GitHub Action for Google Cloud SDK auth"]
  args = "compute --project clicia-dns ssh --zone us-west1-b dns --command 'rm -rf clicia-dev-dns; git clone https://github.com/yuyuvn/clicia-dev-dns.git; cd clicia-dev-dns; make deploy'"
}
