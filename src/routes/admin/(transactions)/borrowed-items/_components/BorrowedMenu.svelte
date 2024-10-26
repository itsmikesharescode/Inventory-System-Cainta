<script lang="ts">
  import { AlignJustify } from 'lucide-svelte';
  import * as Menubar from '$lib/components/ui/menubar';
  import type { Infer, SuperValidated } from 'sveltekit-superforms';
  import { pushState } from '$app/navigation';
  import type { AdminLayout } from '$lib/types/admin/adminLayout.types';

  /* interface Props {
    updateReservationForm: SuperValidated<Infer<UpdateReservationSchema>>;
    reservation: AdminLayout['reservations'][number];
  }

  const { ...props }: Props = $props(); */

  let showUpReservation = $state(false);
  let showDelReservation = $state(false);
  let showViewReservation = $state(false);
</script>

<Menubar.Root preventScroll={true} class="max-w-fit border-0">
  <Menubar.Menu>
    <Menubar.Trigger class="max-w-fit cursor-pointer data-[state=open]:bg-inherit">
      <AlignJustify class="h-[20px] w-[20px]" />
    </Menubar.Trigger>

    <Menubar.Content>
      <Menubar.Item
        onclick={() => {
          showViewReservation = true;
          /* pushState(`/admin/reservations/${props.reservation.id}`, {}); */
        }}
      >
        View
        <Menubar.Shortcut>⌘V</Menubar.Shortcut>
      </Menubar.Item>

      <Menubar.Separator />
      <Menubar.Item onclick={() => (showUpReservation = true)}>
        Update
        <Menubar.Shortcut>⌘U</Menubar.Shortcut>
      </Menubar.Item>
      <Menubar.Separator />
      <Menubar.Item onclick={() => (showDelReservation = true)}
        >Delete
        <Menubar.Shortcut>⌘D</Menubar.Shortcut>
      </Menubar.Item>
    </Menubar.Content>
  </Menubar.Menu>
</Menubar.Root>
