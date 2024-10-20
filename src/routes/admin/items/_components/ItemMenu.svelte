<script lang="ts">
  import Button from '$lib/components/ui/button/button.svelte';
  import { FolderCog } from 'lucide-svelte';
  import * as Menubar from '$lib/components/ui/menubar';
  import UpdateItemModal from './UpdateItem/UpdateItemModal.svelte';
  import type { Infer, SuperValidated } from 'sveltekit-superforms';
  import type { UpdateItemSchema } from './UpdateItem/schema';
  import DeleteItemModal from './DeleteItem/DeleteItemModal.svelte';

  interface Props {
    updateItemForm: SuperValidated<Infer<UpdateItemSchema>>;
  }

  const { updateItemForm }: Props = $props();

  let showUpdateItem = $state(false);
  let showDeleteItem = $state(false);
</script>

<Menubar.Root preventScroll={true} class="max-w-fit border-0">
  <Menubar.Menu>
    <Menubar.Trigger class="max-w-fit cursor-pointer data-[state=open]:bg-inherit">
      <FolderCog class="h-[20px] w-[20px]" />
    </Menubar.Trigger>

    <Menubar.Content>
      <Menubar.Item>
        View
        <Menubar.Shortcut>⌘V</Menubar.Shortcut>
      </Menubar.Item>
      <Menubar.Separator />
      <Menubar.Item onclick={() => (showUpdateItem = true)}>
        Update
        <Menubar.Shortcut>⌘U</Menubar.Shortcut>
      </Menubar.Item>
      <Menubar.Separator />
      <Menubar.Item onclick={() => (showDeleteItem = true)}
        >Delete
        <Menubar.Shortcut>⌘D</Menubar.Shortcut>
      </Menubar.Item>
    </Menubar.Content>
  </Menubar.Menu>
</Menubar.Root>

<UpdateItemModal {updateItemForm} bind:showUpdateItem />
<DeleteItemModal bind:showDeleteItem />
