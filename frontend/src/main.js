// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import Vuetify from 'vuetify'
import VueI18n from 'vue-i18n'
import Vuelidate from 'vuelidate'
import 'babel-polyfill'
import 'vuetify/dist/vuetify.min.css'

Vue.config.productionTip = false

Vue.use(Vuetify)
Vue.use(Vuelidate)
Vue.use(VueI18n)

const locale = 'en'

const messages = {
    fr: require("./language/fr.json"),
    en: require("./language/en.json"),
}

const i18n = new VueI18n({
    locale,
    messages
})

Vue.prototype.$locale = {
	change (language) {
		i18n.locale = language;
	},
	current () {
		return i18n.locale;
	}
};

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  i18n,
  components: { App },
  template: '<App/>'
})
