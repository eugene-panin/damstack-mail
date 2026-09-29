package terraform

import rego.v1

protected_types := {"nomad_dynamic_host_volume", "nomad_csi_volume", "vault_kv_secret_v2"}

default allow_destroy := []

allow_destroy := data.apps.mail.allow_destroy

deny contains msg if {
	some rc in input.resource_changes
	rc.type in protected_types
	"delete" in rc.change.actions
	not rc.address in allow_destroy
	msg := sprintf("%s: would be destroyed, and the mail in it; list the address under apps.mail.allow_destroy in stack.yaml to let it go", [rc.address])
}
