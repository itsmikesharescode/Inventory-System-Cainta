<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import Button from '$lib/components/ui/button/button.svelte';
  import * as Table from '$lib/components/ui/table';
  import AddItemModal from './_components/AddItem/AddItemModal.svelte';
  import ItemMenu from './_components/ItemMenu.svelte';

  const { data } = $props();
</script>

<div class="flex flex-col gap-5">
  <div class="flex items-center justify-between gap-2.5">
    <GradualSpacing
      class="font-display text-left text-4xl font-bold tracking-[-0.1em]  text-black   md:leading-[5rem]"
      words="Items"
    />

    <AddItemModal addItemForm={data.addItemForm} />
  </div>

  <Table.Root>
    <Table.Caption>No data available in the table</Table.Caption>
    <Table.Header>
      <Table.Row>
        <Table.Head class="w-[100px]"></Table.Head>
        <Table.Head>Model</Table.Head>
        <Table.Head>Category</Table.Head>
        <Table.Head>Brand</Table.Head>
        <Table.Head>Initial Quantity</Table.Head>
        <Table.Head>Final Quantity</Table.Head>
        <Table.Head>Status</Table.Head>
      </Table.Row>
    </Table.Header>
    <Table.Body>
      {#each Array(20) as _}
        <Table.Row>
          <Table.Cell>
            <ItemMenu />
          </Table.Cell>
          <Table.Cell>Paid</Table.Cell>
          <Table.Cell>Credit Card</Table.Cell>
          <Table.Cell>$250.00</Table.Cell>
          <Table.Cell>$250.00</Table.Cell>
          <Table.Cell>$250.00</Table.Cell>
          <Table.Cell>$250.00</Table.Cell>
        </Table.Row>
      {/each}
    </Table.Body>
  </Table.Root>
</div>
