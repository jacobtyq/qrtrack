<script setup>
const user = useSupabaseUser()
</script>

<template>
  <div class="container" style="padding: 50px 0 100px 0">
    <h1 v-if="user">Dashboard</h1>
    <Auth v-else />
  </div>
</template>

<style scoped>
h1 {
  color: white;
}
</style>
