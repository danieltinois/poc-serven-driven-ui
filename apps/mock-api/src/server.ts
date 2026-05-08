import cors from "cors";
import express from "express";
import { ZodError } from "zod";
import homeScreenExample from "../../../packages/shared-schema/examples/screen.home.json" assert { type: "json" };
import {
  DynamicScreen,
  formatZodError,
  validateDynamicScreen
} from "@poc/shared-schema";

const app = express();
const port = Number(process.env.PORT ?? 3333);

let homeScreen: DynamicScreen = validateDynamicScreen(homeScreenExample);

app.use(cors());
app.use(express.json({ limit: "1mb" }));

app.get("/health", (_request, response) => {
  response.json({ status: "ok" });
});

app.get("/screen/home", (_request, response) => {
  response.json(homeScreen);
});

app.post("/screen/home", (request, response) => {
  try {
    homeScreen = validateDynamicScreen(request.body);
    response.json({
      message: "Tela home publicada com sucesso.",
      screen: homeScreen
    });
  } catch (error) {
    if (error instanceof ZodError) {
      response.status(400).json({
        message: "Payload invalido. Corrija o JSON antes de publicar.",
        errors: formatZodError(error)
      });
      return;
    }

    response.status(500).json({
      message: "Erro inesperado ao validar payload."
    });
  }
});

app.listen(port, () => {
  console.log(`Mock API rodando em http://localhost:${port}`);
});
