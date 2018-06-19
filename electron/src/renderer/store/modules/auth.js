import axios from "axios";
import router from "@/router";
import store from "@/store";
import Cookies from "js-cookie";
import CryptoJS from "crypto-js";
import config from "@/config";
import * as auth from "@/authentification";

const initialState = {
	userBdmer: Cookies.get("userBdmer") !== undefined ? toString(CryptoJS.AES.decrypt(Cookies.get("userBdmer"), config.cryptoKey)) : null,
	userODK: Cookies.get("userODK") !== undefined ? toString(CryptoJS.AES.decrypt(Cookies.get("userODK"), config.cryptoKey)) : null,
	dbConfiguration: Cookies.get("dbConfiguration") !== undefined ? toString(CryptoJS.AES.decrypt(Cookies.get("dbConfiguration"), config.cryptoKey)) : null
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
			Cookies.set("userBdmer", CryptoJS.AES.encrypt(JSON.stringify(user), config.cryptoKey));
			router.push({
				name: "Home"
			});
		},
		signinErrorsODK: state => {
			state.urlError = true;
		},
		signinODK: (state, user) => {
			state.userODK = user;
			Cookies.set("userODK", CryptoJS.AES.encrypt(JSON.stringify(user), config.cryptoKey));
			router.push({
				name: "Home"
			});
		},
		signinErrors: (state, err) => {
			if (err.status === 400 || err.status === 500 || err.status === 404) {
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
			Cookies.set("dbConfiguration", CryptoJS.AES.encrypt(JSON.stringify(dbConfiguration), config.cryptoKey));
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
					commit("signinErrorsODK", err);
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
