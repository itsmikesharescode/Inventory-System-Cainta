<script lang="ts">
  import * as AlertDialog from '$lib/components/ui/alert-dialog';
  import { X } from 'lucide-svelte';

  interface Props {
    showViewItem: boolean;
  }

  let { showViewItem = $bindable() }: Props = $props();
</script>

<AlertDialog.Root bind:open={showViewItem}>
  <AlertDialog.Content>
    <button
      onclick={() => (showViewItem = false)}
      class="absolute right-4 top-4 z-30 rounded-sm opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none data-[state=open]:bg-accent data-[state=open]:text-muted-foreground"
    >
      <X class="h-4 w-4" />
      <span class="sr-only">Close</span>
    </button>
    <AlertDialog.Header>
      <AlertDialog.Title>View Item</AlertDialog.Title>
    </AlertDialog.Header>
  </AlertDialog.Content>
</AlertDialog.Root>
