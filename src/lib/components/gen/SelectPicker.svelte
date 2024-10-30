<script lang="ts">
  import * as Select from '$lib/components/ui/select/index.js';
  import { cn } from '$lib/utils';
  import type { ClassNameValue } from 'tailwind-merge';

  interface Props {
    formProps: {
      name: string;
      id: string;
      'data-fs-error': string | undefined;
      'aria-describedby': string | undefined;
      'aria-invalid': 'true' | undefined;
      'aria-required': 'true' | undefined;
      'data-fs-control': string;
    } | null;
    value: string;
    selections: {
      value: string;
      label: string;
    }[];
    class: ClassNameValue;
    name: string;
  }

  let { value = $bindable(), ...props }: Props = $props();

  const triggerContent = $derived(
    props.selections.find((f) => f.value === value)?.value ?? props.name
  );
</script>

<Select.Root {...props.formProps} type="single" name={props.name} bind:value>
  <Select.Trigger class={cn('', props.class)}>
    {triggerContent}
  </Select.Trigger>
  <Select.Content>
    <Select.Group>
      {#each props.selections as selection}
        <Select.Item title={selection.label} value={selection.value} label={selection.label}
          >{selection.value}</Select.Item
        >
      {/each}
    </Select.Group>
  </Select.Content>
</Select.Root>
