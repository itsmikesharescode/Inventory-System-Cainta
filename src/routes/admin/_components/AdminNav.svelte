<script lang="ts">
  import AdminProfile from './AdminProfile/AdminProfile.svelte';
  import * as Menubar from '$lib/components/ui/menubar';
  import { ChevronDown } from 'lucide-svelte';
  import type { SupabaseClient } from '@supabase/supabase-js';

  interface Props {
    supabase: SupabaseClient;
  }

  const { supabase }: Props = $props();

  const adminSiteMaps = [
    {
      name: 'Dashboard',
      url: '/admin',
      subRoutes: []
    },
    {
      name: 'Transactions',
      url: '',
      subRoutes: [
        {
          name: 'Reservations',
          url: '/admin/reservations'
        },
        {
          name: 'New',
          url: '/admin/reservations?new=true'
        },
        {
          name: 'Borrowed Items',
          url: '/admin/borrowed-items'
        },
        {
          name: 'Returned Items',
          url: '/admin/returned-items'
        }
      ]
    },
    {
      name: 'Items',
      url: '/admin/items',
      subRoutes: []
    },
    {
      name: 'Borrowers',
      url: '/admin/borrowers',
      subRoutes: []
    }
  ];
</script>

<nav
  class="sticky top-0 z-40 flex items-center justify-between border-b-[1px] p-1.5 px-2.5 backdrop-blur-lg"
>
  <div class="flex items-center gap-5">
    {#each adminSiteMaps as site}
      {#if site.subRoutes.length}
        <Menubar.Root>
          <Menubar.Menu>
            <Menubar.Trigger>{site.name} <ChevronDown class="h-[20px] w-[20px]" /></Menubar.Trigger>
            <Menubar.Content>
              {#each site.subRoutes as subRoute}
                <Menubar.Item href={subRoute.url}>
                  {subRoute.name}
                </Menubar.Item>

                <Menubar.Separator />
              {/each}
            </Menubar.Content>
          </Menubar.Menu>
        </Menubar.Root>
      {:else if site.url.length}
        <a href={site.url} class="text-sm font-medium">{site.name}</a>
      {/if}
    {/each}
  </div>
  <AdminProfile {supabase} />
</nav>
