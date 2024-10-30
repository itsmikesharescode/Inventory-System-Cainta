<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import * as Table from '$lib/components/ui/table/index.js';
  import SendReservation from './_components/SendReservation/SendReservation.svelte';
  import ReservationMenu from './_components/ReservationMenu.svelte';

  const { data } = $props();
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
          <Table.Head>Reference ID</Table.Head>
          <Table.Head>Reservation Date</Table.Head>
          <Table.Head>Max Items</Table.Head>
          <Table.Head class="text-right">Room</Table.Head>
          <Table.Head class="text-right">Status</Table.Head>
        </Table.Row>
      </Table.Header>
      <Table.Body>
        {#each data.teacherLayout.data?.reservations ?? [] as reservation}
          <Table.Row>
            <Table.Cell class="font-medium">
              <ReservationMenu {reservation} />
            </Table.Cell>
            <Table.Cell>{reservation.reference_id}</Table.Cell>
            <Table.Cell>{reservation.time_limit}</Table.Cell>
            <Table.Cell>{reservation.max_items}</Table.Cell>
            <Table.Cell class="text-right">{reservation.room}</Table.Cell>
            <Table.Cell class="text-right">{reservation.status}</Table.Cell>
          </Table.Row>
        {/each}
      </Table.Body>
    </Table.Root>
  </div>
</div>
