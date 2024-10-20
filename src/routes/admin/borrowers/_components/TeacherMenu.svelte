<script lang="ts">
  import { UserCog } from 'lucide-svelte';
  import * as Menubar from '$lib/components/ui/menubar';
  import type { Infer, SuperValidated } from 'sveltekit-superforms';
  import { pushState } from '$app/navigation';
  import ViewTeacherModal from './ViewTeacher/ViewTeacherModal.svelte';
  import UpdateTeacherModal from './UpdateTeacher/UpdateTeacherModal.svelte';
  import type { UpdateTeacherSchema } from './UpdateTeacher/schema';
  import DeleteTeacherModal from './DeleteTeacher/DeleteTeacherModal.svelte';
  import type { AdminLayout } from '$lib/types/admin/adminLayout.types';

  interface Props {
    teacher: AdminLayout['teachers'][number];
    updateTeacherForm: SuperValidated<Infer<UpdateTeacherSchema>>;
  }

  const { updateTeacherForm, teacher }: Props = $props();

  let showUpdateTeacher = $state(false);
  let showDeleteTeacher = $state(false);
  let showViewTeacher = $state(false);
</script>

<Menubar.Root preventScroll={true} class="max-w-fit border-0">
  <Menubar.Menu>
    <Menubar.Trigger class="max-w-fit cursor-pointer data-[state=open]:bg-inherit">
      <UserCog class="h-[20px] w-[20px]" />
    </Menubar.Trigger>

    <Menubar.Content>
      <Menubar.Item
        onclick={() => {
          showViewTeacher = true;
          pushState(`/admin/borrowers/${teacher.teacher_id}`, {});
        }}
      >
        View
        <Menubar.Shortcut>⌘V</Menubar.Shortcut>
      </Menubar.Item>

      <Menubar.Separator />
      <Menubar.Item onclick={() => (showUpdateTeacher = true)}>
        Update
        <Menubar.Shortcut>⌘U</Menubar.Shortcut>
      </Menubar.Item>
      <Menubar.Separator />
      <Menubar.Item onclick={() => (showDeleteTeacher = true)}
        >Delete
        <Menubar.Shortcut>⌘D</Menubar.Shortcut>
      </Menubar.Item>
    </Menubar.Content>
  </Menubar.Menu>
</Menubar.Root>

<ViewTeacherModal {teacher} bind:showViewTeacher />
<UpdateTeacherModal {updateTeacherForm} bind:showUpdateTeacher />
<DeleteTeacherModal bind:showDeleteTeacher />
