<script lang="ts">
  import Button from '$lib/components/ui/button/button.svelte';
  import { FolderCog } from 'lucide-svelte';
  import * as Menubar from '$lib/components/ui/menubar';
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
      <Menubar.Item>
        Update
        <Menubar.Shortcut>⌘U</Menubar.Shortcut>
      </Menubar.Item>
      <Menubar.Separator />
      <Menubar.Item
        >Delete
        <Menubar.Shortcut>⌘D</Menubar.Shortcut>
      </Menubar.Item>
    </Menubar.Content>
  </Menubar.Menu>
</Menubar.Root>
