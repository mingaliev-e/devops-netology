## Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545

Update CHANGELOG.md

Команда "git show aefea"

## Какому тегу соответствует коммит 85024d3

tag: v0.12.23

Команда "git show 85024d3"

## Сколько родителей у коммита b8d720? Напишите их хеши.
Т.к это merge commit то родителей 2 

Узнать это можно командой git show b8d720 или посмотреть git log --oneline --graph b8d720

Хеши:

56cd7859e05c36c06b56d013b55a252d0bb7e158

9ea88f22fc6269854151c571162c5bcf958bee2b

Команды git show b8d720^1 и git show b8d720^2, можно посмотреть короткие хеши при git show b8d720 вывод Merge: 56cd7859e0 9ea88f22fc

##  Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.
33ff1c03bb (tag: v0.12.24) v0.12.24

b14b74c493 [Website] vmc provider links

3f235065b9 Update CHANGELOG.md

6ae64e247b registry: Fix panic when server is unreachable

5c619ca1ba website: Remove links to the getting started guide's old location

06275647e2 Update CHANGELOG.md

d5f9411f51 command: Fix bug when using terraform login on Windows

4b6d06cc5d Update CHANGELOG.md

dd01a35078 Update CHANGELOG.md

225466bc3e Cleanup after v0.12.23 release

Команда git log --oneline v0.12.23...v0.12.24
## Найдите коммит в котором была создана функция func providerSource
commit 8c928e83589d90a031f811fae52a81be7153e82f

Команда git log -S "func providerSource" --pretty=format:"%h, %ad" и смотрим по дате 8c928e8358, Thu Apr 2 18:04:39 2020 -0700
## Найдите все коммиты в которых была изменена функция globalPluginDirs
commit 78b12205587fe839f10d946ea3fdc06719decb05

commit 52dbf94834cb970b510f2fba853a5b49ad9b1a46

commit 41ab0aef7a0fe030e84018973a64135b11abcd70

commit 66ebff90cdfaa6938f26f908c7ebad8d547fea17

commit 8364383c359a6b738a436d1b7745ccdce178df47
## Кто автор функции synchronizedWriters
Martin Atkins

Wed May 3 16:25:41 2017

Команда git log -S "synchronizedWriters(" --pretty=format:"%h, %an, %ad"
