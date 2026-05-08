import { CommonModule } from "@angular/common";
import { Component, Input } from "@angular/core";
import {
  ButtonBlock,
  CardBlock,
  DynamicBlock,
  HeroBlock,
  TextBlock
} from "@poc/shared-schema";
import { ButtonBlockComponent } from "../blocks/button-block.component";
import { CardBlockComponent } from "../blocks/card-block.component";
import { HeroBlockComponent } from "../blocks/hero-block.component";
import { TextBlockComponent } from "../blocks/text-block.component";

@Component({
  selector: "poc-dynamic-screen-renderer",
  standalone: true,
  imports: [
    CommonModule,
    HeroBlockComponent,
    TextBlockComponent,
    CardBlockComponent,
    ButtonBlockComponent
  ],
  templateUrl: "./dynamic-screen-renderer.component.html",
  styleUrl: "./dynamic-screen-renderer.component.css"
})
export class DynamicScreenRendererComponent {
  @Input({ required: true }) blocks: DynamicBlock[] = [];

  asHeroProps(block: DynamicBlock): HeroBlock["props"] {
    return block.props as HeroBlock["props"];
  }

  asTextProps(block: DynamicBlock): TextBlock["props"] {
    return block.props as TextBlock["props"];
  }

  asCardProps(block: DynamicBlock): CardBlock["props"] {
    return block.props as CardBlock["props"];
  }

  asButtonProps(block: DynamicBlock): ButtonBlock["props"] {
    return block.props as ButtonBlock["props"];
  }
}
