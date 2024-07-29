resource "aws_instance" "instancia_1" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.elb_sg.name]
  depends_on = [aws_db_instance.meu_rds]

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
                sed -i "s/username_here/${var.db_username}/" /var/www/html/wp-config.php
                sed -i "s/password_here/${var.db_password}/" /var/www/html/wp-config.php
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
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.elb_sg.name]
  depends_on = [aws_db_instance.meu_rds]

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
                sed -i "s/username_here/${var.db_username}/" /var/www/html/wp-config.php
                sed -i "s/password_here/${var.db_password}/" /var/www/html/wp-config.php
                sed -i "s/localhost/${aws_db_instance.meu_rds.address}/" /var/www/html/wp-config.php

                # Iniciar e habilitar Apache
                systemctl start apache2
                systemctl enable apache2
                EOF

  tags = {
    Name = "InstanciaWeb2"
  }
}