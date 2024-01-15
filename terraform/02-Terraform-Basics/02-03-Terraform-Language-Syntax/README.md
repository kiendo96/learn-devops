# Terraform Configuration Language Syntax

## Terraform Basic Language - File
- Code in the Terraform language is stored in plain text files with the `.tf` file extension.
- There is also a `JSON-based` variant of the language that is named with the `.tf.json` file extension.
- We can call the files containing terraform code as `Terraform Configuration Files` or `Terraform Manifests`

# Terraform Language Basics – Configuration Syntax
Terraform:
  - Blocks
  - Arguments
  - Identifiers
  - Comments

## Terraform Basic Blocks
- `Terraform Block`:
  + Special block used to configure some behaviors
  + `Required Terraform Version`
  + `List Required Providers`
  + `Terraform Backend`

- `Provider Block`:
  + `HEART` of Terraform
  + Terraform relies on providers to `interact` with Remote Systems
  + Declare providers for Terraform to `install` providers & use them
  + Provider configurations belong to `Root Module`

- `Resource Block`:
  + Each Resource Block describes one or more Infrastructure Objects
  + `Resource Syntax`: How to declare Resources?
  + `Resource Behavior`: How Terraform handles resource declarations?
  + `Provisioners`: We can configure Resource post-creation actions

### Terraform Block
- This block can be called in 3 ways. All means the same.
  + Terraform Block
  + Terraform Settings Block
  + Terraform Configuration Block
- Each terraform block can contain a number of settings related to Terraform's behavior.


`VERY VERY IMPORTANT TO MEMORIZE`
> Within a terraform block, `only constant values can be used`; arguments `may not refer` to named objects such as resources, input variables, etc, and `may not use` any of the Terraform language built-in functions.

### Terraform Block - Example
```
#Terraform Settings Block
terraform {
  #Required Terraform Version
  required_version = "~> 1.6"
  #Required Provider and their Version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  # Adding Backend as S3 for Remote State Storage with State Locking
  backend "s3" {
    bucket = "terraform-stacksimplify"
    key    = "dev2/terraform.tfstate"
    region = "us-east-1"  

    # For State Locking
    dynamodb_table = "terraform-dev-state-table"
  }
}
```

Terraform Provider Registry
  - Povider <----> `registry.terraform.io` <----> Modules
  - Provider Badges:
    + Offical: These are owned and maintained by HashiCorp
    + Verified: These are owned and maintained by third-party technology partners. HashiCorp has verified the authenticity of the Provider’s publisher
    + Community: Community providers are published to the Terraform Registry by individual maintainers, groups of maintainers, or other members of the Terraform community.
    + Archived: Archived Providers are Official or Verified Providers that are no longer maintained by HashiCorp or the community.

## Step-02: Terraform Configuration Language Syntax
- Understand Blocks
- Understand Arguments
- Understand Identifiers
- Understand Comments
- [Terraform Configuration](https://www.terraform.io/docs/configuration/index.html)
- [Terraform Configuration Syntax](https://www.terraform.io/docs/configuration/syntax.html)
```t
# Template
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>"   {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}

# AWS Example
resource "aws_instance" "ec2demo" { # BLOCK
  ami           = "ami-04d29b6f966df1537" # Argument
  instance_type = var.instance_type # Argument with value as expression (Variable value replaced from varibales.tf
}
```

## Step-03: Understand about Arguments, Attributes and Meta-Arguments.
- Arguments can be `required` or `optional`
- Attribues format looks like `resource_type.resource_name.attribute_name`
- Meta-Arguments change a resource type's behavior (Example: count, for_each)
- [Additional Reference](https://learn.hashicorp.com/tutorials/terraform/resource?in=terraform/configuration-language) 
- [Resource: AWS Instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Resource: AWS Instance Argument Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#argument-reference)
- [Resource: AWS Instance Attribute Reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attributes-reference)
- [Resource: Meta-Arguments](https://www.terraform.io/docs/language/meta-arguments/depends_on.html)

## Step-04: Understand about Terraform Top-Level Blocks
- Discuss about Terraform Top-Level blocks
  - Terraform Settings Block
  - Provider Block
  - Resource Block
  - Input Variables Block
  - Output Values Block
  - Local Values Block
  - Data Sources Block
  - Modules Block

