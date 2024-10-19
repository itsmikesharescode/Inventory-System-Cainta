<script lang="ts">
  import * as Form from '$lib/components/ui/form';
  import { Input } from '$lib/components/ui/input';
  import { forgotPwdSchema } from './schema';
  import { type SuperValidated, type Infer, superForm } from 'sveltekit-superforms';
  import { zodClient } from 'sveltekit-superforms/adapters';

  const { data } = $props();

  const form = superForm(data.forgotPwdForm, {
    validators: zodClient(forgotPwdSchema)
  });

  const { form: formData, enhance } = form;
</script>

<div class="grid min-h-screen gap-10 py-20 md:grid-cols-[2fr,1fr] md:gap-0 md:p-0">
  <div class="flex flex-col items-center justify-center">
    <img src="/favicon.png" alt="system logo" class="w-[200px]" />
    <h1
      class="scroll-m-20 border-b pb-2 text-center font-semibold tracking-tight transition-colors first:mt-0 md:text-3xl"
    >
      ONE CAINTA COLLEGE
    </h1>

    <h1
      class="scroll-m-20 border-b pb-2 text-center font-semibold tracking-tight transition-colors first:mt-0 md:text-3xl"
    >
      BORROWING AND INVENTORY SYSTEM
    </h1>
  </div>
  <div class="flex flex-col items-center justify-center gap-2.5 md:border-l-2">
    <h1 class="scroll-m-20 text-2xl font-semibold tracking-tight">Forgot Password</h1>

    <form method="POST" use:enhance class="flex flex-col gap-2.5">
      <Form.Field {form} name="email">
        <Form.Control let:attrs>
          <Form.Label>Email</Form.Label>
          <Input {...attrs} bind:value={$formData.email} placeholder="Enter your email" />
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Button>Send Password Reset</Form.Button>
    </form>

    <p class="leading-7 [&:not(:first-child)]:mt-6">Already recovered your account?</p>
    <a href="/" class="underline transition-all hover:text-primary">Log in here</a>
  </div>
</div>
