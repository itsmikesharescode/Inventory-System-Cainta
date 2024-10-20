<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import * as Table from '$lib/components/ui/table';
  import AddTeacherModal from './_components/AddTeacher/AddTeacherModal.svelte';
  import TeacherMenu from './_components/TeacherMenu.svelte';

  const { data } = $props();
</script>

<div class="flex flex-col gap-5">
  <div class="flex items-center justify-between">
    <GradualSpacing
      class="font-display text-left text-4xl font-bold tracking-[-0.1em]  text-black   md:leading-[5rem]"
      words="Borrowers"
    />

    <AddTeacherModal addTeacherForm={data.addTeacherForm} />
  </div>

  <Table.Root>
    {#if false}
      <Table.Caption>No data available in the table</Table.Caption>
    {/if}
    <Table.Header>
      <Table.Row>
        <Table.Head class="w-[100px]"></Table.Head>
        <Table.Head>Teacher ID</Table.Head>
        <Table.Head>Full name</Table.Head>
        <Table.Head>Department</Table.Head>
        <Table.Head>Email</Table.Head>
        <Table.Head>Phone</Table.Head>
      </Table.Row>
    </Table.Header>
    <Table.Body>
      {#each Array(20) as _}
        <Table.Row>
          <Table.Cell>
            <TeacherMenu />
          </Table.Cell>
          <Table.Cell>asdasd</Table.Cell>
          <Table.Cell>asdasd</Table.Cell>
          <Table.Cell>rrrr</Table.Cell>
          <Table.Cell>qwe</Table.Cell>
          <Table.Cell>123123</Table.Cell>
        </Table.Row>
      {/each}
    </Table.Body>
  </Table.Root>
</div>
