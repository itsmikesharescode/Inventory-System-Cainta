<script lang="ts">
  import Button from '$lib/components/ui/button/button.svelte';
  import * as Popover from '$lib/components/ui/popover';
  import { fromSupabaseState } from '$lib/runes/supabaseState.svelte';
  import type { AdminLayout } from '$lib/types/admin/adminLayout.types';
  import type { PostgrestSingleResponse } from '@supabase/supabase-js';

  const supabase = fromSupabaseState();
  const sb = supabase.get();

  let selectedItems = $state([]);

  const streamItemsTable = async () => {
    if (!sb) return null;

    const { data, error } = (await sb.from('items_tb').select('*')) as PostgrestSingleResponse<
      AdminLayout['items'][number][]
    >;

    if (error) return null;
    return data;
  };
</script>

<div
  class="relative flex min-h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 aria-[invalid]:border-destructive [&>span]:line-clamp-1 data-[placeholder]:[&>span]:text-muted-foreground"
>
  <Popover.Root>
    <Popover.Trigger class=" absolute right-0 top-0">Add Item</Popover.Trigger>
    <Popover.Content>
      Lorem ipsum dolor sit amet consectetur adipisicing elit. Unde temporibus dolore sapiente
      excepturi provident eaque mollitia repellat eius reiciendis nihil. Praesentium repudiandae
      natus dolorum enim. Sit neque aliquam odit iusto unde corrupti assumenda, nam porro eaque
      provident aspernatur minima itaque autem? Quasi dicta accusamus officia quia facilis, optio
      accusantium architecto.
    </Popover.Content>
  </Popover.Root>
</div>
