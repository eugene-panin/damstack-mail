output "dns_records" {
  description = "DNS records of the mail server and of every domain, keyed by domain; the platform publishes them."
  value = merge(module.mail.dns_records, {
    (local.mail.hostname) = [{ type = "A", name = local.mail.hostname, content = var.server_address, priority = null, comment = "Mail server" }]
  })
}

output "mailboxes" {
  description = "Mailboxes and the aliases each one receives."
  value       = module.mail.mailboxes
}

output "passwords" {
  description = "Password of each mailbox."
  value       = module.mail.passwords
  sensitive   = true
}
