<script lang="ts">
  import * as Popover from '$lib/components/ui/popover';
  import * as Avatar from '$lib/components/ui/avatar';
  import { LogOut } from 'lucide-svelte';
  import AdminLogout from './AdminLogout.svelte';
  import Button from '$lib/components/ui/button/button.svelte';

  let showLogout = $state(false);
  let open = $state(false);
</script>

<Popover.Root bind:open>
  <Popover.Trigger>
    <Avatar.Root>
      <Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" />
      <Avatar.Fallback>CN</Avatar.Fallback>
    </Avatar.Root>
  </Popover.Trigger>
  <Popover.Content class="flex flex-col gap-2.5">
    <div class="flex items-center gap-2.5">
      <Avatar.Root>
        <Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" />
        <Avatar.Fallback>CN</Avatar.Fallback>
      </Avatar.Root>

      <div class="">
        <p class="text-sm">Admin Mike John</p>
        <p class="text-sm text-muted-foreground">admin@gmail.com</p>
      </div>
    </div>

    <div class="flex justify-end">
      <Button
        onclick={() => {
          showLogout = true;
          open = false;
        }}
        variant="destructive"
        size="sm"
        class="gap-1.5"
      >
        <LogOut class="h-[17px] w-[17px]" />
        Log out
      </Button>
    </div>
  </Popover.Content>
</Popover.Root>

<AdminLogout bind:showLogout />
