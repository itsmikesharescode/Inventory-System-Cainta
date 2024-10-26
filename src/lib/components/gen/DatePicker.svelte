<script lang="ts">
  import { Calendar as CalendarPrimitive } from 'bits-ui';
  import { DateFormatter, getLocalTimeZone, today } from '@internationalized/date';
  import * as Calendar from '$lib/components/ui/calendar/index.js';
  import * as Select from '$lib/components/ui/select/index.js';
  import { cn } from '$lib/utils.js';
  import * as Popover from '$lib/components/ui/popover';
  import { ScrollArea } from '$lib/components/ui/scroll-area/index.js';

  interface Props {
    name: string;
    dateValue: string;
  }

  let { dateValue = $bindable(), ...props }: Props = $props();

  type $$Props = CalendarPrimitive.Props;
  type $$Events = CalendarPrimitive.Events;

  let value: $$Props['value'] = $state();
  let placeholder: $$Props['placeholder'] = $state(today(getLocalTimeZone()));
  let weekdayFormat: $$Props['weekdayFormat'] = $state('short');

  const monthOptions = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ].map((month, i) => ({ value: i + 1, label: month }));

  const monthFmt = new DateFormatter('en-US', {
    month: 'long'
  });

  const yearOptions = Array.from({ length: 100 }, (_, i) => ({
    label: String(new Date().getFullYear() - i),
    value: new Date().getFullYear() - i
  }));

  const defaultYear = $derived(
    placeholder ? { value: placeholder.year, label: String(placeholder.year) } : undefined
  );

  const defaultMonth = $derived(
    placeholder
      ? { value: placeholder.month, label: monthFmt.format(placeholder.toDate(getLocalTimeZone())) }
      : undefined
  );

  $effect(() => {
    if (value) {
      dateValue = String(value);
    }
  });
</script>

<Popover.Root>
  <Popover.Trigger
    class="flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 aria-[invalid]:border-destructive [&>span]:line-clamp-1 data-[placeholder]:[&>span]:text-muted-foreground"
  >
    <span class={value || dateValue ? 'text-black' : 'text-gray-500'}
      >{dateValue ? dateValue : props.name}</span
    >
  </Popover.Trigger>
  <Popover.Content class="">
    <CalendarPrimitive.Root
      class="w-full "
      {weekdayFormat}
      on:keydown
      let:months
      let:weekdays
      bind:value
      bind:placeholder
    >
      <Calendar.Header>
        <Calendar.Heading class="flex w-full items-center justify-between gap-2">
          <Select.Root
            selected={defaultMonth}
            items={monthOptions}
            onSelectedChange={(v) => {
              if (!v || !placeholder) return;
              if (v.value === placeholder?.month) return;
              placeholder = placeholder.set({ month: v.value });
            }}
          >
            <Select.Trigger aria-label="Select month" class="w-[60%]">
              <Select.Value placeholder="Select month" />
            </Select.Trigger>
            <Select.Content class="">
              <ScrollArea class="h-[200px]">
                {#each monthOptions as { value, label }}
                  <Select.Item {value} {label}>
                    {label}
                  </Select.Item>
                {/each}
              </ScrollArea>
            </Select.Content>
          </Select.Root>
          <Select.Root
            selected={defaultYear}
            items={yearOptions}
            onSelectedChange={(v) => {
              if (!v || !placeholder) return;
              if (v.value === placeholder?.year) return;
              placeholder = placeholder.set({ year: v.value });
            }}
          >
            <Select.Trigger aria-label="Select year" class="w-[40%]">
              <Select.Value placeholder="Select year" />
            </Select.Trigger>
            <Select.Content class="">
              <ScrollArea class="h-[200px]">
                {#each yearOptions as { value, label }}
                  <Select.Item {value} {label}>
                    {label}
                  </Select.Item>
                {/each}
              </ScrollArea>
            </Select.Content>
          </Select.Root>
        </Calendar.Heading>
      </Calendar.Header>
      <Calendar.Months>
        {#each months as month}
          <Calendar.Grid>
            <Calendar.GridHead>
              <Calendar.GridRow class="flex">
                {#each weekdays as weekday}
                  <Calendar.HeadCell>
                    {weekday.slice(0, 2)}
                  </Calendar.HeadCell>
                {/each}
              </Calendar.GridRow>
            </Calendar.GridHead>
            <Calendar.GridBody>
              {#each month.weeks as weekDates}
                <Calendar.GridRow class="mt-2 w-full">
                  {#each weekDates as date}
                    <Calendar.Cell {date}>
                      <Calendar.Day {date} month={month.value} />
                    </Calendar.Cell>
                  {/each}
                </Calendar.GridRow>
              {/each}
            </Calendar.GridBody>
          </Calendar.Grid>
        {/each}
      </Calendar.Months>
    </CalendarPrimitive.Root>
  </Popover.Content>
</Popover.Root>
