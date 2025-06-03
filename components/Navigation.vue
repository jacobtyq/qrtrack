<script setup lang="ts">
import {
  NavigationMenu,
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  NavigationMenuTrigger,
  navigationMenuTriggerStyle,
} from '@/components/ui/navigation-menu'
const loading = ref(false)
const isAuthenticated = ref(false)

const supabase = useSupabaseClient()
const user = useSupabaseUser()

async function signOut() {
  try {
    loading.value = true
    const { error } = await supabase.auth.signOut()
    navigateTo('/auth/login')
    if (error) throw error
  } catch (error) {
    alert(error.message)
  } finally {
    loading.value = false
  }
}

watchEffect(() => {
  if (user.value) {
    isAuthenticated.value = true
  } else {
    isAuthenticated.value = false
  }
})
</script>

<template>
  <div v-if="isAuthenticated" class="p-2 w-full flex justify-between">
    <NavigationMenu>
      <NavigationMenuList>
        <NavigationMenuItem>
          <NuxtLink to="/dashboard">
            <NavigationMenuLink
              :active="isActive"
              :href
              :class="navigationMenuTriggerStyle()"
              @click="navigate"
            >
              Dashboard
            </NavigationMenuLink>
          </NuxtLink>
        </NavigationMenuItem>
        <NavigationMenuItem>
          <NuxtLink v-slot="{ isActive, href, navigate }" to="/profile" custom>
            <NavigationMenuLink
              :active="isActive"
              :href
              :class="navigationMenuTriggerStyle()"
              @click="navigate"
              >Profile</NavigationMenuLink
            >
          </NuxtLink>
        </NavigationMenuItem>
      </NavigationMenuList>
    </NavigationMenu>

    <button class="button block" @click="signOut" :disabled="loading">
      Sign Out
    </button>
  </div>
  <div v-if="!isAuthenticated" class="p-2 w-full flex justify-between">
    <NavigationMenu>
      <NavigationMenuList>
        <NavigationMenuItem>
          <NuxtLink to="/auth/login">
            <NavigationMenuLink
              :active="isActive"
              :href
              :class="navigationMenuTriggerStyle()"
              @click="navigate"
            >
              Login
            </NavigationMenuLink>
          </NuxtLink>
        </NavigationMenuItem>
      </NavigationMenuList>
    </NavigationMenu>
  </div>
</template>
