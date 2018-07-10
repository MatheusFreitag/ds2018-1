# Locadora de Carros

Este documento serve como guia de estruturação e levantamento da aplicação desenvolvida para a disciplina de Desenvolvimento de Software

## Tecnologias
Este trabalho foi desenvolvido com [NodeJS](https://nodejs.org/en/) na versão v6.11.2, MySQL como banco de dados e [SailsJS](https://0.12.sailsjs.com/) na versão 0.12 como framework para estruturação do modelo MVC.
Para controle de versionamento do Node, bem como de outros pacotes, usamos o ambiente de desenvolvimento em Nuvem [Cloud9](https://aws.amazon.com/pt/cloud9/).
## Estrutura de Arquivos
Aqui é listada a estrutura de arquivos, com os componentes mais importantes assinalados e descritos com mais detalhes a seguir.
Usamos o modelo MVC para estruturar o projeto e modularizar o fluxo de execução.

```bash
.root
│
├── 📂 .git
├── 📂 .tmp   
├── 📂 api 
│   ├── 📂 controllers ❗
│   │   └── 📄 Controllers da aplicação 
│   │
│   ├── 📂 models ❗
│   │   └── 📄 Models da aplicação
│   │
│   ├── 📂 policies 
│   └── 📂 responses                 
│
├── 📂 assets
├── 📂 config
│   ├── 📂 env
│   ├── 📂 locales 
│   ├── 📄 // arquivos gerais 
│   ├── 📄 connections.js ❗
│   ├── 📄 routes.js ❗
│   └── 📄 // arquivos gerais 
│
├── 📂 tasks
│
├── 📂 views ❗
│   └── 📄 // Views da Aplicação 
│
├── 📄 //arquivos gerais        
├── 📄 app.js ❗
├── 📄 package.json ❗
└── 📄 //arquivos gerais
```

#### api/controllers.s e api/models
No modelo MVC, o Model e o Controller são encontrados nos respectivos diretórios, e neles são definidos os Schemas e as ações que os Controllers precisam executar

#### config/connections.js
Aqui é feita a conexão com o banco de dados. Por estarmos usando mysql, precisamos alterar o seguinte trecho de código:
```javascript
mysql: {
    adapter: 'sails-mysql',
    host: '', //localhost ou outro necessário
    user: '', //opcional
    password: '', //opcional
    database: '', 
    port: ''
  },
 ``` 

#### config/routes.js
Neste arquivo especificamos rotas que não estejam vinculadas aos Models, e portanto, não estão explicitamente sendo tratadas pelos Controllers.

#### views/
Nesta pasta estão localizadas todos os arquivos que compões as views do modelo MVC da aplicação. Elas possuem extenção .ejs pois integram os dados enviados pelo Controller para mostrar os dados na tela. 
Se forem arquivos sem conteúdo dinâmico poderão ser .html sem problemas.

#### app.js
Arquivo raiz da aplicação

#### package.json
Arquivo que contém todos os pacotes NPM necessários para rodar a aplicação.


## Inicialização
1. Instalar o NodeJS.
2. Clonar Repositório.
3. Após clonar o repositório, executar no Terminal já dentro da raiz do projeto o comando ```npm install ``` para instalar todos os pacotes listados em ```package.json``` (Pode levar alguns segundos).
4. Executar o comando ```sudo npm install -g sails@0.12``` (Pode levar alguns segundos).
5. Instalar e inicializar o mysql (Podem haver variações de como fazer isso dependendo do SO).
6. Executar o script contido em mysqldump.sql que está presente no projeto (Pode ser via Workbench, Terminal ou onde for mais conveniente).
7. Setar as configurações do banco no arquivo ``` config/connections.js ``` (Atualizar host, user, root, password e port com os valores pertinentes. Adapter e Database não terão seus valores alterados).
8. Na raiz do projeto executar o comando ``` sails lift ```.
9. Abrir a url fornecida no navegador.


