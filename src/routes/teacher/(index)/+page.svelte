<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import type { PostgrestSingleResponse } from '@supabase/supabase-js';
  import { Skeleton } from '$lib/components/ui/skeleton/index.js';
  import * as Table from '$lib/components/ui/table/index.js';
  import SendReservation from './_components/SendReservation/SendReservation.svelte';

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

  <div class="flex justify-end">
    <SendReservation sendReservationForm={data.sendReservationForm} />
  </div>

  <div class="">
    <Table.Root>
      <Table.Caption>A list of your recent invoices.</Table.Caption>
      <Table.Header>
        <Table.Row>
          <Table.Head class="w-[100px]"></Table.Head>
          <Table.Head>Reservation Date</Table.Head>
          <Table.Head>Items</Table.Head>
          <Table.Head class="text-right">Room</Table.Head>
          <Table.Head class="text-right">Status</Table.Head>
        </Table.Row>
      </Table.Header>
      <Table.Body>
        {#each Array(20) as _}
          <Table.Row>
            <Table.Cell class="font-medium"></Table.Cell>
            <Table.Cell>{new Date().toLocaleDateString()}</Table.Cell>
            <Table.Cell>Credit Card</Table.Cell>
            <Table.Cell class="text-right">$250.00</Table.Cell>
            <Table.Cell class="text-right">$250.00</Table.Cell>
          </Table.Row>
        {/each}
      </Table.Body>
    </Table.Root>
  </div>
</div>
