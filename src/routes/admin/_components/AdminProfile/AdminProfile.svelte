<script lang="ts">
  import * as Popover from '$lib/components/ui/popover';
  import * as Avatar from '$lib/components/ui/avatar';
</script>

<Popover.Root>
  <Popover.Trigger>
    <Avatar.Root>
      <Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" />
      <Avatar.Fallback>CN</Avatar.Fallback>
    </Avatar.Root>
  </Popover.Trigger>
  <Popover.Content>Place content for the popover here.</Popover.Content>
</Popover.Root>
