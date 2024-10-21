<script lang="ts">
  import * as AlertDialog from '$lib/components/ui/alert-dialog';
  import Button from '$lib/components/ui/button/button.svelte';
  import { LoaderCircle, Plus, X } from 'lucide-svelte';
  import { superForm, type Infer, type SuperValidated } from 'sveltekit-superforms';
  import { zodClient } from 'sveltekit-superforms/adapters';
  import { toast } from 'svelte-sonner';
  import * as Form from '$lib/components/ui/form';
  import { Input } from '$lib/components/ui/input';
  import { ScrollArea } from '$lib/components/ui/scroll-area/index';
  import { updateReservationSchema, type UpdateReservationSchema } from './schema';
  import type { AdminLayout } from '$lib/types/admin/adminLayout.types';

  interface Props {
    updateReservationForm: SuperValidated<Infer<UpdateReservationSchema>>;
    showUpdateReservation: boolean;
  }

  let { updateReservationForm, showUpdateReservation = $bindable() }: Props = $props();

  const form = superForm(updateReservationForm, {
    validators: zodClient(updateReservationSchema),
    id: crypto.randomUUID(),
    async onUpdate({ result }) {
      const { status, data } = result;
      switch (status) {
        case 200:
          toast.success('', { description: data.msg });
          showUpdateReservation = false;
          break;

        case 401:
          toast.error('', { description: data.msg });
          break;
      }
    }
  });

  const { form: formData, enhance, submitting } = form;

  $effect(() => {
    /* if (showUpdateReservation) {
      $formData.fName = teacher.user_meta_data.firstname;
      $formData.mName = teacher.user_meta_data.middlename;
      $formData.lName = teacher.user_meta_data.lastname;
      $formData.email = teacher.user_meta_data.email;
      $formData.teacherId = teacher.user_meta_data.teacherId;
      $formData.phone = teacher.user_meta_data.phonenumber;
      $formData.department = teacher.user_meta_data.department;
    } */
  });
</script>

<AlertDialog.Root preventScroll={true} bind:open={showUpdateReservation}>
  <AlertDialog.Content class="p-0">
    <ScrollArea class="max-h-screen md:max-h-[80dvh]">
      <button
        onclick={() => {
          showUpdateReservation = false;
          form.reset();
        }}
        class="absolute right-4 top-4 z-30 rounded-sm opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none data-[state=open]:bg-accent data-[state=open]:text-muted-foreground"
      >
        <X class="h-4 w-4" />
        <span class="sr-only">Close</span>
      </button>

      <AlertDialog.Header class="sticky top-0 z-20 rounded-t-lg p-5 backdrop-blur-lg">
        <AlertDialog.Title>Update Teacher</AlertDialog.Title>
        <AlertDialog.Description>
          Kindly fill all the following fields to update a teacher.
        </AlertDialog.Description>
      </AlertDialog.Header>

      <form
        method="POST"
        action="?/updateTeacherEvent"
        use:enhance
        class="flex flex-col gap-2.5 p-5 pt-0"
      >
        <Form.Field {form} name="id" class="hidden">
          <Form.Control let:attrs>
            <Input {...attrs} bind:value={$formData.id} />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="name">
          <Form.Control let:attrs>
            <Form.Label>Name</Form.Label>
            <Input {...attrs} bind:value={$formData.name} placeholder="Enter name" />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="item">
          <Form.Control let:attrs>
            <Form.Label>Item</Form.Label>
            <Input {...attrs} bind:value={$formData.item} placeholder="Enter item" />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="reservationDate">
          <Form.Control let:attrs>
            <Form.Label>Reservation Date</Form.Label>
            <Input
              {...attrs}
              bind:value={$formData.reservationDate}
              placeholder="Enter reservation date"
            />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="room">
          <Form.Control let:attrs>
            <Form.Label>Room</Form.Label>
            <Input {...attrs} bind:value={$formData.room} placeholder="Enter room" />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <div class="sticky bottom-[1rem] left-0 right-0 flex justify-end">
          <Form.Button disabled={$submitting} class="relative  max-w-fit">
            {#if $submitting}
              <div
                class="absolute bottom-0 left-0 right-0 top-0 flex items-center justify-center gap-1.5 rounded-lg bg-primary"
              >
                <span>Updating</span>
                <LoaderCircle class="h-[20px] w-[20px] animate-spin" />
              </div>
            {/if}

            Update Teacher
          </Form.Button>
        </div>
      </form>
    </ScrollArea>
  </AlertDialog.Content>
</AlertDialog.Root>
