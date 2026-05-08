import { CommonModule } from "@angular/common";
import { Component, signal } from "@angular/core";
import { ZodError } from "zod";
import {
  blockCatalog,
  BlockFieldDefinition,
  createDefaultBlock,
  DynamicScreen,
  DynamicBlock,
  formatZodError,
  getBlockDefinition,
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
  blockCatalog = blockCatalog;
  screen = signal<DynamicScreen | null>(null);
  selectedBlockType = signal<DynamicBlock["type"]>("text");
  draggedBlockIndex = signal<number | null>(null);
  dragOverBlockIndex = signal<number | null>(null);
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
      this.status.set("Tela carregada da Mock API.");
      this.isError.set(false);
    } catch (error) {
      this.status.set(`Erro ao carregar: ${this.errorMessage(error)}`);
      this.isError.set(true);
    }
  }

  validateBlocks() {
    try {
      const currentScreen = this.requireScreen();
      const screen = validateDynamicScreen(currentScreen);

      this.screen.set(screen);
      this.status.set("Tela valida. O preview foi atualizado.");
      this.isError.set(false);
    } catch (error) {
      this.status.set(`Tela invalida: ${this.errorMessage(error)}`);
      this.isError.set(true);
    }
  }

  async publish() {
    try {
      const parsed = validateDynamicScreen(this.requireScreen());
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

  updateScreenField(field: "screen" | "version", event: Event) {
    const value = (event.target as HTMLInputElement).value;
    this.patchScreen((screen) => {
      screen[field] = value;
    });
  }

  setSelectedBlockType(event: Event) {
    this.selectedBlockType.set((event.target as HTMLSelectElement).value as DynamicBlock["type"]);
  }

  addBlock() {
    const block = createDefaultBlock(this.selectedBlockType());
    this.patchScreen((screen) => {
      screen.blocks.push(block);
    });
    this.status.set(`Bloco ${block.type} adicionado.`);
    this.isError.set(false);
  }

  removeBlock(index: number) {
    this.patchScreen((screen) => {
      screen.blocks.splice(index, 1);
    });
    this.status.set("Bloco removido.");
    this.isError.set(false);
  }

  startBlockDrag(index: number, event: DragEvent) {
    this.draggedBlockIndex.set(index);
    this.dragOverBlockIndex.set(index);
    event.dataTransfer?.setData("text/plain", String(index));
    if (event.dataTransfer) {
      event.dataTransfer.effectAllowed = "move";
    }
  }

  enterBlockDropZone(index: number, event: DragEvent) {
    event.preventDefault();
    this.dragOverBlockIndex.set(index);
    if (event.dataTransfer) {
      event.dataTransfer.dropEffect = "move";
    }
  }

  dropBlock(targetIndex: number, event: DragEvent) {
    event.preventDefault();
    const sourceIndex = this.draggedBlockIndex();

    if (sourceIndex === null || sourceIndex === targetIndex) {
      this.clearDragState();
      return;
    }

    this.patchScreen((screen) => {
      const [block] = screen.blocks.splice(sourceIndex, 1);
      screen.blocks.splice(targetIndex, 0, block);
    });

    this.status.set("Ordem dos blocos atualizada.");
    this.isError.set(false);
    this.clearDragState();
  }

  clearDragState() {
    this.draggedBlockIndex.set(null);
    this.dragOverBlockIndex.set(null);
  }

  updateBlockField(index: number, field: BlockFieldDefinition, event: Event) {
    const value = (event.target as HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement).value;

    this.patchScreen((screen) => {
      const block = screen.blocks[index];
      const props = { ...block.props } as Record<string, unknown>;
      this.setPathValue(props, field.path, value);
      block.props = props as DynamicBlock["props"];
    });
  }

  fieldsFor(block: DynamicBlock): readonly BlockFieldDefinition[] {
    return getBlockDefinition(block.type).fields;
  }

  blockLabel(block: DynamicBlock): string {
    return getBlockDefinition(block.type).label;
  }

  blockDescription(block: DynamicBlock): string {
    return getBlockDefinition(block.type).description;
  }

  fieldValue(block: DynamicBlock, field: BlockFieldDefinition): string {
    const value = this.getPathValue(block.props as Record<string, unknown>, field.path);
    return typeof value === "string" ? value : "";
  }

  private patchScreen(mutator: (screen: DynamicScreen) => void) {
    const currentScreen = this.requireScreen();
    const nextScreen = JSON.parse(JSON.stringify(currentScreen)) as DynamicScreen;
    mutator(nextScreen);
    this.screen.set(nextScreen);
  }

  private requireScreen(): DynamicScreen {
    const currentScreen = this.screen();

    if (!currentScreen) {
      throw new Error("Tela ainda nao carregada.");
    }

    return currentScreen;
  }

  private getPathValue(source: Record<string, unknown>, path: string): unknown {
    return path.split(".").reduce<unknown>((current, part) => {
      if (!current || typeof current !== "object") {
        return undefined;
      }

      return (current as Record<string, unknown>)[part];
    }, source);
  }

  private setPathValue(target: Record<string, unknown>, path: string, value: string) {
    const parts = path.split(".");
    let current = target;

    parts.forEach((part, index) => {
      if (index === parts.length - 1) {
        current[part] = value;
        return;
      }

      const next = current[part];
      if (!next || typeof next !== "object") {
        current[part] = {};
      }
      current = current[part] as Record<string, unknown>;
    });

    if (path === "action.target") {
      target["action"] = {
        type: "navigate",
        ...target["action"] as Record<string, unknown>
      };
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
