import Vue from "vue";
import axios from "axios";
import Vuetify from "vuetify";
import VueI18n from "vue-i18n";
import Vuelidate from "vuelidate";

import "vuetify/dist/vuetify.min.css";
import App from "./App";
import router from "./router";
import store from "./store";

import { remote } from "electron";

remote.globalShortcut.register("control+shift+k", () => {
	remote.BrowserWindow.getFocusedWindow().webContents.openDevTools();
});

window.addEventListener("beforeunload", () => {
	remote.globalShortcut.unregisterAll();
});

if (!process.env.IS_WEB) Vue.use(require("vue-electron"));
Vue.http = Vue.prototype.$http = axios;
Vue.config.productionTip = false;

Vue.use(Vuetify);
Vue.use(Vuelidate);
Vue.use(VueI18n);

const locale = "en";

const messages = {
	fr: require("./language/fr.json"),
	en: require("./language/en.json")
};

const i18n = new VueI18n({
	locale,
	messages
});

Vue.prototype.$locale = {
	change(language) {
		i18n.locale = language;
	},
	current() {
		return i18n.locale;
	}
};

/* eslint-disable no-new */
new Vue({
	el: "#app",
	router,
	store,
	i18n,
	components: { App },
	template: "<App/>"
});
