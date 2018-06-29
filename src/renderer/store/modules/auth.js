import router from "@/router";
import store from "@/store";
import Cookies from "js-cookie";
import ls from "@/services/ls.js";
import * as auth from "@/authentification";
import config from "@/config";

const initialState = {
	userBdmer: ls.get("userBdmer"),
	userODK: ls.get("userODK"),
	dbConfiguration: ls.get("dbConfiguration")
};

export default {
	namespaced: true,
	state: {
		urlError: null,
		authError: null,
		userBdmer: {},
		userODK: {},
		dbConfiguration: {
			db: config.dbName,
			schema: config.schema
		}
	},
	mutations: {
		signinBdmer: (state, user) => {
			state.connected = true;
			state.userBdmer = user;
			ls.set("userBdmer", user);
			router.push({
				name: "Home"
			});
		},
		signinErrorsODK: state => {
			state.urlError = true;
		},
		signinODK: (state, user) => {
			state.userODK = user;
			ls.set("userODK", user);
			router.push({
				name: "Home"
			});
		},
		signinErrors: (state, data) => {
			if (data.status === 400 || data.status === 500 || data.status === 404 || !data.status) {
				state.urlError = true;
			} else {
				state.authError = true;
			}
		},
		resetUrlError: state => {
			state.urlError = null;
		},
		resetAuthError: state => {
			state.authError = null;
		},
		saveDbConfiguration: (state, dbConfiguration) => {
			state.dbConfiguration = dbConfiguration;
			ls.set("dbConfiguration", dbConfiguration);
			router.push({
				name: "Home"
			});
		}
	},
	getters: {
		hasUrlError: state => {
			return state.urlError;
		},
		hasAuthError: state => {
			return state.authError;
		},
		isConnected: state => {
			return state.connected;
		},
		getUserBdmer: state => {
			return state.userBdmer;
		},
		getUserODK: state => {
			return state.userODK;
		},
		getDbConfiguration: state => {
			return state.dbConfiguration;
		}
	},
	actions: {
		signinBdmer: ({ commit }, user) => {
			auth
				.signinBdmer(user)
				.then(res => {
					commit("signinBdmer", user);
				})
				.catch(err => {
					commit("signinErrors", err);
				});
		},
		signinODK: ({ commit }, user) => {
			auth
				.signinODK(user)
				.then(res => {
					commit("signinODK", user);
				})
				.catch(err => {
					commit("signinErrors", err);
				});
		},
		resetAuthError: ({ commit }) => {
			commit("resetAuthError");
		},
		resetUrlError: ({ commit }) => {
			commit("resetUrlError");
		},
		saveDbConfiguration: ({ commit }, dbConfiguration) => {
			commit("saveDbConfiguration", dbConfiguration);
		}
	}
};
