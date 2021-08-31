#Authentication Variables

variable "subscription_id" {
    type = string
}
# variable "tenant_id" {
#     type = string
# }
# variable "client_id" {
#     type = string
# }
# variable "client_secret" {
#     type = string
#     sensitive   = true
# }
variable "environment" {
    type = string
}
variable "region" {
  type = string
}
variable "tags" {
    type = map(string)
}
variable "projectname" {
    type = string
}
variable "regioncodename" {
    type = string
}
#ADB
variable "adbsku" {
    type = string
}
variable "adminuser" {
    type = string
}
variable "autoshutdownmins" {
    type = string
}
#AKV
variable "retention" {
    type = string
}
variable "akvsku" {
    type = string
}
variable "rbacenabled" {
    type = string
}
#ADLS
variable "accesstier" {
    type = string
    default = "Hot"
}
variable "accounttier" {
    type = string
    default = "Standard"
}
variable "replication" {
    type = string
    default = "LRS"
}
#SAW
variable "fsname" {
    type = string
}
variable "sawaccounttier" {
    type = string
}
variable "sawaccesstier" {
    type = string
}
variable "sawreplication" {
    type = string
}
variable "sqladminlogin" {
    type = string
}
variable "sqladminpass" {
    type = string
    sensitive   = true
}
variable "nodesizefamily" {
    type = string
}
variable "nodesize" {
    type = string
}
variable "maxnodecount" {
    type = string
}
variable "minnodecount" {
    type = string
}