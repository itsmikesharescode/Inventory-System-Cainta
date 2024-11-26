<script lang="ts">
  import * as Form from '$lib/components/ui/form';
  import { Input } from '$lib/components/ui/input';
  import { loginSchema } from './schema';
  import { superForm } from 'sveltekit-superforms';
  import { zodClient } from 'sveltekit-superforms/adapters';
  import { LoaderCircle } from 'lucide-svelte';
  import { toast } from 'svelte-sonner';

  const { data } = $props();

  const form = superForm(data.loginForm, {
    validators: zodClient(loginSchema),
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

<div class="grid min-h-screen gap-10 py-20 md:grid-cols-[2fr,1fr] md:gap-0 md:p-0">
  <div class="flex flex-col items-center justify-center">
    <h1
      class="scroll-m-20 border-b pb-2 text-center font-semibold tracking-tight transition-colors first:mt-0 md:text-3xl"
    >
      LOREM IPSUM
    </h1>

    <h1
      class="scroll-m-20 border-b pb-2 text-center font-semibold tracking-tight transition-colors first:mt-0 md:text-3xl"
    >
      BORROWING AND INVENTORY SYSTEM
    </h1>
  </div>
  <div class="flex flex-col items-center justify-center gap-2.5 md:border-l-2">
    <h1 class="scroll-m-20 text-2xl font-semibold tracking-tight">Log in</h1>

    <form method="POST" action="?/loginEvent" use:enhance class="flex w-[290px] flex-col gap-2.5">
      <Form.Field {form} name="email">
        <Form.Control>
          {#snippet children({ props })}
            <Form.Label>Email</Form.Label>
            <Input {...props} bind:value={$formData.email} placeholder="Enter email" />
          {/snippet}
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Field {form} name="pwd">
        <Form.Control>
          {#snippet children({ props })}
            <Form.Label>Password</Form.Label>
            <Input
              type="password"
              {...props}
              bind:value={$formData.pwd}
              placeholder="Enter password"
            />
          {/snippet}
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Button disabled={$submitting} class="relative">
        {#if $submitting}
          <div
            class="absolute bottom-0 left-0 right-0 top-0 flex items-center justify-center gap-1.5 rounded-lg bg-primary"
          >
            <span>Logging in</span>
            <LoaderCircle class="h-[20px] w-[20px] animate-spin" />
          </div>
        {/if}

        Log in
      </Form.Button>
    </form>
    <a
      href="/forgot-password"
      class=" leading-7 underline transition-all hover:text-primary [&:not(:first-child)]:mt-6"
      >Forgot Password</a
    >
    <p class=" leading-7 [&:not(:first-child)]:mt-6">Don't have an account yet?</p>
    <a href="/register" class=" underline transition-all hover:text-primary">Create here</a>
  </div>
</div>
