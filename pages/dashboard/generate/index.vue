<script setup>
const user = useSupabaseUser()
</script>

<template>
  <div class="container" style="padding: 50px 0 100px 0">
    <GenerateQR v-if="user" />
    <Auth v-else />
  </div>
</template>
