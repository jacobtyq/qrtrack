<script setup>
import { ref } from 'vue'
import QrcodeVue, { QrcodeCanvas, QrcodeSvg } from 'qrcode.vue'

const supabase = useSupabaseClient()
const loading = ref(false)
const text = ref('https://www.qrcode.com')

const saveQRCode = async () => {
  // Set loading to true
  loading.value = true

  const userID = (await supabase.auth.getUser()).data.user.id
  const { data, error } = await supabase.from('user_qr_codes').insert({
    data: text.value,
    user_id: userID,
  })

  if (error) {
    console.error('Error saving QR code:', error)
  } else {
    console.log('QR code saved:', data)
  }
  loading.value = false
}
</script>

<template>
  <h2>QR Code</h2>
  <qrcode-vue :value="text" :size="200" level="H" />
  <input v-model="text" placeholder="Enter text or URL" />
  <button @click="saveQRCode">
    {{ loading ? 'Saving...' : 'Generate & Save QR' }}
  </button>
</template>
