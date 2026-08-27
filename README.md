# Tec_Prog-EP-1
Repositório que contém o software requisitado no primeiro projeto em equipe do curso regular do IME USP - MAC0216 oferecido para os alunos do bacharelado de ciência da computação;

## 1. Instalar o Git

Antes de clonar o repositorio, confira se o Git esta instalado:

```bash
git --version
```

Se aparecer uma versao, por exemplo `git version 2.x.x`, o Git ja esta
instalado.

Se o comando nao funcionar, instale o Git pelo site oficial:

https://git-scm.com/downloads

## 2. Clonar o repositorio

Para baixar o projeto no seu computador use o comando cd para ir a pasta que deseja que o projeto seja salvo e execute:

```bash
git clone https://github.com/AntonioCezar/Tec_Prog-EP-1
```

Depois entre na pasta do projeto:

```bash
cd Tec_Prog-EP-1
```

## 3. Conferir a branch atual

Para ver em qual branch voce esta:

```bash
git branch
```

A branch atual aparece com um `*` antes do nome.

Voce tambem pode usar:

```bash
git branch --show-current
```

Normalmente, a branch principal do projeto e a `main`.

## 4. Atualizar o projeto antes de trabalhar

Antes de criar uma branch nova ou comecar uma alteracao, atualize sua copia local:

```bash
git checkout main
git pull origin main
```

O `git pull` baixa as alteracoes mais recentes do GitHub para o seu computador.

## 5. Criar uma branch nova

Cada tarefa deve ser feita em uma branch propria para que o projeto nao fique uma bagunca e a gente consiga acompanhar as atualizacoes.

Para criar e entrar em uma branch nova:

```bash
git checkout -b nome-da-sua-branch
```

Exemplos de nomes:

```bash
git checkout -b adicionar-log
git checkout -b corrigir-error-handling
git checkout -b adicionar-funcao-x
```

Se nao souber o que vai fazer coloque um nome generico:

```bash
git checkout -b nome-qualquer
```

E apos as modificacoes no arquivo mude o nome antes de enviar a branch para o Git:

```bash
git branch -m novo-nome
```

Use nomes curtos, claros e relacionados ao que voce esta fazendo.

## 6. Adicionar arquivos ao commit

Depois que vc modificou ou adicionou novas coisas ao projeto, para adicionar todos os arquivos alterados:

```bash
git add .
```

Se quiser adicionar apenas um arquivo especifico:

```bash
git add caminho/do/arquivo
```

Exemplo:

```bash
git add compiler.sh
```

## 7. Criar um commit

Depois de adicionar os arquivos, crie um commit com uma mensagem clara:

```bash
git commit -m "Adiciona instrucoes de uso do programa"
```

A mensagem deve explicar o que mudou. Prefira mensagens curtas e objetivas.

Bons exemplos:

```bash
git commit -m "Cria gitignore inicial do projeto"
git commit -m "Corrige compilador C"
git commit -m "Adiciona um log com timer"
```

Evite mensagens genericas como:

```bash
git commit -m "mudancas"
git commit -m "ajustes"
git commit -m "teste"
```

## 8. Enviar a branch para o GitHub

Na primeira vez que voce enviar uma branch nova:

```bash
git push -u origin nome-da-sua-branch
```

Exemplo:

```bash
git push -u origin adicionar-instrucoes
```

Depois disso, enquanto estiver na mesma branch, voce pode usar apenas:

```bash
git push
```

Caso tenha enviado uma branch com o nome errado, renomeie a branch localmente, reenvie a nova branch com o comando acima e, por fim, use:

```bash
git push origin --delete nome-antigo
```

Para deletar a branch errada.

## 9. Abrir um Pull Request

Depois de enviar a branch para o GitHub, abra um Pull Request (Fica na propria pagina do Git).

No Pull Request, explique de forma simples:

- o que foi alterado;
- por que a alteracao foi feita;
- como testar, quando fizer sentido.

Confira se o codigo roda e se os arquivos alterados sao apenas os que fazem parte da tarefa.