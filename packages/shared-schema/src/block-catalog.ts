import type { DynamicBlock } from './index';

export type FieldKind = 'text' | 'textarea' | 'select' | 'url';

export type BlockFieldDefinition = {
  path: string;
  label: string;
  kind: FieldKind;
  options?: readonly string[];
};

export type BlockDefinition = {
  type: DynamicBlock['type'];
  label: string;
  description: string;
  fields: readonly BlockFieldDefinition[];
  createDefaultBlock: () => DynamicBlock;
};

export const blockCatalog = [
  {
    type: 'hero',
    label: 'Hero',
    description: 'Cabecalho de destaque da tela.',
    fields: [
      { path: 'title', label: 'Titulo', kind: 'text' },
      { path: 'subtitle', label: 'Subtitulo', kind: 'text' },
    ],
    createDefaultBlock: () => ({
      type: 'hero',
      props: {
        title: 'Novo hero',
        subtitle: 'Subtitulo do hero',
      },
    }),
  },
  {
    type: 'text',
    label: 'Texto',
    description: 'Conteudo textual simples ou link.',
    fields: [
      { path: 'content', label: 'Conteudo', kind: 'textarea' },
      { path: 'variant', label: 'Variante', kind: 'select', options: ['default', 'link'] },
      { path: 'href', label: 'Href', kind: 'url' },
    ],
    createDefaultBlock: () => ({
      type: 'text',
      props: {
        content: 'Novo texto',
        variant: 'default',
      },
    }),
  },
  {
    type: 'card',
    label: 'Card',
    description: 'Agrupamento curto com titulo e descricao.',
    fields: [
      { path: 'title', label: 'Titulo', kind: 'text' },
      { path: 'description', label: 'Descricao', kind: 'textarea' },
    ],
    createDefaultBlock: () => ({
      type: 'card',
      props: {
        title: 'Novo card',
        description: 'Descricao do card',
      },
    }),
  },
  {
    type: 'button',
    label: 'Botao',
    description: 'Chamada de acao com variante e destino.',
    fields: [
      { path: 'label', label: 'Label', kind: 'text' },
      { path: 'variant', label: 'Variante', kind: 'select', options: ['primary', 'secondary'] },
      { path: 'action.target', label: 'Target', kind: 'text' },
    ],
    createDefaultBlock: () => ({
      type: 'button',
      props: {
        label: 'Novo botao',
        variant: 'primary',
        action: {
          type: 'navigate',
          target: '/home',
        },
      },
    }),
  },
  {
    type: 'video',
    label: 'Video',
    description: 'Player de video do YouTube.',
    fields: [
      { path: 'videoUrl', label: 'YouTube URL', kind: 'url' },
      { path: 'content', label: 'Descricao', kind: 'textarea' },
    ],
    createDefaultBlock: () => ({
      type: 'video',
      props: {
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        content: 'Descricao do video',
      },
    }),
  },
] as const satisfies readonly BlockDefinition[];

export function getBlockDefinition(type: DynamicBlock['type']): BlockDefinition {
  const definition = blockCatalog.find(block => block.type === type);

  if (!definition) {
    throw new Error(`Bloco sem definicao no catalogo: ${type}`);
  }

  return definition;
}

export function createDefaultBlock(type: DynamicBlock['type']): DynamicBlock {
  return getBlockDefinition(type).createDefaultBlock();
}
