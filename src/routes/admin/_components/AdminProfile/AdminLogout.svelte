<script lang="ts">
  import { invalidateAll } from '$app/navigation';
  import * as AlertDialog from '$lib/components/ui/alert-dialog';
  import Button from '$lib/components/ui/button/button.svelte';
  import type { SupabaseClient } from '@supabase/supabase-js';
  import { LoaderCircle } from 'lucide-svelte';
  import { toast } from 'svelte-sonner';

  interface Props {
    supabase: SupabaseClient;
    showLogout: boolean;
  }

  let { showLogout = $bindable(), supabase }: Props = $props();

  let logoutLoader = $state(false);

  const handleLogout = async () => {
    logoutLoader = true;
    const { error } = await supabase.auth.signOut();

    if (error) {
      toast.error('', { description: error.message });
      return;
    }
    await invalidateAll();

    toast.success('', { description: 'Come back again.' });
    logoutLoader = false;
  };
</script>

<AlertDialog.Root bind:open={showLogout}>
  <AlertDialog.Content>
    <AlertDialog.Header>
      <AlertDialog.Title>Confirm Logout?</AlertDialog.Title>
      <AlertDialog.Description>You are about to log out in the system.</AlertDialog.Description>
    </AlertDialog.Header>
    <AlertDialog.Footer>
      <AlertDialog.Cancel disabled={logoutLoader}>Cancel</AlertDialog.Cancel>
      <Button disabled={logoutLoader} onclick={handleLogout} class="relative">
        {#if logoutLoader}
          <div
            class="absolute bottom-0 left-0 right-0 top-0 flex items-center justify-center gap-1.5 rounded-lg bg-primary"
          >
            <LoaderCircle class="h-[20px] w-[20px] animate-spin" />
          </div>
        {/if}
        Continue
      </Button>
    </AlertDialog.Footer>
  </AlertDialog.Content>
</AlertDialog.Root>
