variable "firewall_nat_rule_collections" {
  description = <<EOT
Map of firewall_nat_rule_collections, attributes below
Required:
    - action
    - azure_firewall_name
    - name
    - priority
    - resource_group_name
    - rule (block):
        - description (optional)
        - destination_addresses (required)
        - destination_ports (required)
        - name (required)
        - protocols (required)
        - source_addresses (optional)
        - source_ip_groups (optional)
        - translated_address (required)
        - translated_port (required)
EOT

  type = map(object({
    action              = string
    azure_firewall_name = string
    name                = string
    priority            = number
    resource_group_name = string
    rule = list(object({
      description           = optional(string)
      destination_addresses = list(string)
      destination_ports     = list(string)
      name                  = string
      protocols             = list(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      translated_address    = string
      translated_port       = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.firewall_nat_rule_collections : (
        length(v.rule) >= 1
      )
    ])
    error_message = "Each rule list must contain at least 1 items"
  }
}

