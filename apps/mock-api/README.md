# Mock API

API simples em Node + Express para simular a publicacao de uma tela Server Driven UI.

## Rotas

- `GET /health`: retorna `{ "status": "ok" }`.
- `GET /screen/home`: retorna o JSON atual da tela home.
- `POST /screen/home`: valida e salva em memoria um novo JSON da tela home.

## Como rodar

Na raiz do monorepo:

```bash
pnpm install
pnpm dev:api
```

A API sobe em:

```text
http://localhost:3333
```

## Validacao

O `POST /screen/home` usa o pacote `@poc/shared-schema`. Se o payload estiver invalido, a API responde `400` com uma lista de erros legiveis.

Exemplo de erro:

```json
{
  "message": "Payload invalido. Corrija o JSON antes de publicar.",
  "errors": ["blocks.0.props.title: String must contain at least 1 character(s)"]
}
```

## Observacao

O conteudo e salvo somente em memoria. Ao reiniciar a API, o exemplo `screen.home.json` volta a ser usado.
