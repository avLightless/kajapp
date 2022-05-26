<template>
  <div>
    <header class="fixed w-full bottom-0 z-40 flex flex-col">
      <div v-if="menuOpen" @click="toggleMenu(false)" class="static w-screen h-screen"></div>
      <Transition
          mode="out-in"
          enter-active-class="transform-gpu transition-all duration-200 ease-in-out"
          enter-from-class="translate-y-full"
          enter-to-class="translate-y-0"
          leave-active-class="transform-gpu transition-all duration-200 ease-in-out"
          leave-from-class=""
          leave-to-class="translate-y-full"
      >
        <div v-if="menuOpen" class="py-4 bg-white border-t z-30">
          <ul class="flex flex-col gap-y-4 ml-4">
            <li class="inline-flex items-center gap-x-2">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 border rounded-full p-1" fill="none"
                   viewBox="0 0 24 24"
                   stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round"
                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
              </svg>
              <p class="font-medium">Profile</p>
            </li>
            <li v-for="item in menuItems">
              <NuxtLink class="rounded-full font-medium" @click="toggleMenu()" :to="item.link">{{ item.text }}</NuxtLink>
            </li>
          </ul>
        </div>
      </Transition>
      <nav class="h-12 text-accent bg-white border-t z-40">
        <div v-if="!searchBarOpen" class="flex flex-row h-12 items-center gap-y-6 justify-around">
          <div @click="toggleMenu()" class="rounded-full">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24"
                 stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16M4 18h16"/>
            </svg>
          </div>
          <NuxtLink to="/" class="rounded-full" @click="toggleMenu(false)">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 rounded-full" fill="none" viewBox="0 0 24 24"
                 stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round"
                    d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
            </svg>
          </NuxtLink>
          <div @click="toggleSearchBar();toggleMenu(false)" class="rounded-full">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8"
                 fill="none"
                 viewBox="0 0 24 24"
                 stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
            </svg>
          </div>
        </div>
        <div v-if="searchBarOpen" class="flex flex-row h-12 items-center gap-y-6 justify-around z-50">
          <Transition mode="out-in" appear
                      enter-active-class="transform-gpu transition-all duration-200 ease-in-out"
                      enter-from-class="scale-x-0"
                      enter-to-class="scale-x-100"
                      leave-active-class="transform-gpu transition-all duration-200 ease-in-out"
                      leave-from-class="scale-x-100 opacity-100"
                      leave-to-class="scale-x-0 opacity-80"
                      @after-leave="toggleSearchBar();toggleSearchInput()"
          >
            <div v-if="searchInputOpen" class="basis-4/5 text-center">
              <input type="text" class="rounded-full border mx-4 px-2 w-4/5 text-black">
            </div>
          </Transition>
          <div class="basis-1/5">
            <svg @click="toggleSearchInput()" xmlns="http://www.w3.org/2000/svg"
                 class="h-8 w-8 rounded-full" fill="none"
                 viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </div>
        </div>
      </nav>
    </header>
  </div>
</template>

<script setup>
const searchBarOpen = ref(false)
const searchInputOpen = ref(true)
const menuOpen = ref(false)
const menuItems = ref([
  {text: "Dashboard", link: "/"},
  {text: "Login", link: "login"},
  {text: "Link 3", link: "test"}
])

function toggleSearchBar(desiredState) {
  if (!(typeof desiredState == "boolean")){
    desiredState = !searchBarOpen.value
  }
  searchBarOpen.value = desiredState
}

function toggleSearchInput(desiredState) {
  if (!(typeof desiredState == "boolean")){
    desiredState = !searchInputOpen.value
  }
  searchInputOpen.value = desiredState
}

function toggleMenu(desiredState) {
  if (!(typeof desiredState == "boolean")){
    desiredState = !menuOpen.value
  }
  menuOpen.value = desiredState
}
</script>