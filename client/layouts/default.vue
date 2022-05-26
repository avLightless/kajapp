<script setup>
import LayoutNavbar from "../components/layout/LayoutNavbar";
import LayoutFooter from "../components/layout/LayoutFooter";
</script>

<template>
  <div>
    <div class="flex flex-col w-full h-screen bg-background overflow-y-auto" style="height: 100vh;  max-height: -webkit-fill-available;">
      <div class="grow">
        <main>
          <slot/>
        </main>
      </div>
      <LayoutFooter class="mb-12"/>
    </div>
    <LayoutNavbar/>
  </div>
</template>