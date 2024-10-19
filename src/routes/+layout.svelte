<script>
  import '../app.css';
  const { data, children } = $props();
</script>

{@render children()}

<style>
  :global(html) {
    font-family: 'Poppins', sans-serif;
  }
</style>
