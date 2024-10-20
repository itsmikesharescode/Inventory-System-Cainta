<script lang="ts">
  import { FolderCog } from 'lucide-svelte';
  import * as Menubar from '$lib/components/ui/menubar';
  import UpdateItemModal from './UpdateItem/UpdateItemModal.svelte';
  import type { Infer, SuperValidated } from 'sveltekit-superforms';
  import type { UpdateItemSchema } from './UpdateItem/schema';
  import DeleteItemModal from './DeleteItem/DeleteItemModal.svelte';
  import ViewItemModal from './ViewItem/ViewItemModal.svelte';
  import { goto, preloadData, pushState } from '$app/navigation';

  interface Props {
    updateItemForm: SuperValidated<Infer<UpdateItemSchema>>;
  }

  const { updateItemForm }: Props = $props();

  let showUpdateItem = $state(false);
  let showDeleteItem = $state(false);
  let showViewItem = $state(false);
</script>

<Menubar.Root preventScroll={true} class="max-w-fit border-0">
  <Menubar.Menu>
    <Menubar.Trigger class="max-w-fit cursor-pointer data-[state=open]:bg-inherit">
      <FolderCog class="h-[20px] w-[20px]" />
    </Menubar.Trigger>

    <Menubar.Content>
      <!-- svelte-ignore event_directive_deprecated -->
      <a
        href="/admin/items/123123"
        on:click={async (e) => {
          e.preventDefault();
          showViewItem = true;
          const { href } = e.currentTarget;
          pushState(href, { selected: 'sample' });

          /* const { href } = e.currentTarget;

          const result = await preloadData(href);

          if (result.type === 'loaded' && result.status === 200) {
            pushState(href, { selected: result.data });
          } else {
            // something bad happened! try navigating
            goto(href);
          } */
        }}
      >
        <Menubar.Item>
          View
          <Menubar.Shortcut>⌘V</Menubar.Shortcut>
        </Menubar.Item>
      </a>
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

<ViewItemModal bind:showViewItem />
<UpdateItemModal {updateItemForm} bind:showUpdateItem />
<DeleteItemModal bind:showDeleteItem />
