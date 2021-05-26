# Projeto da Carla
Projeto criado para a senhorita Carla.


## Contexto

Haverá um evento, nesse evento é preciso saber a quantidade exata de pessoas que irão comparecer, pois a quantidade de pessoas define o total do custo do evento, portando, se uma pessoa convidada informar (presencialmente) que irá para o evento e não comparecer, então o organizador do evento irá pagar pela conta da pessoa que faltou.

## Objetivo

Desenvolver uma aplicação para que pessoas convidadas por meio de link (enviado por app de menssagens instantâneas) possam informar de forma calma se irão ou não comparecer ao evento, com o objetivo de ter um controle de quantidade de convidados e do total da conta.


## Solução

1. Criar uma plataforma Web (Python+Django) para disponibilizar um questionário para o público convidado.
2. Ao acessar o link enviado, o convidado deve informar uma senha (fornecida pelo organizador), para que possa acessar o questionário. 
3. O convidado deve informar o nome completo e escolher entre as opções (Confirmar Presença ou negar presença).
4. O Organizador pode acessar uma página e verificar o total de pessoas que confirmaram a presença no evento.


## Modelagem básica

**Usuário**
- Nome
- username
- senha
- email

**Evento**
- Titulo
- Descrição
- Avatar do organizador
- background
- confirmar texto
- cancelar texto
- Data de expiração

**Respostas**
- data da resposta
- nome convidado
- Irá comparecer

## To Do

- [X] Criar o projeto Django
- [X] Criar a aplicação Core
- [ ] Implementar os models
- [ ] Criar a view de login e cadastro de usuário
- [ ] Criar a view de dashboard (apresentar meus eventos ou cadastrar um novo)
- [ ] Criar a view de apresentação do evento (Se for dono do evento então ele pode ser editado)
- [ ] Criar a view de apresentação do resultado
