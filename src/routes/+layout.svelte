<script>
  import '../app.css';
  import { onNavigate } from '$app/navigation';
  import { Toaster } from '$lib/components/ui/sonner';

  const { data, children } = $props();

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
