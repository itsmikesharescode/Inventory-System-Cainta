<script lang="ts">
  import { onMount } from 'svelte';
  import Chart from 'chart.js/auto';
  import type { GraphCountsType } from '../../../../types';

  interface Props {
    reservations: GraphCountsType['reservations'];
  }

  let { reservations }: Props = $props();

  let chartCanvas: HTMLCanvasElement | undefined = $state(undefined);
  let chartInstance: Chart | null = $state(null);

  // needs optimize for now lets cohers this sht
  const reservationValues: number[] = reservations.map((item) => item.count);
  const reservationLabels: string[] = reservations.map((item) => item.day);

  onMount(async () => {
    if (typeof window !== 'undefined') {
      createChart();
    }
  });

  function createChart() {
    if (!chartCanvas) return;

    const ctx = chartCanvas.getContext('2d');
    if (!ctx) return;

    chartInstance = new Chart(ctx, {
      type: 'bar',

      data: {
        labels: reservationLabels,
        datasets: [
          {
            label: 'Reservations this month',
            backgroundColor: '#000000',
            data: reservationValues
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,

        scales: {
          x: {
            display: true,
            offset: true
          },
          y: {
            display: true,
            offset: true
          }
        },
        plugins: {}
      }
    });
  }

  /* $effect(() => {
    if (chartInstance) {
      chartInstance.data.datasets[0].backgroundColor = theme.get();
      chartInstance.update();
    }
  }); */
</script>

<canvas bind:this={chartCanvas} id="myChart"></canvas>

<style>
  canvas {
    width: 100% !important;
    height: 100% !important;
  }
</style>
