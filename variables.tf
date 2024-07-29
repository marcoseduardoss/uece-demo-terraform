variable "ami" {
  description = "AMI - Imagem Ubuntu utilizada para criar as instâncias"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância"
  type        = string
}

variable "key_name" {
  description = "Nome da chave SSH"
  type        = string
}

variable "db_username" {
  description = "Nome de usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs das subnets"
  type        = list(string)
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "aws_region" {
  description = "Região da AWS"
  type        = string
}

variable "aws_profile" {
  description = "Perfil da AWS"
  type        = string
}
