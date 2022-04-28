import {defineNuxtConfig} from 'nuxt'

// https://v3.nuxtjs.org/api/configuration/nuxt.config
export default defineNuxtConfig({
    ssr: false, // static SPA
    modules: ['@nuxtjs/tailwindcss'], // extensions,
    telemetry: false, // disable telemetry
})
