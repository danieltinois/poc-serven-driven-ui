import { NgIf } from '@angular/common';
import { Component, Input } from '@angular/core';
import { TextBlock } from '@poc/shared-schema';
@Component({
  selector: 'poc-text-block',
  standalone: true,
  imports: [NgIf],
  template: `
    <ng-container *ngIf="props.variant === 'link'; else text">
      <a [href]="props.href" target="_blank">
        {{ props.content }}
      </a>
    </ng-container>

    <ng-template #text>
      <p>{{ props.content }}</p>
    </ng-template>
  `,
  styles: [
    `
      p {
        margin: 0;
        color: var(--color-text);
        font-size: var(--font-size-body);
        line-height: 1.6;
      }

      a {
        color: var(--color-primary);
        text-decoration: none;
        font-weight: 700;
      }
    `,
  ],
})
export class TextBlockComponent {
  @Input({ required: true }) props!: TextBlock['props'];
}
