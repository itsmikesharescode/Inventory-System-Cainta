<script lang="ts">
  import SelectPicker from '$lib/components/gen/SelectPicker.svelte';
  import { Label } from '$lib/components/ui/label/index.js';

  let chosenValue = $state('');
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
