<script lang="ts">
  interface Props {
    title: string;
    count: number;
  }

  const { title, count }: Props = $props();
</script>

<div class="flex flex-col rounded-lg border-2 border-black p-10">
  <h4 class="scroll-m-20 text-xl font-semibold tracking-tight">{title}</h4>
  <span class="w-full text-center text-7xl text-muted-foreground">{count.toLocaleString()}</span>
</div>
