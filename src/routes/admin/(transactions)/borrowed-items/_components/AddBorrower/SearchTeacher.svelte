<script lang="ts">
  import * as Popover from '$lib/components/ui/popover';
  import * as Command from '$lib/components/ui/command';
  import { ScrollArea } from '$lib/components/ui/scroll-area/index.js';
  import type { AdminLayout } from '$lib/types/admin/adminLayout.types';
  interface Props {
    chosenTeacher: AdminLayout['teachers'][number];
    name: string;
  }

  let { chosenTeacher = $bindable(), ...props }: Props = $props();
</script>

<Popover.Root>
  <Popover.Trigger
    class="flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 aria-[invalid]:border-destructive [&>span]:line-clamp-1 data-[placeholder]:[&>span]:text-muted-foreground"
  >
    <span class={chosenTeacher ? 'text-black' : 'text-gray-500'}
      >{chosenTeacher
        ? `${chosenTeacher.user_meta_data.lastname}, ${chosenTeacher.user_meta_data.firstname}`
        : props.name}</span
    >
  </Popover.Trigger>
  <Popover.Content>
    <Command.Root>
      <Command.Input placeholder="Search teacher..." />
      <ScrollArea class="h-[30dvh]">
        <Command.List asChild>
          <Command.Empty>No results found.</Command.Empty>
          <Command.Group heading="Available teacher">
            {#each Array(20) as _, index}
              <Command.Item onclick={() => {}}>Teacher one {index + 1}</Command.Item>
            {/each}
          </Command.Group>
          <Command.Separator />
        </Command.List>
      </ScrollArea>
    </Command.Root>
  </Popover.Content>
</Popover.Root>
