# Minesweeper Flutter 💣

Um clone do clássico jogo Campo Minado (Minesweeper) desenvolvido com o framework Flutter. Este projeto recria a experiência nostálgica do jogo, adaptado para dispositivos móveis e web.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg?logo=flutter)

## 📖 Sobre

O objetivo deste projeto é implementar a lógica completa do Campo Minado, seguindo uma arquitetura limpa e organizada em Flutter. O aplicativo permite ao usuário:

* Iniciar um novo jogo.
* Selecionar diferentes níveis de dificuldade (Iniciante, Intermediário, Avançado).
* Revelar células clicando nelas.
* Marcar/desmarcar minas suspeitas (com clique longo ou modo de marcação).
* Um cronômetro para acompanhar o tempo de jogo.
* Um contador de minas restantes.

## 📱 Telas (Preview)

*(Insira aqui capturas de tela ou GIFs do aplicativo em ação)*

## ✨ Features

* **Gameplay Clássico:** Lógica de revelação de células e verificação de vizinhos.
* **Marcação de Bandeiras:** Use um clique longo para marcar uma mina.
* **Cronômetro e Contador:** Acompanhe seu progresso.
* **Níveis de Dificuldade:** Configure o tamanho do tabuleiro e o número de minas.
* **Detecção de Vitória/Derrota:** O jogo termina automaticamente ao encontrar uma mina ou revelar todas as células seguras.
* **Responsivo:** Funciona em diferentes tamanhos de tela. (Ainda Não)

## 🚀 Tecnologias Utilizadas

* **[Flutter](https://flutter.dev/)**
* **[Dart](https://dart.dev/)**
* **Persistência Local:** SQFlite

## 📂 Estrutura do Projeto

O projeto segue uma arquitetura modular para separar responsabilidades, facilitando a manutenção e a escalabilidade.

```
.
├── assets/
│   └── // Assets da aplicação (imagens, fontes, etc.)
│
├── lib/
│   ├── controllers/
│   │   └── // Controladores de dados e estado (Ex: GameController, ScoreController)
│   │
│   ├── pages/
│   │   └── // Telas da aplicação (Ex: MainMenuPage, GamePage)
│   │
│   ├── repositories/
│   │   └── // Abstrações para fontes de dados (Ex: ScoreRepository)
│   │
│   ├── services/
│   │   └── // Lógica de negócios, integrações (Ex: ScoreService)
│   │
│   ├── utils/
│   │   └── // Arquivos utilitários (constantes, helpers, extensões)
│   │
│   ├── widgets/
│   │   └── // Widgets reutilizáveis (Ex: BoardCell, CustomButton)
│   │
│   └── main.dart
│
├── test/
│   └── // Testes unitários e de widgets, seguindo a estrutura da /lib
│
└── pubspec.yaml

```

**Descrição das Pastas Principais:**

* **`assets`**: Contém todos os recursos estáticos, como imagens (bomba, bandeira), fontes e arquivos JSON.
* **`lib/controllers`**: Responsável por gerenciar o estado das telas ou de features específicas. Comunica-se com os `services` para obter e enviar dados.
* **`lib/pages`**: Contém as "telas" ou "views" completas da aplicação, que são compostas por múltiplos `widgets`.
* **`lib/repositories`**: Define as interfaces (classes abstratas) para acesso a dados (Ex: `IScoreRepository`). As implementações concretas (Ex: `LocalStorageScoreRepository`) também podem ficar aqui ou em uma pasta `infra`.
* **`lib/services`**: Onde a lógica de negócios central reside. Orquestra o fluxo de dados, utiliza `repositories` para buscar/salvar informações e é consumido pelos `controllers`.
* **`lib/utils`**: Classes e funções auxiliares que não se encaixam em outras categorias, como constantes de cores, dimensões, formatadores de data, etc.
* **`lib/widgets`**: Widgets genéricos e reutilizáveis em várias partes do aplicativo (Ex: um botão estilizado, um campo de texto, ou até mesmo widgets complexos como o `MineCellWidget`).
* **`test`**: Contém os testes automatizados. A estrutura de pastas dentro de `test` deve espelhar a de `lib` para facilitar a localização dos testes.

## 🏁 Como Começar

Siga os passos abaixo para executar o projeto localmente.

**Pré-requisitos:**

* [Flutter SDK](https://flutter.dev/docs/get-started/install) (versão 3.x ou superior)
* Um editor de código (VS Code, Android Studio, etc.)
* Um emulador Android/iOS ou um dispositivo físico.

**Instalação e Execução:**

1.  **Clone o repositório:**
    ```sh
    git clone https://github.com/juliano-mesquita/408T-2025-S2-MINESWEEPER
    cd minesweeper-flutter
    ```

2.  **Instale as dependências:**
    ```sh
    flutter pub get
    ```

3.  **Execute o aplicativo:**
    ```sh
    flutter run
    ```

## 🧪 Testes

Para rodar os testes unitários e de widgets definidos na pasta `test/`, utilize o seguinte comando:

```sh
flutter test
````

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.


# 🤝 Regras de Contribuição
Clique [aqui](./CONTRIBUTIONS.md)
