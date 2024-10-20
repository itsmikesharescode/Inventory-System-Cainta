<script lang="ts">
  import Button from '$lib/components/ui/button/button.svelte';
  import { FolderCog } from 'lucide-svelte';
  import * as Menubar from '$lib/components/ui/menubar';
</script>

<Menubar.Root>
  <Menubar.Menu>
    <Menubar.Trigger>
      <FolderCog />
    </Menubar.Trigger>
    <Menubar.Content>
      <Menubar.Item>
        New Tab
        <Menubar.Shortcut>⌘T</Menubar.Shortcut>
      </Menubar.Item>
      <Menubar.Item>New Window</Menubar.Item>
      <Menubar.Separator />
      <Menubar.Item>Share</Menubar.Item>
      <Menubar.Separator />
      <Menubar.Item>Print</Menubar.Item>
    </Menubar.Content>
  </Menubar.Menu>
</Menubar.Root>
