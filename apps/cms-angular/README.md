# CMS Angular

CMS didatico para editar uma tela Server Driven UI via JSON.

## Como rodar

Na raiz do monorepo, em terminais separados:

```bash
pnpm dev:api
pnpm dev:cms
```

Abra:

```text
http://localhost:4200
```

## Como funciona

O CMS busca `GET http://localhost:3333/screen/home`, mostra o JSON em um textarea e renderiza um preview Angular da tela.

Fluxo:

1. Edite o JSON no textarea.
2. Clique em `Validar JSON`.
3. O CMS valida usando `@poc/shared-schema`.
4. O preview Angular atualiza.
5. Clique em `Publicar`.
6. O CMS envia `POST /screen/home` para a Mock API.

## O que esta sendo compartilhado

- Design tokens via `@poc/design-tokens`.
- Schema e tipos via `@poc/shared-schema`.
- Nomes dos blocos: `hero`, `text`, `card`, `button`.
- Variantes, como `button.variant = primary | secondary`.
- Estrutura do payload.

## O que nao esta sendo compartilhado

O CMS nao compartilha componentes visuais com Flutter. O Angular tem seus componentes web, e o Flutter tem seus widgets nativos.

Isso e proposital: compartilhar UI entre plataformas costuma misturar responsabilidades, reduzir qualidade nativa e criar acoplamento dificil de evoluir. A parte compartilhada deve ser o contrato, nao a implementacao visual.

## Componentes do preview

- `HeroBlockComponent`
- `TextBlockComponent`
- `CardBlockComponent`
- `ButtonBlockComponent`
- `VideoBlockComponent`
- `DynamicScreenRendererComponent`
