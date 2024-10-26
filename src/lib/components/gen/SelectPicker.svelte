<script lang="ts">
  import * as Select from '$lib/components/ui/select';

  interface Props {
    selections: string[];
    chosenValue: string;
    placeholder: string;
  }

  let { chosenValue = $bindable(), ...props }: Props = $props();

  const selectedValue = $derived(
    chosenValue
      ? {
          label: chosenValue,
          value: chosenValue
        }
      : undefined
  );
</script>

<Select.Root
  selected={selectedValue}
  onSelectedChange={(v) => {
    v && (chosenValue = v.value);
  }}
>
  <Select.Trigger class="">
    <Select.Value placeholder={props.placeholder} />
  </Select.Trigger>
  <Select.Content>
    {#each props.selections as selection}
      <Select.Item value={selection}>{selection}</Select.Item>
    {/each}
  </Select.Content>
</Select.Root>
