<script>
  import '../app.css';
  import { invalidate, onNavigate } from '$app/navigation';
  import { Toaster } from '$lib/components/ui/sonner';
  import { onMount } from 'svelte';

  const { data: clientSb, children } = $props();

  onMount(() => {
    const { data } = clientSb.supabase.auth.onAuthStateChange((_, newSession) => {
      if (newSession?.expires_at !== clientSb.session?.expires_at) {
        invalidate('supabase:auth');
      }
    });

    return () => data.subscription.unsubscribe();
  });

  onNavigate((navigation) => {
    if (!document.startViewTransition) return;

    return new Promise((resolve) => {
      document.startViewTransition(async () => {
        resolve();
        await navigation.complete;
      });
    });
  });
</script>

<Toaster richColors={true} position="bottom-left" />

{@render children()}

<style>
  :global(html) {
    font-family: 'Poppins', sans-serif;
  }
</style>
