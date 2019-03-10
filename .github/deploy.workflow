workflow "Deploy workflow" {
  on = "push"
  resolves = ["Deploy"]
}

action "Master" {
  uses = "actions/bin/filter@d820d56839906464fb7a57d1b4e1741cf5183efa"
  args = "branch master"
}

action "Test" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  runs = "make"
  args = "test"
}

action "Filter" {
  uses = "actions/bin/filter@d820d56839906464fb7a57d1b4e1741cf5183efa"
  needs = ["Test"]
  args = "branch master"
}

action "GitHub Action for Google Cloud SDK auth" {
  uses = "actions/gcloud/auth@1a017b23ef5762d20aeb3972079a7bce2c4a8bfe"
  needs = ["Filter"]
  secrets = ["GCLOUD_AUTH"]
}

action "Deploy" {
  uses = "actions/gcloud/cli@1a017b23ef5762d20aeb3972079a7bce2c4a8bfe"
  needs = ["GitHub Action for Google Cloud SDK auth"]
  args = "compute ssh --project ria-scarlet-191001 --zone asia-northeast1-b instance-1 --command 'rm -rf clicia-dev-dns; git clone https://github.com/yuyuvn/clicia-dev-dns.git; cd clicia-dev-dns; make deploy'"
}
