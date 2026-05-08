import { CommonModule } from "@angular/common";
import { Component, Input } from "@angular/core";
import { HeroBlock } from "@poc/shared-schema";

@Component({
  selector: "poc-hero-block",
  standalone: true,
  imports: [CommonModule],
  template: `
    <section class="hero">
      <h3>{{ props.title }}</h3>
      <p *ngIf="props.subtitle">{{ props.subtitle }}</p>
    </section>
  `,
  styles: [
    `
      .hero {
        padding: var(--spacing-xl);
        border-radius: var(--radius-lg);
        color: white;
        background: var(--color-primary);
      }

      h3 {
        margin: 0 0 var(--spacing-sm);
        font-size: var(--font-size-title);
      }

      p {
        margin: 0;
        line-height: 1.5;
      }
    `
  ]
})
export class HeroBlockComponent {
  @Input({ required: true }) props!: HeroBlock["props"];
}
