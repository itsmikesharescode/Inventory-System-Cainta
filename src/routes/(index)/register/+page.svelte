<script lang="ts">
  import * as Form from '$lib/components/ui/form';
  import { Input } from '$lib/components/ui/input';
  import { registerSchema } from './schema';
  import { type SuperValidated, type Infer, superForm } from 'sveltekit-superforms';
  import { zodClient } from 'sveltekit-superforms/adapters';

  const { data } = $props();

  const form = superForm(data.registerForm, {
    validators: zodClient(registerSchema)
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

  <div class="flex flex-col items-center gap-2.5 overflow-auto md:h-screen md:border-l-2 md:py-20">
    <h1 class="scroll-m-20 text-2xl font-semibold tracking-tight">Register</h1>

    <form method="POST" use:enhance class="flex flex-col gap-2.5">
      <Form.Field {form} name="teacherId">
        <Form.Control let:attrs>
          <Form.Label>Teacher ID</Form.Label>
          <Input {...attrs} bind:value={$formData.teacherId} placeholder="Enter your teacher id" />
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Field {form} name="fName">
        <Form.Control let:attrs>
          <Form.Label>First Name</Form.Label>
          <Input {...attrs} bind:value={$formData.fName} placeholder="Enter your first name" />
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Field {form} name="mName">
        <Form.Control let:attrs>
          <Form.Label>Middle Name</Form.Label>
          <Input {...attrs} bind:value={$formData.mName} placeholder="Enter your middle name" />
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Field {form} name="lName">
        <Form.Control let:attrs>
          <Form.Label>Last Name</Form.Label>
          <Input {...attrs} bind:value={$formData.lName} placeholder="Enter your last name" />
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Field {form} name="phone">
        <Form.Control let:attrs>
          <Form.Label>Phone Number</Form.Label>
          <Input {...attrs} bind:value={$formData.phone} placeholder="Enter your phone number" />
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Field {form} name="department">
        <Form.Control let:attrs>
          <Form.Label>Department</Form.Label>
          <Input {...attrs} bind:value={$formData.department} placeholder="Enter your department" />
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Field {form} name="email">
        <Form.Control let:attrs>
          <Form.Label>Email</Form.Label>
          <Input {...attrs} bind:value={$formData.email} placeholder="Enter your email" />
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Field {form} name="pwd">
        <Form.Control let:attrs>
          <Form.Label>Password</Form.Label>
          <Input
            type="password"
            {...attrs}
            bind:value={$formData.pwd}
            placeholder="Enter your password"
          />
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>

      <Form.Field {form} name="confirmPwd">
        <Form.Control let:attrs>
          <Form.Label>Password</Form.Label>
          <Input
            type="password"
            {...attrs}
            bind:value={$formData.confirmPwd}
            placeholder="Confirm your password"
          />
        </Form.Control>
        <Form.FieldErrors />
      </Form.Field>
      <Form.Button>Create Account</Form.Button>
    </form>

    <p class="leading-7 [&:not(:first-child)]:mt-6">Already have an account?</p>
    <a href="/" class="underline transition-all hover:text-primary">Log in here</a>
  </div>
</div>
