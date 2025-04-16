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

const supabase = useSupabaseClient()

const loading = ref(true)

async function signOut() {
  try {
    loading.value = true
    const { error } = await supabase.auth.signOut()
    if (error) throw error
  } catch (error) {
    alert(error.message)
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="p-2 w-full flex justify-between">
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
</template>
