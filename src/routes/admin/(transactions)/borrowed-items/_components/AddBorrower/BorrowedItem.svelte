<script lang="ts">
  import Button from '$lib/components/ui/button/button.svelte';
  import * as Popover from '$lib/components/ui/popover';
  let selectedItems = $state([]);
</script>

<div
  class="relative flex min-h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 aria-[invalid]:border-destructive [&>span]:line-clamp-1 data-[placeholder]:[&>span]:text-muted-foreground"
>
  <Popover.Root>
    <Popover.Trigger class=" absolute right-0 top-0">Add Item</Popover.Trigger>
    <Popover.Content>
      Lorem ipsum dolor sit amet consectetur adipisicing elit. Unde temporibus dolore sapiente
      excepturi provident eaque mollitia repellat eius reiciendis nihil. Praesentium repudiandae
      natus dolorum enim. Sit neque aliquam odit iusto unde corrupti assumenda, nam porro eaque
      provident aspernatur minima itaque autem? Quasi dicta accusamus officia quia facilis, optio
      accusantium architecto.
    </Popover.Content>
  </Popover.Root>
</div>
