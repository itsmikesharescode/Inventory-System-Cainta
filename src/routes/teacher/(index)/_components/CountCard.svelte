<script lang="ts">
  import { cn } from '$lib/utils';
  import type { ClassValue } from 'tailwind-variants';

  interface Props {
    title: string;
    count: number;
    class: ClassValue;
  }

  const { ...props }: Props = $props();
</script>

<div class={cn('flex flex-col rounded-lg border-2 border-black p-10', props.class)}>
  <h4 class="scroll-m-20 text-xl font-semibold tracking-tight">{props.title}</h4>
  <span class="w-full text-center text-5xl text-muted-foreground"
    >{props.count.toLocaleString()}</span
  >
</div>
