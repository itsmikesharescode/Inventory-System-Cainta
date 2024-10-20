<script lang="ts">
  import * as AlertDialog from '$lib/components/ui/alert-dialog';
  import { LoaderCircle, Plus, X } from 'lucide-svelte';
  import { superForm, type Infer, type SuperValidated } from 'sveltekit-superforms';
  import { zodClient } from 'sveltekit-superforms/adapters';
  import { updateItemSchema, type UpdateItemSchema } from './schema';
  import { toast } from 'svelte-sonner';
  import * as Form from '$lib/components/ui/form';
  import { Input } from '$lib/components/ui/input';
  import { Textarea } from '$lib/components/ui/textarea/index';
  import UpdateItemSelect from './UpdateItemSelect.svelte';
  import { categoriesMeta, statusMeta, typeMeta } from '../../metadata';
  import { ScrollArea } from '$lib/components/ui/scroll-area/index';
  import type { AdminLayout } from '$lib/types/admin/adminLayout.types';
  import { Item } from '$lib/components/ui/accordion';

  interface Props {
    item: AdminLayout['items'][number];
    updateItemForm: SuperValidated<Infer<UpdateItemSchema>>;
    showUpdateItem: boolean;
  }

  let { updateItemForm, item, showUpdateItem = $bindable() }: Props = $props();

  const form = superForm(updateItemForm, {
    validators: zodClient(updateItemSchema),
    async onUpdate({ result }) {
      const { status, data } = result;
      switch (status) {
        case 200:
          toast.success('', { description: data.msg });
          showUpdateItem = false;
          break;

        case 401:
          toast.error('', { description: data.msg });
          break;
      }
    }
  });

  const { form: formData, enhance, submitting } = form;

  $effect(() => {
    if (showUpdateItem) {
      $formData.brand = item.brand;
      $formData.category = item.category;
      $formData.description = item.description;
      $formData.deviceId = item.device_id;
      $formData.model = item.model;
      $formData.mr = item.mr;
      $formData.price = item.price;
      $formData.quantity = item.quantity;
      $formData.status = item.status;
      $formData.type = item.type;
    }
  });
</script>

<AlertDialog.Root bind:open={showUpdateItem}>
  <AlertDialog.Content class="p-0">
    <ScrollArea class="max-h-screen md:max-h-[80dvh]">
      <button
        onclick={() => {
          showUpdateItem = false;
          form.reset();
        }}
        class="absolute right-4 top-4 z-30 rounded-sm opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none data-[state=open]:bg-accent data-[state=open]:text-muted-foreground"
      >
        <X class="h-4 w-4" />
        <span class="sr-only">Close</span>
      </button>

      <AlertDialog.Header class="sticky top-0 z-20 rounded-t-lg p-5 backdrop-blur-lg">
        <AlertDialog.Title>Update Item</AlertDialog.Title>
        <AlertDialog.Description>
          Kindly fill all the following fields to update an item.
        </AlertDialog.Description>
      </AlertDialog.Header>

      <form
        method="POST"
        action="?/updateItemEvent"
        use:enhance
        class="flex flex-col gap-2.5 p-5 pt-0"
      >
        <Form.Field {form} name="itemId" class="hidden">
          <Form.Control let:attrs>
            <Input {...attrs} bind:value={item.id} />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="deviceId">
          <Form.Control let:attrs>
            <Form.Label>Device ID</Form.Label>
            <Input {...attrs} bind:value={$formData.deviceId} placeholder="Enter device id" />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="model">
          <Form.Control let:attrs>
            <Form.Label>Model</Form.Label>
            <Input {...attrs} bind:value={$formData.model} placeholder="Enter model" />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="category">
          <Form.Control let:attrs>
            <Form.Label>Category</Form.Label>
            <UpdateItemSelect
              style="h-[30dvh] pr-4"
              placeholder="Select Category"
              {attrs}
              selections={categoriesMeta}
              bind:selected={$formData.category}
            />
            <input hidden bind:value={$formData.category} name={attrs.name} />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="type">
          <Form.Control let:attrs>
            <Form.Label>Type</Form.Label>
            <UpdateItemSelect
              style=""
              placeholder="Select Type"
              {attrs}
              selections={typeMeta}
              bind:selected={$formData.type}
            />
            <input hidden bind:value={$formData.type} name={attrs.name} />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="status">
          <Form.Control let:attrs>
            <Form.Label>Status</Form.Label>
            <UpdateItemSelect
              style=""
              placeholder="Select Status"
              {attrs}
              selections={statusMeta}
              bind:selected={$formData.status}
            />
            <input hidden bind:value={$formData.status} name={attrs.name} />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="mr">
          <Form.Control let:attrs>
            <Form.Label>MR</Form.Label>
            <Input {...attrs} bind:value={$formData.mr} placeholder="Enter mr" />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="brand">
          <Form.Control let:attrs>
            <Form.Label>Brand</Form.Label>
            <Input {...attrs} bind:value={$formData.brand} placeholder="Enter brand" />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="quantity">
          <Form.Control let:attrs>
            <Form.Label>Quantity</Form.Label>
            <Input
              type="number"
              {...attrs}
              bind:value={$formData.quantity}
              placeholder="Enter quantity"
            />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="price">
          <Form.Control let:attrs>
            <Form.Label>Price</Form.Label>
            <Input
              type="number"
              {...attrs}
              bind:value={$formData.price}
              placeholder="Enter price"
            />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="description">
          <Form.Control let:attrs>
            <Form.Label>Description</Form.Label>
            <Textarea
              {...attrs}
              bind:value={$formData.description}
              placeholder="Enter description"
            />
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <div class="sticky bottom-[1rem] left-0 right-0 flex justify-end">
          <Form.Button disabled={$submitting} class="relative  max-w-fit">
            {#if $submitting}
              <div
                class="absolute bottom-0 left-0 right-0 top-0 flex items-center justify-center gap-1.5 rounded-lg bg-primary"
              >
                <span>Wait</span>
                <LoaderCircle class="h-[20px] w-[20px] animate-spin" />
              </div>
            {/if}

            Update Item
          </Form.Button>
        </div>
      </form>
    </ScrollArea>
  </AlertDialog.Content>
</AlertDialog.Root>
