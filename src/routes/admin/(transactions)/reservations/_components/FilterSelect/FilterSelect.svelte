<script lang="ts">
  import * as Select from '$lib/components/ui/select';
  import { Label } from '$lib/components/ui/label/index.js';
  import { page } from '$app/stores';
  import { goto, invalidate, pushState } from '$app/navigation';

  let selectedValue = $state('All');

  const selectedFilter = $derived(
    selectedValue ? { label: selectedValue, value: selectedValue } : undefined
  );
</script>

<div class="flex w-full max-w-sm flex-col gap-1.5">
  <Label for="email">Filter</Label>
  <Select.Root
    selected={selectedFilter}
    onSelectedChange={(v) => {
      v && (selectedValue = v.value);
    }}
  >
    <Select.Trigger class="w-[180px]">
      <Select.Value placeholder="Select Filter" />
    </Select.Trigger>
    <Select.Content>
      <Select.Item
        value="All"
        onclick={() => {
          goto(`?filter=${selectedValue.toLocaleLowerCase()}`);
        }}
      >
        All
      </Select.Item>
      <Select.Item
        value="Accepted"
        onclick={() => {
          goto(`?filter=${selectedValue.toLocaleLowerCase()}`);
        }}
      >
        Accepted
      </Select.Item>
      <Select.Item
        value="Pending"
        onclick={() => {
          goto(`?filter=${selectedValue.toLocaleLowerCase()}`);
        }}
      >
        Pending
      </Select.Item>
    </Select.Content>
  </Select.Root>
</div>
