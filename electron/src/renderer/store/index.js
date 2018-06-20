import Vue from "vue";
import Vuex from "vuex";
import router from "@/router";
import auth from "@/store/modules/auth";
import importation from "@/store/modules/importation";
import createPersistedState from "vuex-persistedstate";
Vue.use(Vuex);

export default new Vuex.Store({
	plugins: [createPersistedState()],
	modules: {
		auth,
		importation
	},
	state: {},
	mutations: {},
	getters: {},
	actions: {}
});
