<script lang="ts">
  import type { Snippet } from 'svelte';
  import AdminProfile from './AdminProfile/AdminProfile.svelte';

  interface Props {
    children: Snippet;
  }

  const { children }: Props = $props();

  const adminSiteMaps = [
    {
      name: 'Dashboard',
      url: '/admin',
      subRoutes: false
    },
    {
      name: 'Transactions',
      url: false,
      subRoutes: [
        {
          name: 'Reservations',
          url: '/admin/reservations'
        },
        {
          name: 'New',
          url: '/admin/new'
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
      name: 'Item',
      url: '/admin/item',
      subRoutes: false
    },
    {
      name: 'Borrower',
      url: '/admin/borrower',
      subRoutes: false
    }
  ];
</script>

<nav class="flex items-center justify-end p-1.5">
  <AdminProfile />
</nav>
