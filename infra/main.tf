locals {
  stack = yamldecode(file("${var.project}/stack.yaml"))
  mail  = local.stack.apps.mail
}

module "mail" {
  source  = "eugene-panin/stalwart/nomad"
  version = "~> 0.1"

  hostname      = local.mail.hostname
  domains       = local.mail.domains
  mailboxes     = try(local.mail.mailboxes, ["info"])
  acme_email    = try(local.mail.acme_email, local.stack.acme_email)
  vault_kv_path = var.vault_kv_path
}
