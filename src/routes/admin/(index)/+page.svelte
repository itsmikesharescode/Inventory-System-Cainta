<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import type { PostgrestSingleResponse } from '@supabase/supabase-js';
  import BarChart from './_components/BarChart.svelte';
  import CountCard from './_components/CountCard.svelte';
  import LineChart from './_components/LineChart.svelte';

  const { data } = $props();

  const streamCounts = async () => {
    const { data: counts, error } = (await data.supabase.rpc(
      'admin_dashboard_counts'
    )) as PostgrestSingleResponse<{
      pending_count: number;
      accepted_count: number;
      canceled_count: number;
      teachers_count: number;
    }>;

    if (error) return null;
    return counts;
  };
</script>

<div class="flex flex-col gap-5">
  <div class="flex">
    <GradualSpacing
      class="font-display text-left text-4xl font-bold tracking-[-0.1em]  text-black   md:leading-[5rem]"
      words="Dashboard"
    />
  </div>

  <div class="grid grid-cols-2 gap-2.5">
    <div class="h-[30dvh]">
      <LineChart />
    </div>

    <div class="h-[30dvh]">
      <BarChart />
    </div>
  </div>

  <div class="grid grid-cols-4 gap-2.5">
    {#await streamCounts()}
      <p>Fetching</p>
    {:then counts}
      {#if counts}
        <CountCard title="Pending" count={counts.pending_count} />
        <CountCard title="Accepted" count={counts.accepted_count} />
        <CountCard title="Canceled" count={counts.canceled_count} />
        <CountCard title="Teachers" count={counts.teachers_count} />
      {:else}
        <p>Error fetching counts</p>
      {/if}
    {/await}
  </div>
</div>
