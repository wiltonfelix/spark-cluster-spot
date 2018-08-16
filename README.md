# spark-cluster-spot


Módulo terraform que constroi um cluster de spark "EMR" na AWS, tendo como premissa os conceitos de escalabilidades com máquinas spots para os nodes tasks.

### Utilização do módulo

1. Garanta que seu usuário tenha as permissões necessárias para criar um cluster **EMR** na **AWS** e criar roles no **IAM**
2. Edite o arquivo **vars.tf** que fica na raiz do projeto com os valores de sua preferência
3. Tenha o binário do terraform instalado na sua máquina, ele pode ser baixado nesse link https://www.terraform.io/downloads.html
4. Terraform plan para você poder analisar o que vai ser criado
5. Terraform apply --auto-approve na raiz do projeto
