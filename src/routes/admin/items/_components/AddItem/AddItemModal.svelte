<script lang="ts">
  import * as AlertDialog from '$lib/components/ui/alert-dialog';
  import Button from '$lib/components/ui/button/button.svelte';
  import { Plus } from 'lucide-svelte';

  let open = $state(false);
</script>

<Button onclick={() => (open = true)} class="gap-1.5">
  <Plus class="h-[20px] w-[20px]" />
  Add Item
</Button>
<AlertDialog.Root bind:open>
  <AlertDialog.Content>
    <AlertDialog.Header>
      <AlertDialog.Title>Add Item</AlertDialog.Title>
      <AlertDialog.Description>
        Kindly fill all the following fields to add an item.
      </AlertDialog.Description>
    </AlertDialog.Header>
    <AlertDialog.Footer>
      <AlertDialog.Cancel>Cancel</AlertDialog.Cancel>
      <AlertDialog.Action>Continue</AlertDialog.Action>
    </AlertDialog.Footer>
  </AlertDialog.Content>
</AlertDialog.Root>
