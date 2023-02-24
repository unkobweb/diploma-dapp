export default defineNuxtConfig({
  css: ['vuetify/lib/styles/main.sass'],
  build: {
    transpile: ['vuetify'],
  },
  vite: {
    define: {
      'process.env.DEBUG': false,
    },
  },
  modules: [
    '@pinia/nuxt',
  ],
  pinia: {
    autoImports: [
      // automatically imports `defineStore`
      'defineStore', // import { defineStore } from 'pinia'
      ['defineStore', 'definePiniaStore'], // import { defineStore as definePiniaStore } from 'pinia'
    ],
  },
  runtimeConfig: {
    public: {
      TOKEN_CONTRACT_ADDRESS: '0xF89B312953cF60B9143439Bbf55D6ABE4f4d45b6',
      DIPLOMA_CONTRACT_ADDRESS: '0x8946Ff8EE1968Fc795Dca34C5EC519F31De7c8a5',
    }
  }
})