import { CommonModule } from "@angular/common";
import { Component, signal } from "@angular/core";
import { ZodError } from "zod";
import {
  DynamicScreen,
  formatZodError,
  validateDynamicScreen
} from "@poc/shared-schema";
import { DynamicScreenRendererComponent } from "./renderer/dynamic-screen-renderer.component";

const apiUrl = "http://localhost:3333/screen/home";

@Component({
  selector: "poc-root",
  standalone: true,
  imports: [CommonModule, DynamicScreenRendererComponent],
  templateUrl: "./app.component.html",
  styleUrl: "./app.component.css"
})
export class AppComponent {
  screen = signal<DynamicScreen | null>(null);
  editorValue = signal("");
  status = signal("Carregando tela da API...");
  isError = signal(false);

  constructor() {
    void this.loadScreen();
  }

  async loadScreen() {
    try {
      const response = await fetch(apiUrl);
      const payload = await response.json();
      const screen = validateDynamicScreen(payload);

      this.screen.set(screen);
      this.editorValue.set(JSON.stringify(screen, null, 2));
      this.status.set("Tela carregada da Mock API.");
      this.isError.set(false);
    } catch (error) {
      this.status.set(`Erro ao carregar: ${this.errorMessage(error)}`);
      this.isError.set(true);
    }
  }

  updateEditor(event: Event) {
    this.editorValue.set((event.target as HTMLTextAreaElement).value);
  }

  validateJson() {
    try {
      const parsed = JSON.parse(this.editorValue());
      const screen = validateDynamicScreen(parsed);

      this.screen.set(screen);
      this.status.set("JSON valido. O preview foi atualizado.");
      this.isError.set(false);
    } catch (error) {
      this.status.set(`JSON invalido: ${this.errorMessage(error)}`);
      this.isError.set(true);
    }
  }

  async publish() {
    try {
      const parsed = validateDynamicScreen(JSON.parse(this.editorValue()));
      const response = await fetch(apiUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(parsed)
      });
      const payload = await response.json();

      if (!response.ok) {
        throw new Error(payload.errors?.join(" | ") ?? payload.message);
      }

      this.screen.set(payload.screen);
      this.status.set("Publicado com sucesso. Flutter ja pode consumir a nova tela.");
      this.isError.set(false);
    } catch (error) {
      this.status.set(`Erro ao publicar: ${this.errorMessage(error)}`);
      this.isError.set(true);
    }
  }

  private errorMessage(error: unknown): string {
    if (error instanceof ZodError) {
      return formatZodError(error).join(" | ");
    }
    if (error instanceof SyntaxError) {
      return "JSON mal formatado.";
    }
    if (error instanceof Error) {
      return error.message;
    }
    return "erro desconhecido";
  }
}
