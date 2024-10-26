<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import * as Table from '$lib/components/ui/table';
  import CreateReservation from './_components/CreateReservation/CreateReservation.svelte';
  import FilterSelect from './_components/FilterSelect/FilterSelect.svelte';
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

  <div class="flex items-center justify-between gap-2.5">
    <FilterSelect />

    <CreateReservation createReservationForm={data.createReservationForm} />
  </div>

  <Table.Root>
    {#if !data.adminLayout.data?.reservations.length}
      <Table.Caption>No data available in the table</Table.Caption>
    {/if}
    <Table.Header>
      <Table.Row>
        <Table.Head class="w-[100px]"></Table.Head>
        <Table.Head>Name</Table.Head>
        <Table.Head>Items</Table.Head>
        <Table.Head>Reservation Date</Table.Head>
        <Table.Head>Rooms</Table.Head>
      </Table.Row>
    </Table.Header>
    <Table.Body>
      {#each data.adminLayout.data?.reservations ?? [] as reservation}
        <Table.Row>
          <Table.Cell>
            <ReservationMenu updateReservationForm={data.updateReservationForm} {reservation} />
          </Table.Cell>
          <Table.Cell>{reservation.teacher_name}</Table.Cell>
          <Table.Cell>{reservation.max_items}</Table.Cell>
          <Table.Cell>{reservation.time_limit}</Table.Cell>
          <Table.Cell>{reservation.room}</Table.Cell>
        </Table.Row>
      {/each}
    </Table.Body>
  </Table.Root>
</div>
