<script lang="ts">
  import * as Form from '$lib/components/ui/form';
  import { Input } from '$lib/components/ui/input';
  import { updatePwdSchema } from './schema';
  import { superForm } from 'sveltekit-superforms';
  import { zodClient } from 'sveltekit-superforms/adapters';
  import { LoaderCircle } from 'lucide-svelte';
  import { toast } from 'svelte-sonner';

  const { data } = $props();

  const form = superForm(data.updatePwdForm, {
    validators: zodClient(updatePwdSchema),
    async onUpdate({ result }) {
      const { status, data } = result;
      switch (status) {
        case 200:
          toast.success('', { description: data.msg });
          break;

        case 401:
          toast.error('', { description: data.msg });
          break;
      }
    }
  });

  const { form: formData, enhance, submitting } = form;
</script>

<div class="flex h-screen flex-col items-center justify-center gap-2.5 md:border-l-2">
  <h1 class="scroll-m-20 text-2xl font-semibold tracking-tight">Update Password Page</h1>

  <form method="POST" action="?/updatePwdEvent" use:enhance class="flex flex-col gap-2.5">
    <Form.Field {form} name="newPwd">
      <Form.Control let:attrs>
        <Form.Label>New Password</Form.Label>
        <Input
          type="password"
          {...attrs}
          bind:value={$formData.newPwd}
          placeholder="Enter your password"
        />
      </Form.Control>
      <Form.FieldErrors />
    </Form.Field>

    <Form.Field {form} name="confirmNewPwd">
      <Form.Control let:attrs>
        <Form.Label>Confirm New Password</Form.Label>
        <Input
          type="password"
          {...attrs}
          bind:value={$formData.confirmNewPwd}
          placeholder="Enter your password"
        />
      </Form.Control>
      <Form.FieldErrors />
    </Form.Field>
    <Form.Button disabled={$submitting} class="relative">
      {#if $submitting}
        <div
          class="absolute bottom-0 left-0 right-0 top-0 flex items-center justify-center gap-1.5 rounded-lg bg-primary"
        >
          <span>Updating</span>
          <LoaderCircle class="h-[20px] w-[20px] animate-spin" />
        </div>
      {/if}

      Update Password
    </Form.Button>
  </form>

  <p class="mt-5 text-sm text-muted-foreground">
    Reloading this page will lose your chance to update your password.
  </p>
</div>
