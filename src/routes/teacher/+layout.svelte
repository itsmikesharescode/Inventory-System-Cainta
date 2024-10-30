<script lang="ts">
  import TeacherNav from './_components/TeacherNav.svelte';

  const { data, children } = $props();
</script>

<div class="container">
  <TeacherNav supabase={data.supabase} />
  {@render children()}
</div>
