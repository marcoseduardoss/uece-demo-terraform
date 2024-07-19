resource "aws_instance" "instancia_1" {
  ami           = "ami-04a81a99f5ec58529"  # Substituir por um AMI válido
  instance_type = "t2.micro"
  key_name      = "terraform-key"//chave ssh configura no console aws

  security_groups = [aws_security_group.elb_sg.name]
  depends_on = [aws_db_instance.meu_rds]
  availability_zone = "us-east-1a"  

user_data = <<-EOF
                #!/bin/bash
                apt update
                apt install -y apache2 mysql-client php php-mysql libapache2-mod-php wget unzip

                # Baixar e configurar o WordPress
                wget https://wordpress.org/latest.zip
                unzip latest.zip
                mv wordpress/* /var/www/html/

                # Definir permissões
                chown -R www-data:www-data /var/www/html/
                chmod -R 755 /var/www/html/

                # Criar arquivo de configuração do WordPress
                cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

                # Atualizar arquivo de configuração do WordPress com detalhes do banco de dados
                sed -i "s/database_name_here/${aws_db_instance.meu_rds.db_name}/" /var/www/html/wp-config.php
                sed -i "s/username_here/admin/" /var/www/html/wp-config.php
                sed -i "s/password_here/MinhaSenhaSegura123/" /var/www/html/wp-config.php
                sed -i "s/localhost/${aws_db_instance.meu_rds.address}/" /var/www/html/wp-config.php

                # Iniciar e habilitar Apache
                systemctl start apache2
                systemctl enable apache2
                EOF


  tags = {
    Name = "InstanciaWeb1"
  }
}


resource "aws_instance" "instancia_2" {
  ami           = "ami-04a81a99f5ec58529"  # Substituir por um AMI válido
  instance_type = "t2.micro"
  key_name      = "terraform-key"//chave ssh configura no console aws

  security_groups = [aws_security_group.elb_sg.name]
  depends_on = [aws_db_instance.meu_rds]
  availability_zone = "us-east-1b" 

user_data = <<-EOF
                #!/bin/bash
                apt update
                apt install -y apache2 mysql-client php php-mysql libapache2-mod-php wget unzip

                # Baixar e configurar o WordPress
                wget https://wordpress.org/latest.zip
                unzip latest.zip
                mv wordpress/* /var/www/html/

                # Definir permissões
                chown -R www-data:www-data /var/www/html/
                chmod -R 755 /var/www/html/

                # Criar arquivo de configuração do WordPress
                cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

                # Atualizar arquivo de configuração do WordPress com detalhes do banco de dados
                sed -i "s/database_name_here/${aws_db_instance.meu_rds.db_name}/" /var/www/html/wp-config.php
                sed -i "s/username_here/admin/" /var/www/html/wp-config.php
                sed -i "s/password_here/MinhaSenhaSegura123/" /var/www/html/wp-config.php
                sed -i "s/localhost/${aws_db_instance.meu_rds.address}/" /var/www/html/wp-config.php

                # Iniciar e habilitar Apache
                systemctl start apache2
                systemctl enable apache2
                EOF


  tags = {
    Name = "InstanciaWeb2"
  }
}
