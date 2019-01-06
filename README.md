# Irenicus - O bot que gerencia o λMA e outras coisas no Telegram

[![Build](https://travis-ci.org/mschonfinkel/Irenicus.svg?branch=master)](https://travis-ci.org/mschonfinkel/Irenicus)

## O que esse bot pretende fazer?

A ideia é que o bot atenda as necessidades do @lambdama no Telegram, mas algumas funções também podem ser aproveitadas por outras comunidades, tais como:

* Avisar sobre eventos que estão acontecendo ou vão acontecer
* Listar eventos
* Deletar os podcasts de Jherferson quando ele posta links demais

## TODO

- [ ] TUDO

-----------------

## Como usar esse repo

Esse projeto foi feito com a seguintes tecnologias e precisa das seguintes depências pra ser rodados:

* [Nix](https://nixos.org/nix/)
* [Direnv](https://github.com/direnv/direnv)
* [Stack](https://docs.haskellstack.org/en/stable/README/): Usado dentro da Nix-shell

e usa com frequência a biblioteca em Haskell de [@fizruk](https://github.com/fizruk). Arquivo `.envrc.sample` descreve um exemplo de um arquivo que contém variáveis de ambiente e também gera uma `nix-shell` persistente com caching, disponível nas [docs do direnv](https://github.com/direnv/direnv/wiki/Nix#persistent-cached-shell-direnv--2182).

```
cp .envrc.sample .envrc
```

### Direnv

```
$ direnv allow
$ stack setup
$ stack build
