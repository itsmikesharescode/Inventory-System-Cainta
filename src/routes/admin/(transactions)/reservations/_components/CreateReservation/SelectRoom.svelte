<script lang="ts">
  import * as Select from '$lib/components/ui/select';

  interface Props {
    selections: string[];
    selected: string;
    placeholder: string;
  }

  let { selections, placeholder, selected = $bindable() }: Props = $props();

  const selectedValue = $derived(selected ? { label: selected, value: selected } : undefined);
</script>

<Select.Root
  selected={selectedValue}
  onSelectedChange={(v) => {
    v && (selected = v.value);
  }}
>
  <Select.Trigger class="">
    <Select.Value {placeholder} />
  </Select.Trigger>
  <Select.Content>
    {#each selections as selection}
      <Select.Item value={selection}>{selection}</Select.Item>
    {/each}
  </Select.Content>
</Select.Root>
