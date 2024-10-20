<script lang="ts">
  import AdminNav from './_components/AdminNav.svelte';

  const { data, children } = $props();
</script>

<AdminNav {children} />
