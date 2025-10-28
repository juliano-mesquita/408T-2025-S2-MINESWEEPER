# 🤝 Regras de Contribuição

Para garantir um fluxo de trabalho organizado e manter a qualidade do código, pedimos que siga as regras abaixo.

## 🚀 Como Contribuir

Seguimos um fluxo baseado em *Pull Requests*. Nenhuma alteração deve ser enviada diretamente para a branch `main`.

### 1. Sincronize sua Branch Principal (Main)

Antes de começar qualquer trabalho, garanta que sua cópia local da branch `main` esteja atualizada com o repositório remoto.

```bash
# 1. Mude para a branch main
git checkout main

# 2. Busque as últimas alterações do repositório remoto
git fetch

# 3. Atualize sua branch local com as alterações remotas
git pull
```

### 2\. Crie uma Branch de Trabalho

Nunca trabalhe diretamente na branch `main`. Crie uma nova *branch* específica para a *feature* ou correção que você está desenvolvendo.

Utilize os seguintes prefixos para nomear sua branch:

  * **`feat/`**: Para novas funcionalidades (Ex: `feat/add-difficulty-levels`).
  * **`fix/`**: Para correção de bugs (Ex: `fix/timer-not-stopping`).
  * **`docs/`**: Para alterações na documentação (Ex: `docs/update-readme`).
  * **`refactor/`**: Para refatorações de código que não alteram a funcionalidade (Ex: `refactor/game-controller-state`).
  * **`chore/`**: Para tarefas de manutenção, atualização de dependências, etc. (Ex: `chore/update-flutter-version`).

**Exemplo de criação de branch:**

```bash
# Exemplo para uma nova feature
git checkout -b feat/implement-game-timer
```

### 3\. Desenvolva e Faça o Commit

Faça suas alterações, adicione-as ao *stage* e faça o *commit*. Tente criar commits pequenos e atômicos, com mensagens claras que descrevam o que foi feito.

```bash
# Adicione os arquivos alterados
git add .

# Crie o commit
git commit -m "feat: Adiciona cronômetro à tela de jogo"
```

### 4\. Envie suas Alterações e Crie um Pull Request (PR)

Após concluir suas alterações e *commits*, envie sua branch para o repositório remoto.

```bash
# Envia sua branch local (ex: feat/implement-game-timer) para o repositório remoto
git push -u origin feat/implement-game-timer
```

Assim que a branch estiver no repositório remoto, acesse o GitHub e abra um **Pull Request (PR)**.

  * **De (From):** `sua-branch-de-trabalho` (ex: `feat/implement-game-timer`)
  * **Para (To):** `main`

### 5\. Revisão do Pull Request

Seu PR será revisado por um mantenedor do projeto. Esteja aberto a *feedbacks* e discussões. Alterações podem ser solicitadas antes que o PR seja aprovado e mesclado à branch `main`.

-----

Obrigado por sua contribuição\!