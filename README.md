# Projeto 2 - Configuração de Infraestrutura com Terraform

Este repositório contém os arquivos necessários para configurar uma infraestrutura na AWS utilizando o Terraform. O projeto faz parte da disciplina de Engenharia de Software com DevOps do curso de pós-graduação na Universidade Estadual do Ceará.

## Informações do Projeto

- **Disciplina:** Engenharia de Software com DevOps
- **Instituição:** Universidade Estadual do Ceará
- **Professor:** Carlos Mendes
- **Aluno:** Marcos Eduardo da Silva Santos

## Descrição do Projeto

O projeto tem como objetivo a criação de uma infraestrutura na AWS que consiste em:

- Duas instâncias EC2 rodando Apache, MySQL client, PHP e WordPress.
- Um Load Balancer (ELB) para balanceamento de carga entre as instâncias EC2.
- Um banco de dados RDS MySQL.
- Grupos de segurança para gerenciar o tráfego de rede.

## Estrutura dos Arquivos

- **ec2.tf**: Configuração das instâncias EC2.
- **elb.tf**: Configuração do Load Balancer (ELB).
- **output.tf**: Definição das saídas do Terraform.
- **provider.tf**: Configuração do provedor AWS.
- **rds.tf**: Configuração da instância RDS.
- **sg.tf**: Configuração dos grupos de segurança (Security Groups).
- **terraform.tfvars**: Variáveis específicas do ambiente.
- **variables.tf**: Definição das variáveis utilizadas no projeto.

## Configurações Necessárias

### Variáveis

As variáveis necessárias para o projeto estão definidas no arquivo `variables.tf`. Crie este arquivo e copie/edite as seguintes variáveis antes de executar os scripts Terraform:

```hcl
aws_profile   = "PF001*"
vpc_id        = "vpc-f8709XXX*"
subnet_ids    = ["subnet-db701XXX*", "subnet-e4df0XX*"]
aws_region    = "us-east-1"
ami           = "ami-04a81a99f5ec58529"
instance_type = "t2.micro"
key_name      = "my-wordpress-key"
db_name       = "MeuMysql"
db_username   = "admin"
db_password   = "MinhaSenhaSegura123"
```
*vpc_id e subnet_ids: podem ser obtidos em seu console AWS. 

*aws_profile:  o "profile" no Terraform permite especificar diferentes credenciais e configurações para acessar serviços á AWS, facilitando a gestão de múltiplas contas e ambientes. Para utilizá-lo, configure perfis na AWS CLI e especifique o perfil desejado na variável "aws_profile". 

### Provedor AWS

No arquivo `provider.tf`, configure a região e o perfil da AWS:

```hcl
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
```

### Instâncias EC2

No arquivo `ec2.tf`, duas instâncias EC2 são configuradas com a AMI, tipo de instância, chave SSH e comandos de inicialização para configurar o ambiente com Apache, MySQL client, PHP e WordPress.

### Load Balancer (ELB)

No arquivo `elb.tf`, um Load Balancer é configurado para balancear a carga entre as duas instâncias EC2.

### Banco de Dados RDS

No arquivo `rds.tf`, uma instância RDS MySQL é configurada com as informações de nome do banco, usuário e senha.

### Grupos de Segurança

No arquivo `sg.tf`, dois grupos de segurança são configurados:

- `elb_sg`: Permite tráfego SSH (porta 22) e HTTP (porta 80).
- `rds_sg`: Permite tráfego MySQL (porta 3306) do grupo de segurança `elb_sg`.

## Saídas do Terraform

No arquivo `output.tf`, são definidas as saídas do Terraform:

- `final_snapshot_id`: Identificador do snapshot final do RDS.

## Execução

1. **Inicializar o Terraform**:
   ```bash
   terraform init
   ```

2. **Planejar a Infraestrutura**:
   ```bash
   terraform plan
   ```

3. **Aplicar a Configuração**:
   ```bash
   terraform apply
   ```

4. **Verificar as Saídas**:
   Após a aplicação, verifique as saídas definidas no arquivo `output.tf`.

## Observações Gerais

- Antes de executar o projeto, certifique-se de substituir as AMIs e outras configurações específicas conforme necessário para o seu ambiente.
- O projeto Terraform criará automaticamente um par de chaves e usará essa chave nas instâncias EC2. 
- As instâncias EC2 são configuradas para instalar Apache, MySQL Client, PHP e WordPress automaticamente.
- A configuração do WordPress é atualizada automaticamente com os detalhes do banco de dados provisionado no RDS.
- Um ALB é configurado para distribuir o tráfego entre as instâncias EC2.
