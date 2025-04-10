<script setup lang="ts">
const user = useSupabaseUser()
const redirectInfo = useSupabaseCookieRedirect()

watch(
  user,
  () => {
    if (user.value) {
      // Get redirect path and clear from cookie
      const path = redirectInfo.pluck()
      // Redirect to saved path or faillback to home
      return navigateTo(path || '/')
    }
  },
  { immediate: true }
)
</script>

<template>
  <p>Waiting for login...</p>
</template>
