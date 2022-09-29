
variable "region" {
    description = "region"
}
variable "availability_zone" {
    description = "avaliablity_zone"
}
variable "ami" {
    description = "ami-id"
}
variable "bucket_name" {
    description = "name of the bucket"
}
variable "database_name" {
    description = "name of database"  
}
variable "database_user" {
    description = "name of user"  
}
variable "database_pass" {
    description = "password of user"
}
variable "admin_user" {
    description = "name of user admin"  
}
variable "admin_pass" {
    description = "password of admin"
}

variable stack {
  description = "this is name for tags"
  default     = "terraform"
}