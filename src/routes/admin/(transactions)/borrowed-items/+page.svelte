<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import * as Table from '$lib/components/ui/table';
  import AddBorrower from './_components/AddBorrower/AddBorrower.svelte';
  import BorrowedMenu from './_components/BorrowedMenu.svelte';
  import * as Popover from '$lib/components/ui/popover';
  import RenderBorrowedItems from './_components/RenderBorrowedItems.svelte';

  const { data } = $props();
</script>

<div class="flex flex-col gap-5">
  <div class="flex">
    <GradualSpacing
      class="font-display text-left text-4xl font-bold tracking-[-0.1em]  text-black   md:leading-[5rem]"
      words="Borrowed Items"
    />
  </div>

  <div class="flex justify-end">
    <AddBorrower addBorrowerForm={data.addBorrowerForm} />
  </div>

  <Table.Root>
    <Table.Caption>A list of your recent invoices.</Table.Caption>
    <Table.Header>
      <Table.Row>
        <Table.Head class="w-[100px]"></Table.Head>
        <Table.Head>Borrower Name</Table.Head>
        <Table.Head>Borrowed Date</Table.Head>
        <Table.Head>Items Borrowed</Table.Head>
        <Table.Head>Room</Table.Head>
      </Table.Row>
    </Table.Header>
    <Table.Body>
      {#each data.adminLayout.data?.borrowed_items ?? [] as borrower}
        <Table.Row>
          <Table.Cell>
            <BorrowedMenu updateBorrowerForm={data.updateBorrowerForm} {borrower} />
          </Table.Cell>
          <Table.Cell>{borrower.borrower_name}</Table.Cell>
          <Table.Cell>{borrower.borrowed_date}</Table.Cell>
          <Table.Cell>
            <RenderBorrowedItems {borrower} />
          </Table.Cell>
          <Table.Cell>{borrower.room}</Table.Cell>
        </Table.Row>
      {/each}
    </Table.Body>
  </Table.Root>
</div>
