<script lang="ts">
  import * as Select from '$lib/components/ui/select';
  import { ScrollArea } from '$lib/components/ui/scroll-area/index';
  interface Props {
    attrs: {
      name: string;
      id: string;
      'data-fs-error': string | undefined;
      'aria-describedby': string | undefined;
      'aria-invalid': 'true' | undefined;
      'aria-required': 'true' | undefined;
      'data-fs-control': string;
    };
    selections: string[];
    selected: string;
    placeholder: string;
    style: string;
  }

  let { selections, attrs, placeholder, selected = $bindable(), style }: Props = $props();
</script>

<Select.Root>
  <Select.Trigger {...attrs}>
    <Select.Value {placeholder} />
  </Select.Trigger>
  <Select.Content class="">
    <ScrollArea class={style}>
      {#each selections as select}
        <Select.Item onclick={() => (selected = select)} value={select}>{select}</Select.Item>
      {/each}
    </ScrollArea>
  </Select.Content>
</Select.Root>
