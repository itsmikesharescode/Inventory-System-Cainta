<script lang="ts">
  import AdminProfile from './TeacherProfile/TeacherProfile.svelte';
  import * as Menubar from '$lib/components/ui/menubar';
  import { ChevronDown } from 'lucide-svelte';
  import type { SupabaseClient } from '@supabase/supabase-js';

  interface Props {
    supabase: SupabaseClient;
  }

  const { supabase }: Props = $props();

  const adminSiteMaps = [
    {
      name: 'Reservations',
      url: '/teacher'
    },
    {
      name: 'Account',
      url: '/teacher/account'
    }
  ];
</script>

<nav
  class="sticky top-0 z-40 flex items-center justify-between border-b-[1px] p-1.5 px-2.5 backdrop-blur-lg"
>
  <div class="flex items-center gap-5">
    {#each adminSiteMaps as site}
      <a href={site.url} class="text-sm font-medium">{site.name}</a>
    {/each}
  </div>
  <AdminProfile {supabase} />
</nav>
