<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import BarChart from './_components/BarChart.svelte';
  import CountCard from './_components/CountCard.svelte';
  import LineChart from './_components/LineChart.svelte';
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
    <CountCard title="Pending" count={8} />
    <CountCard title="Accepted" count={18} />
    <CountCard title="Canceled" count={5} />
    <CountCard title="Teachers" count={305} />
  </div>
</div>
