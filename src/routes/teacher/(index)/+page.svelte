<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import type { PostgrestSingleResponse } from '@supabase/supabase-js';
  import BarChart from './_components/BarChart.svelte';
  import CountCard from './_components/CountCard.svelte';
  import LineChart from './_components/LineChart.svelte';
  import { Skeleton } from '$lib/components/ui/skeleton/index.js';

  const { data } = $props();

  /* const streamCounts = async () => {
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
  }; */
</script>

<div class="flex flex-col gap-5">
  <div class="flex">
    <GradualSpacing
      class="font-display text-left text-4xl font-bold tracking-[-0.1em]  text-black   md:leading-[5rem]"
      words="Reservations"
    />
  </div>

  <div class="grid grid-cols-4 gap-2.5">
    <CountCard class="" title="Pending" count={2} />
    <CountCard class="" title="Accepted" count={2} />
    <CountCard class="" title="Canceled" count={5} />
  </div>
</div>
