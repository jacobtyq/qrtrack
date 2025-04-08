// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },
  modules: ['@nuxtjs/supabase'],
  css: ['@/assets/main.css'],
  // NOTE: SSR set to false due to this issue authenticating
  // https://github.com/orgs/supabase/discussions/20443
  ssr: false,
})
