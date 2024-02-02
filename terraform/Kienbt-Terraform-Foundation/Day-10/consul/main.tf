terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "~>2.0"
    }
  }
}

provider "consul" {
    address = "127.0.0.1:8500"
    datacenter = "dc1"
}

resource "consul_keys" "networking" {
   
   key {
    path = "networking/configuration"
    value = ""
   }

   key {
     path = "networking/state"
     value = ""
   }
}

resource "consul_keys" "application" {
  
  key {
    path = "application/configuration"
    value = ""
  }

  key {
    path = "application/state"
    value = ""
  }
}


resource "consul_acl_policy" "networking" {
  name = "networking"
  rules = <<-RULE
    key_prefix "networking" {
        policy = "write"
    }

    session_prefix "" {
        policy = "write"
    }
    RULE
}

resource "consul_acl_policy" "application" {
  name = "application"
  rules = <<-RULE
  key_prefix "application" {
    policy = "write"
  }

  key_prefix "networking/state" {
    policy = "read"
  }

  session_prefix "" {
    policy = "write"
  }
  RULE
}

resource "consul_acl_token" "mary" {
  description = "token for Mary"
  policies = [consul_acl_policy.networking.name]
}

resource "consul_acl_token" "sally" {
  description = "token for Sally"
  policies = [consul_acl_policy.application.name]
}

output "mary_token_accessor_id" {
  value = consul_acl_token.mary.id
}

output "sally_token_accessor_id" {
  value = consul_acl_token.sally.id
}