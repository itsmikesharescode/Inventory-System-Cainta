<script lang="ts">
  import { goto } from '$app/navigation';
  import SelectPicker from '$lib/components/gen/SelectPicker.svelte';
  import { Label } from '$lib/components/ui/label/index.js';

  let chosenValue = $state('All');

  $effect(() => {
    if (chosenValue === 'Accepted') goto('?filter=accepted', { invalidateAll: false });
    else if (chosenValue === 'Pending') goto('?filter=pending', { invalidateAll: false });
    else goto('/admin/reservations', { invalidateAll: false });
  });
</script>

<div class="">
  <div class="flex w-full max-w-sm flex-col gap-1.5">
    <Label for="email">Filter</Label>
    <SelectPicker
      class=""
      placeholder="Select Filter"
      bind:chosenValue
      selections={['All', 'Accepted', 'Pending']}
    />
  </div>
</div>
