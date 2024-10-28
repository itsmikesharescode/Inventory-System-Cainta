<script lang="ts">
  import * as Form from '$lib/components/ui/form';
  import { Input } from '$lib/components/ui/input';
  import { LoaderCircle } from 'lucide-svelte';
  import { registerSchema } from './schema';
  import { superForm } from 'sveltekit-superforms';
  import { zodClient } from 'sveltekit-superforms/adapters';
  import { toast } from 'svelte-sonner';
  import { ScrollArea } from '$lib/components/ui/scroll-area/index.js';

  const { data } = $props();

  const form = superForm(data.registerForm, {
    validators: zodClient(registerSchema),
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

  <ScrollArea class="md:h-screen">
    <div class="flex flex-col items-center gap-2.5 md:border-l-2 md:py-20">
      <h1 class="scroll-m-20 text-2xl font-semibold tracking-tight">Register</h1>

      <form
        method="POST"
        action="?/registerEvent"
        use:enhance
        class="flex w-[290px] flex-col gap-2.5"
      >
        <Form.Field {form} name="teacherId">
          <Form.Control>
            {#snippet children({ props })}
              <Form.Label>Teacher ID</Form.Label>
              <Input {...props} bind:value={$formData.teacherId} placeholder="Enter teacher id" />
            {/snippet}
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="teacherId">
          <Form.Control>
            {#snippet children({ props })}
              <Form.Label>Teacher ID</Form.Label>
              <Input {...props} bind:value={$formData.teacherId} placeholder="Enter teacher id" />
            {/snippet}
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="fName">
          <Form.Control>
            {#snippet children({ props })}
              <Form.Label>First Name</Form.Label>
              <Input {...props} bind:value={$formData.fName} placeholder="Enter first name" />
            {/snippet}
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="mName">
          <Form.Control>
            {#snippet children({ props })}
              <Form.Label>Middle Name</Form.Label>
              <Input {...props} bind:value={$formData.mName} placeholder="Enter middle name" />
            {/snippet}
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="lName">
          <Form.Control>
            {#snippet children({ props })}
              <Form.Label>Last Name</Form.Label>
              <Input {...props} bind:value={$formData.lName} placeholder="Enter last name" />
            {/snippet}
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="phone">
          <Form.Control>
            {#snippet children({ props })}
              <Form.Label>Phone Number</Form.Label>
              <Input {...props} bind:value={$formData.phone} placeholder="Enter phone number" />
            {/snippet}
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

        <Form.Field {form} name="department">
          <Form.Control>
            {#snippet children({ props })}
              <Form.Label>Phone Number</Form.Label>
              <Input {...props} bind:value={$formData.department} placeholder="Enter department" />
            {/snippet}
          </Form.Control>
          <Form.FieldErrors />
        </Form.Field>

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

        <Form.Field {form} name="confirmPwd">
          <Form.Control>
            {#snippet children({ props })}
              <Form.Label>Confirm Password</Form.Label>
              <Input
                type="password"
                {...props}
                bind:value={$formData.confirmPwd}
                placeholder="Confirm password"
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
              <span>Creating</span>
              <LoaderCircle class="h-[20px] w-[20px] animate-spin" />
            </div>
          {/if}

          Create Account
        </Form.Button>
      </form>

      <p class=" leading-7 [&:not(:first-child)]:mt-6">Already have an account?</p>
      <a href="/" class=" underline transition-all hover:text-primary">Log in here</a>
    </div>
  </ScrollArea>
</div>
