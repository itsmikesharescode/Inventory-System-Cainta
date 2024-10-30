<script lang="ts">
  import { AlignJustify } from 'lucide-svelte';
  import * as Menubar from '$lib/components/ui/menubar';
  import type { Infer, SuperValidated } from 'sveltekit-superforms';
  import type { TeacherLayout } from '$lib/types/teacher/teacherLayout.types';
  import ViewReservationModal from './ViewReservation/ViewReservationModal.svelte';
  import DeleteReservationModal from './DeleteReservation/DeleteReservationModal.svelte';

  interface Props {
    reservation: TeacherLayout['reservations'][number];
  }

  const { reservation }: Props = $props();

  let showUpdateTeacher = $state(false);
  let showDeleteReservation = $state(false);
  let showViewReservation = $state(false);
</script>

<Menubar.Root class="max-w-fit border-0">
  <Menubar.Menu>
    <Menubar.Trigger class="max-w-fit cursor-pointer data-[state=open]:bg-inherit">
      <AlignJustify class="h-[20px] w-[20px]" />
    </Menubar.Trigger>

    <Menubar.Content>
      <Menubar.Item onclick={() => (showViewReservation = true)}>
        View
        <Menubar.Shortcut>⌘V</Menubar.Shortcut>
      </Menubar.Item>

      <Menubar.Separator />

      <Menubar.Separator />
      <Menubar.Item onclick={() => (showDeleteReservation = true)}
        >Delete
        <Menubar.Shortcut>⌘D</Menubar.Shortcut>
      </Menubar.Item>
    </Menubar.Content>
  </Menubar.Menu>
</Menubar.Root>

<ViewReservationModal bind:showViewReservation {reservation} />
<DeleteReservationModal bind:showDeleteReservation {reservation} />
