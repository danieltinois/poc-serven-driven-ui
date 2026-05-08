# @poc/shared-schema

Este pacote define o contrato compartilhado da tela dinamica.

Ele contem:

- schemas Zod em TypeScript;
- tipos TypeScript inferidos a partir dos schemas;
- payload exemplo em `examples/screen.home.json`;
- nomes oficiais dos blocos e variantes.

## Blocos suportados

- `hero`: titulo e subtitulo.
- `text`: texto simples.
- `card`: titulo e descricao.
- `button`: label, variante e acao opcional.

## O que este contrato garante

O CMS monta um JSON que segue este formato, a API valida esse JSON antes de publicar, e o Flutter interpreta os mesmos nomes de blocos para renderizar widgets nativos.

O contrato nao define aparencia visual. Ele define estrutura e semantica.

## Validar exemplo

```bash
pnpm --filter @poc/shared-schema validate
```

## Gerar contrato Flutter

Esta POC tambem tem um gerador simples para mostrar como o contrato poderia virar modelos Dart:

```bash
pnpm generate:flutter-contracts
```

O comando gera:

```text
apps/flutter-app/lib/generated/sdui_contracts.dart
```

Esse arquivo contem enums, models e parsing basico para o Flutter. Ele nao substitui a validacao da API; ele ajuda o app a consumir o payload com tipos mais claros.
