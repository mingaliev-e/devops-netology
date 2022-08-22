В задании видимо есть ошибка!
Если на шаге "Переключаемся на ветку git-rebase и выполняем git rebase -i main" выполнить rebase только с ключем -i 

Перед последним шагом "Теперь можно смержить ветку git-rebase в main без конфликтов и без дополнительного мерж-комита простой перемоткой." структура веток выглядит следующим образом

![image](https://user-images.githubusercontent.com/111060072/185875085-7bb60599-9787-4e78-9115-c4009c4bf31a.png)

И если сделать merge то он будет выполнен рекурсивно и создастся merge commit, в итоге структура будет совсем непонятная.

Чтобы этого избежать перед этим шагом на ветке git-rebase можно еще раз выполнить git rebase main и можно не мерджить 

Но я на шеге git rebase -i main выполнил с ключем --preserve-merges после чего исправил конфликты и сообщение там будет 

|# This is a combination of 2 commits.

|# This is the 1st commit message:

| git-rebase 2

|# The commit message #2 will be skipped:

|# git 2.3 rebase @ instead * (2)

после чего сделал git merge git-rebase и мердж прошел методом Fast-forward
