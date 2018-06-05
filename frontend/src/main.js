import Vue from 'vue'
import App from './App.vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.css'
import VueRouter from 'vue-router'

Vue.use(VueRouter)
Vue.use(Vuetify)

new Vue({
  el: '#app',
  render: h => h(App)
})
