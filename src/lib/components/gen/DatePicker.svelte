<script lang="ts">
  import CalendarIcon from 'lucide-svelte/icons/calendar';
  import { DateFormatter, type DateValue, getLocalTimeZone } from '@internationalized/date';
  import { cn } from '$lib/utils.js';
  import { buttonVariants } from '$lib/components/ui/button/index.js';
  import { Calendar } from '$lib/components/ui/calendar/index.js';
  import * as Popover from '$lib/components/ui/popover/index.js';
  import type { ClassNameValue } from 'tailwind-merge';

  interface Props {
    dateString: string;
    formProps: {
      name: string;
      id: string;
      'data-fs-error': string | undefined;
      'aria-describedby': string | undefined;
      'aria-invalid': 'true' | undefined;
      'aria-required': 'true' | undefined;
      'data-fs-control': string;
    } | null;
    class: ClassNameValue;
  }

  let { dateString = $bindable(), ...props }: Props = $props();

  let value = $state<DateValue>();

  const df = new DateFormatter('en-US', {
    dateStyle: 'long'
  });

  let contentRef = $state<HTMLElement | null>(null);

  $effect(() => {
    if (value) {
      dateString = String(value);
    }
  });
</script>

<Popover.Root>
  <Popover.Trigger
    {...props.formProps}
    class={cn(
      buttonVariants({
        variant: 'outline',
        class: `${props.class} justify-start text-left font-normal`
      }),
      !dateString && 'text-muted-foreground'
    )}
  >
    <CalendarIcon class="mr-2 size-4" />
    {dateString ? dateString : 'Pick a date'}
  </Popover.Trigger>
  <Popover.Content bind:ref={contentRef} class="w-auto p-0">
    <Calendar type="single" bind:value />
  </Popover.Content>
</Popover.Root>
