<script lang="ts">
  import * as Popover from '$lib/components/ui/popover';
  import * as Avatar from '$lib/components/ui/avatar';
  import { LogOut } from 'lucide-svelte';
  import AdminLogout from './AdminLogout.svelte';
  import Button from '$lib/components/ui/button/button.svelte';
  import type { SupabaseClient } from '@supabase/supabase-js';
  import { fromUserState } from '$lib/runes/userState.svelte';
  import Badge from '$lib/components/ui/badge/badge.svelte';

  interface Props {
    supabase: SupabaseClient;
  }

  const { supabase }: Props = $props();

  const user = fromUserState();

  const userRef = $derived(user.get());

  let samplePhoto = '';

  let showLogout = $state(false);
  let open = $state(false);
</script>

{#if userRef}
  <Popover.Root bind:open>
    <Popover.Trigger>
      <Avatar.Root>
        <Avatar.Image src={samplePhoto} alt="admin photo" />
        <Avatar.Fallback>A</Avatar.Fallback>
      </Avatar.Root>
    </Popover.Trigger>
    <Popover.Content class="flex flex-col gap-2.5">
      <div class="flex items-center gap-2.5">
        <Avatar.Root>
          <Avatar.Image src={samplePhoto} alt="admin photo" />
          <Avatar.Fallback>A</Avatar.Fallback>
        </Avatar.Root>

        <div class="">
          <p class="text-sm">{userRef.user_metadata.firstname}</p>
          <p class="text-sm text-muted-foreground">{userRef.email}</p>
        </div>
      </div>

      <div class="flex justify-between">
        <Badge variant="outline">{userRef.user_metadata.role}</Badge>
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
  <AdminLogout bind:showLogout {supabase} />
{/if}
