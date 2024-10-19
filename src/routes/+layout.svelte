<script>
  import '../app.css';
  import { onNavigate } from '$app/navigation';
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

{@render children()}

<style>
  :global(html) {
    font-family: 'Poppins', sans-serif;
  }
</style>
