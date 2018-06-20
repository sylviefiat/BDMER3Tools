import axios from "axios";
import router from "@/router";
import store from "@/store";
import Cookies from "js-cookie";
import CryptoJS from "crypto-js";
import config from "@/config";
import * as auth from "@/authentification";

const initialState = {
	userBdmer: Cookies.get("userBdmer") !== undefined ? JSON.parse(CryptoJS.AES.decrypt(Cookies.get("userBdmer").toString(), config.cryptoKey).toString(CryptoJS.enc.Utf8), config.cryptoKey) : null,
	userODK: Cookies.get("userODK") !== undefined ? JSON.parse(CryptoJS.AES.decrypt(Cookies.get("userODK").toString(), config.cryptoKey).toString(CryptoJS.enc.Utf8), config.cryptoKey) : null,
	dbConfiguration:
		Cookies.get("dbConfiguration") !== undefined ? JSON.parse(CryptoJS.AES.decrypt(Cookies.get("dbConfiguration").toString(), config.cryptoKey).toString(CryptoJS.enc.Utf8), config.cryptoKey) : null
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
		signinErrors: (state, data) => {
			if (data.err.status === 400 || data.err.status === 500 || data.err.status === 404) {
				state.urlError = true;
				data.type === "ODK" ? (state.userODK = {}) : (state.userBdmer = {});
			} else {
				state.authError = true;
				data.type === "ODK" ? ((state.userODK.username = ""), (state.userODK.password = "")) : ((state.userBdmer.username = ""), (state.userBdmer.password = ""));
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
					commit("signinErrors", { err: err, type: "Bdmer" });
				});
		},
		signinODK: ({ commit }, user) => {
			auth
				.signinODK(user)
				.then(res => {
					commit("signinODK", user);
				})
				.catch(err => {
					commit("signinErrorsODK", { err: err, type: "ODK" });
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
