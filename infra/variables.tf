variable "project" {
  description = "Directory of the project: the settings of the app are under apps.mail of its stack.yaml. damstack sets it."
  type        = string
}

variable "state_passphrase" {
  description = "Passphrase the state and plans are encrypted with; the platform gives it."
  type        = string
  sensitive   = true
}

variable "vault_kv_path" {
  description = "Path of the Vault KV engine the jobs keep their secrets in; the platform gives it."
  type        = string
}

variable "server_address" {
  description = "Public address of the server, which the name of the mail server points at."
  type        = string
}
