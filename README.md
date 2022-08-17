# devops-netology
test

1) **/.terraform/*

Будут исключены все файлы из скрытого каталога .terraform, каталог может быть вложен в n-ое количество каталогов о чем говорит **/

2) *.tfstate *.tfstate.*

Будут исключены все файлы с расширением .tfstate, .*говорит о том, что после расширения могут быть еще n-ое количество символов после точки

3) crash.log  crash.*.log

Исключить лог файлы crash.log и между crash. и .log может быть любое количество символов

4) *.tfvars *.tfvars.json

Исключить файлы с расширением .tfvars и .tfvars.json так как они содержат конфиденциальные данные (пароли, ключи и т.д)

5) 
override.tf
override.tf.json
*_override.tf
*_override.tf.json

Исключить файлы override.tf, override.tf.json
Исключить файлы с окончанием  _override.tf и _override.tf.json

6) .terraformrc terraform.rc

Исключить конфигурационный скрытый файл .terraformrc и файл terraform.rc

* Пример исключения файла *.tfstate или override.tf действуют на любом уровне вложенности, но так как файл .gitignore находится в папке terraform/ то вложенность начинается с данной папки




new line
