<template>
  <v-app :dark="themeDarkVariant">
  <v-content>
    <router-view/>
  </v-content>
</v-app>
</template>

<script>
export default {
  data: () => ({
    drawer: false,
    themeDarkVariant: true
  }),
  props: {
  }
}
</script>

<style>
.toggle-theme{
  margin-top: 20px;
}
</style>
