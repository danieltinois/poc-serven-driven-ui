# Flutter App

App Flutter simples que consome o JSON da Mock API e renderiza widgets nativos.

## Como rodar

Na raiz do monorepo:

```bash
pnpm dev:api
```

Em outro terminal:

```bash
cd apps/flutter-app
flutter pub get
flutter run
```

## URL da API

No Android emulator, o localhost da maquina host deve ser acessado por:

```text
http://10.0.2.2:3333/screen/home
```

No iOS simulator, use:

```text
http://localhost:3333/screen/home
```

Para trocar, edite `screenUrl` em `lib/main.dart`.

## Como funciona

O app:

1. Faz `GET /screen/home`.
2. Converte o JSON para models simples em `lib/models/dynamic_screen.dart`.
3. Passa os blocos para `DynamicScreenRenderer`.
4. O renderer faz switch por `type`.
5. Cada bloco vira um widget Flutter nativo.

## Widgets

- `HeroBlock`
- `TextBlock`
- `CardBlock`
- `ButtonBlock`

## Fallback

Se a API enviar um bloco desconhecido, o app renderiza um card simples com `Bloco desconhecido`. Isso demonstra que o app nao quebra quando o contrato evolui.

## Tokens

O app usa `poc_design_tokens`, que aponta para `packages/design-tokens/tokens.dart`.
