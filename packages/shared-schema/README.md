# @poc/shared-schema

Este pacote define o contrato compartilhado da tela dinamica.

Ele contem:

- schemas Zod em TypeScript;
- tipos TypeScript inferidos a partir dos schemas;
- catalogo dos blocos editaveis usado pelo CMS;
- payload exemplo em `examples/screen.home.json`;
- nomes oficiais dos blocos e variantes.

## Blocos suportados

- `hero`: titulo e subtitulo.
- `text`: texto simples.
- `card`: titulo e descricao.
- `button`: label, variante e acao opcional.
- `video`: URL de YouTube e descricao opcional.

## O que este contrato garante

O CMS monta um JSON que segue este formato, a API valida esse JSON antes de publicar, e o Flutter interpreta os mesmos nomes de blocos para renderizar widgets nativos.

O contrato nao define aparencia visual. Ele define estrutura e semantica.

## Catalogo de blocos

O arquivo `src/block-catalog.ts` centraliza metadados de edicao:

- label do bloco;
- descricao para o CMS;
- campos editaveis;
- opcoes de select;
- bloco default ao adicionar um novo item.

Assim, o CMS nao precisa hardcodar todos os formularios. Ele le o catalogo compartilhado e monta os campos a partir dele.

## Validar exemplo

```bash
pnpm --filter @poc/shared-schema validate
```
