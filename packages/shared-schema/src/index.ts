import { z } from 'zod';

export const blockTypes = ['hero', 'text', 'button', 'card', 'video'] as const;
export const buttonVariants = ['primary', 'secondary'] as const;
export const textVariants = ['default', 'link'] as const;

const actionSchema = z.object({
  type: z.literal('navigate'),
  target: z.string().min(1),
});

export const heroBlockSchema = z.object({
  type: z.literal('hero'),
  props: z.object({
    title: z.string().min(1),
    subtitle: z.string().optional(),
  }),
});

export const textBlockSchema = z.object({
  type: z.literal('text'),
  props: z.object({
    content: z.string().min(1),
    variant: z.enum(textVariants).default('default'),
    href: z.string().min(1).optional(),
  }),
});

export const cardBlockSchema = z.object({
  type: z.literal('card'),
  props: z.object({
    title: z.string().min(1),
    description: z.string().min(1),
  }),
});

export const buttonBlockSchema = z.object({
  type: z.literal('button'),
  props: z.object({
    label: z.string().min(1),
    variant: z.enum(buttonVariants).default('primary'),
    action: actionSchema.optional(),
  }),
});

export const videoBlockSchema = z.object({
  type: z.literal('video'),
  props: z.object({
    videoUrl: z.string().min(1),
    content: z.string().min(1).optional(),
  }),
});

export const dynamicBlockSchema = z.discriminatedUnion('type', [
  heroBlockSchema,
  textBlockSchema,
  cardBlockSchema,
  buttonBlockSchema,
  videoBlockSchema,
]);

export const dynamicScreenSchema = z.object({
  screen: z.string().min(1),
  version: z.string().min(1),
  blocks: z.array(dynamicBlockSchema).min(1),
});

export type HeroBlock = z.infer<typeof heroBlockSchema>;
export type TextBlock = z.infer<typeof textBlockSchema>;
export type CardBlock = z.infer<typeof cardBlockSchema>;
export type ButtonBlock = z.infer<typeof buttonBlockSchema>;
export type VideoBlock = z.infer<typeof videoBlockSchema>;
export type DynamicBlock = z.infer<typeof dynamicBlockSchema>;
export type DynamicScreen = z.infer<typeof dynamicScreenSchema>;

export function validateDynamicScreen(payload: unknown): DynamicScreen {
  return dynamicScreenSchema.parse(payload);
}

export function formatZodError(error: z.ZodError): string[] {
  return error.issues.map(issue => {
    const path = issue.path.length > 0 ? issue.path.join('.') : 'payload';
    return `${path}: ${issue.message}`;
  });
}

export * from './block-catalog';
