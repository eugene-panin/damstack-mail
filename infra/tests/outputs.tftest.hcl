mock_provider "nomad" {}
mock_provider "vault" {}
mock_provider "random" {}
mock_provider "tls" {}

variables {
  project          = "/work"
  state_passphrase = "a passphrase for the test only"
  vault_kv_path    = "secret"
  server_address   = "192.0.2.10"
}

run "the_mail_server_and_every_domain_get_their_records" {
  command = apply

  assert {
    condition     = sort(keys(output.dns_records)) == sort(["example.net", "example.org", "mail.example.org"])
    error_message = "The records are not keyed by the domains and the mail server."
  }

  assert {
    condition = output.dns_records["mail.example.org"] == [
      { type = "A", name = "mail.example.org", content = "192.0.2.10", priority = null, comment = "Mail server" },
    ]
    error_message = "The name of the mail server does not point at the server."
  }

  assert {
    condition = alltrue([for d in ["example.org", "example.net"] : anytrue([
      for r in output.dns_records[d] : r.type == "MX" && r.name == d && r.content == "mail.example.org" && r.priority == 10
    ])])
    error_message = "A domain has no MX to the mail server."
  }

  assert {
    condition     = sort(keys(output.mailboxes)) == sort(["info@example.net", "info@example.org", "sales@example.net", "sales@example.org"])
    error_message = "The mailboxes are not those of stack.yaml."
  }
}
