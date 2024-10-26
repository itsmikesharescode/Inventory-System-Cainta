<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import * as Table from '$lib/components/ui/table';
  import BorrowedMenu from './_components/BorrowedMenu.svelte';
</script>

<div class="flex flex-col gap-5">
  <div class="flex">
    <GradualSpacing
      class="font-display text-left text-4xl font-bold tracking-[-0.1em]  text-black   md:leading-[5rem]"
      words="Borrowed Items"
    />
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
      {#each Array(20) as _}
        <Table.Row>
          <Table.Cell>
            <BorrowedMenu />
          </Table.Cell>
          <Table.Cell>asdasd</Table.Cell>
          <Table.Cell>asdasd</Table.Cell>
          <Table.Cell>asdasd</Table.Cell>
          <Table.Cell>asdasd</Table.Cell>
        </Table.Row>
      {/each}
    </Table.Body>
  </Table.Root>
</div>
