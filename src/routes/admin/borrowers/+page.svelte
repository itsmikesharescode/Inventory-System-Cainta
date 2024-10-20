<script lang="ts">
  import GradualSpacing from '$lib/components/gen/GradualSpacing.svelte';
  import * as Table from '$lib/components/ui/table';

  /* {
    fName: z.string().min(1, { message: 'Must enter a first name.' }),
    mName: z.string().min(1, { message: 'Must enter a middle name.' }),
    lName: z.string().min(1, { message: 'Must enter a last name.' }),
    teacherId: z.string().min(3, { message: 'Must enter a valid teacher id.' }),
    phone: z.string().min(5, { message: 'Must enter a phone number.' }),
    department: z.string().min(1, { message: 'Must enter department.' }),
    email: z.string().email({ message: 'Must enter a valid email.' }),
    pwd: z.string().min(8, { message: 'Must choose a strong password.' }),
    confirmPwd: z.string()
    } */
</script>

<div class="flex flex-col gap-5">
  <div class="flex items-center justify-between">
    <GradualSpacing
      class="font-display text-left text-4xl font-bold tracking-[-0.1em]  text-black   md:leading-[5rem]"
      words="Borrowers"
    />
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
          <Table.Cell>Menu here</Table.Cell>
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
