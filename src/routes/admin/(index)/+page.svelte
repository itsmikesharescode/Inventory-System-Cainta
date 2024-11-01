<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import type { PostgrestSingleResponse } from '@supabase/supabase-js';
  import BarChart from './_components/BarChart.svelte';
  import CountCard from './_components/CountCard.svelte';
  import LineChart from './_components/LineChart.svelte';
  import { Skeleton } from '$lib/components/ui/skeleton/index.js';
  import type { GraphCountsType } from '../../../types';

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

  const streamGraphCounts = async () => {
    const { data: counts, error } = (await data.supabase.rpc(
      'admin_dashboard_graph_counts'
    )) as PostgrestSingleResponse<GraphCountsType>;

    if (error) return null;
    return counts;
  };

  streamGraphCounts();
</script>

<div class="flex flex-col gap-5">
  <div class="flex">
    <GradualSpacing
      class="font-display text-left text-4xl font-bold tracking-[-0.1em]  text-black   md:leading-[5rem]"
      words="Dashboard"
    />
  </div>
  {#await streamGraphCounts()}
    <div class="grid grid-cols-2 gap-2.5">
      <div class="flex h-[30dvh] flex-col gap-[0.5dvh]">
        <Skeleton class="h-[8dvh] w-[60%] bg-slate-400" />
        <Skeleton class="h-[8dvh] w-[90%] bg-slate-400" />
        <Skeleton class="h-[8dvh] w-[30%] bg-slate-400" />
      </div>

      <div class="flex h-[30dvh] flex-col gap-[0.5dvh]">
        <Skeleton class="h-[8dvh] w-full bg-slate-400" />
        <Skeleton class="h-[8dvh] w-[70%] bg-slate-400" />
        <Skeleton class="h-[8dvh] w-full bg-slate-400" />
      </div>
    </div>
  {:then counts}
    <div class="grid grid-cols-2 gap-2.5">
      <div class="h-[30dvh]">
        <LineChart
          accepted={counts?.accepted ?? []}
          canceled={counts?.canceled ?? []}
          pending={counts?.pending ?? []}
        />
      </div>

      <div class="h-[30dvh]">
        <BarChart reservations={counts?.reservations ?? []} />
      </div>
    </div>
  {/await}

  <div class="grid grid-cols-4 gap-2.5">
    {#await streamCounts()}
      <Skeleton class="h-[183px] w-full bg-slate-400" />
      <Skeleton class="h-[183px] w-full bg-slate-400" />
      <Skeleton class="h-[183px] w-full bg-slate-400" />
      <Skeleton class="h-[183px] w-full bg-slate-400" />
    {:then counts}
      {#if counts}
        <CountCard title="Pending" count={counts.pending_count} />
        <CountCard title="Accepted" count={counts.accepted_count} />
        <CountCard title="Canceled" count={counts.canceled_count} />
        <CountCard title="Accounts" count={counts.teachers_count} />
      {:else}
        <p>Error fetching counts</p>
      {/if}
    {/await}
  </div>
</div>
