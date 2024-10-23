<script lang="ts">
  import * as AlertDialog from '$lib/components/ui/alert-dialog';
  import { page } from '$app/stores';
  import { goto, pushState } from '$app/navigation';
  import Button from '$lib/components/ui/button/button.svelte';

  const isOpen = $derived($page.url.searchParams.get('new') === 'true');
</script>

<AlertDialog.Root open={isOpen}>
  <AlertDialog.Content>
    <AlertDialog.Header>
      <AlertDialog.Title>Are you absolutely sure?</AlertDialog.Title>
      <AlertDialog.Description>
        This action cannot be undone. This will permanently delete your account and remove your data
        from our servers.
      </AlertDialog.Description>
    </AlertDialog.Header>
    <AlertDialog.Footer>
      <Button href="/admin/reservations" variant="secondary">Cancel</Button>
      <AlertDialog.Action>Continue</AlertDialog.Action>
    </AlertDialog.Footer>
  </AlertDialog.Content>
</AlertDialog.Root>
