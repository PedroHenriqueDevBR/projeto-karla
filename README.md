<h1 align="center">:woman: Karla App</h1>

<p align="center">
Projeto desenvolvido para a minha amiga Karla, para solucionar um problema em que ela se encontra em relação à confimação do recebimento de convites e confirmação de presença em eventos.
</p>

<p align="center">
<img alt="Developer" src="https://img.shields.io/badge/Developer-PedroHenriqueDevBR-green">
<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/PedroHenriqueDevBR/projeto-karla">
<img alt="Front-emd" src="https://img.shields.io/badge/Frontend-Flutter-blue">
<img alt="Back-end" src="https://img.shields.io/badge/Backend-Django-green">
</p>

# :memo: Visão Geral

Gerenciador de convites de eventos.

 * <strong><a href="#tecnologias">Tecnologias utilizadas</a></strong>
 * <strong><a href="#modelagem">Modelagem da aplicação</a></strong>
    * <strong><a href="#modelagem-classes">Modelagem do banco de dados (Back-end)</a></strong>
    * <strong><a href="#modelagem-mobile">Modelagem das classes da aplicação (Mobile)</a></strong>
    * <strong><a href="#prototype">Protótipo da aplicação (Mobile)</a></strong>
 * <strong><a href="#requisitos">Pré-requisitos</a></strong>
 * <strong><a href="#instalacao">Instalação</a></strong>
 * <strong><a href="#funcionalidades">Funcionalidades</a></strong>
 * <strong><a href="#screenshots">Screenshots</a></strong>

<h1 id="tecnologias">:rocket: Tecnologias utilizadas</h1>

<br>

* <img alt="Dart" src="https://img.shields.io/badge/-Dart-blue"> - Linguagem de programação utilizada no desenvolvimento Front-end.
* <img alt="Flutter" src="https://img.shields.io/badge/-Flutter-blue"> - Framework utilizado no desenvolvimento da aplicação mobile.
* <img alt="Python" src="https://img.shields.io/badge/-Python-green"> - Linguagem de programação utilizada no desenvolvimento Back-end.
* <img alt="Django" src="https://img.shields.io/badge/-Django-green"> - Framework utilizado no desenvolvimento da REST API.
* <img alt="DRF" src="https://img.shields.io/badge/-DRF-red"> - Toolkit utilizado junto do Django para facilitar a criação da REST API.

<h1 id="modelagem">:bulb: Modelagem da aplicação</h1>

Esta seção irá mostrar como a aplicação foi modelada para que pudesse atender todas as necessidades propostas da descrição do desafio.

A modelagem foi criada antes de iniciar o desenvolvimento da aplicação, com o objetivo de guiar o desenvolvimento e evitar erros que pudessem atrapalhar o andamento do desenvolvimento.

<h2 id="modelagem-classes">Modelagem do banco de dados</h2>

<img width="100%" src="https://raw.githubusercontent.com/PedroHenriqueDevBR/projeto-karla/76140ffb7ed5c957989540ecad37d05e4777e923/docs/models/karla-backend.svg?token=AIYECYVAULF7W4VJORVHQGLBHAG44" />

<h2 id="modelagem-mobile">Modelagem das classes da aplicação</h2>

A modelagem das classes da aplicação servem para que a aplicação possa utilizar os dados fornecidos pela RestAPI.

<img width="100%" src="https://raw.githubusercontent.com/PedroHenriqueDevBR/projeto-karla/76140ffb7ed5c957989540ecad37d05e4777e923/docs/models/karla-mobile.svg?token=AIYECYRS2HK3ZU7X4NE4MI3BHAG74" />

<h2 id="prototype">Protótipo de alta fidelidade</h2>

Criei o protóripo de alta fidelidade para facilitar a codificação quando eu estivesse criando as interfaces da aplicação, o objetivo principal desse protóripo foi servir de guia para a implementação da camada presenter.

<img width="100%" src="https://raw.githubusercontent.com/PedroHenriqueDevBR/projeto-karla/76140ffb7ed5c957989540ecad37d05e4777e923/docs/prototype/figma-mobile.svg?token=AIYECYWQFWVVZS3DHPZBYETBHAING" />



<h1 id="requisitos">:warning: Pré-requisitos</h1>

O desenvolvimento dessa aplicação utiliza como base as seguintes tecnologias e versões apresentadas abaixo. Caso ocorra algum erro na execução da aplicação ou mesmo nos comandos de configurações, verifique se a versão do Dart e do Flutter no seu computador estão devidamente atualizados.

1. Dart 2.12.0 ou superior
2. Flutter 2.2.0 ou superior
3. Python 3.6 ou superior
4. Django 3.2.6 ou superior
5. git version 2.17.1

<h1 id="instalacao">:information_source: Instalação</h1>

```bash
# Baixe o projeto no seu computador
git clone https://github.com/PedroHenriqueDevBR/projeto-karla.git
cd projeto-karla/

# Crie uma máquina virtual para o back-end
cd projeto_da_carla/
virtualenv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt

# Rode o servidor localmente
python manage.py migrate
python manage.py runserver 0.0.0.0:8000

# Rode os testes para garantir que não há código quebrado
cd ../mobile/
flutter test

# Rode a aplicação no seu dispositivo android ou no Linux
flutte run
ou
flutte run -d linux

```

<h2 id="funcionalidades">:heavy_check_mark: Funcionalidades</h2>

- [X] Registrar usuário
- [X] Realizar o login do usuário
- [X] Adicionar evento
- [X] Selecionar todos os eventos do usuário logado
- [X] Modificar evento do usuário logado (Atualizar, deletar)
- [X] Compartilhar o link de um evento
- [X] Adicionar a resposta do convidado

<h1 id="screenshots">Screenshots (Resultado final)</h1>

<div>
   <h2>Login e cadastro de usuário</h2>
   <img width="25%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/login.png" />
   <img width="25%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/login-2.png" />
   <img width="25%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/register-user.png" />
</div>

<div>
   <h2>Home</h2>
   <img width="25%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/home-1.png" />
   <img width="25%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/home-2.png" />
</div>

<div>
   <h2>Página do evento</h2>
   
   <h4>Registro e edição</h4>
   <img width="22%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/event-1.png" />
   <img width="22%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/event-2.png" />
   <img width="22%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/event-3.png" />
   
   <h4>Alteração da capa do evento</h4>
   <img width="22%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/event-4.png" />
   <img width="22%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/event-5.png" />
   
   <h4>Apresentação e inclusão de respostas</h4>
   <img width="22%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/event-6.png" />
   <img width="22%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/event-7.png" />
   <img width="22%" src="https://github.com/PedroHenriqueDevBR/projeto-karla/blob/main/docs/screenshots/mobile/event-8.png" />
</div>

