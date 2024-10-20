<script lang="ts">
  import AdminNav from './_components/AdminNav.svelte';

  const { data, children } = $props();
</script>

<div class="container">
  <AdminNav supabase={data.supabase} />
  {@render children()}
</div>
