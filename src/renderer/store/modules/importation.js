import * as sync from "@/synchronisation";

const initialState = {
	loading: false,
	errors: [],
	warnings: [],
	success: []
};

export default {
	namespaced: true,
	state: {
		loading: false,
		errors: [],
		warnings: [],
		success: [],
		errorBdmer: false,
		errorOdk: false,
		errorBdmerSpecies: false,
		errorBdmerPlatforms: false
	},
	mutations: {
		importSuccess: (state, data) => {
			state.loading = false;
			state.errors = data.errors;
			state.warnings = data.warnings;
			state.success = data.success;
		},
		importErr: (state, err) => {
			if (err.err.type === "table") {
				if (err.err.table === "species") state.errorBdmerSpecies = true;
				if (err.err.table === "platforms") state.errorBdmerPlatforms = true;
			} else {
				state.errorBdmer = err.type === "bdmer" ? true : false;
				state.errorOdk = err.type === "odk" ? true : false;
			}

			state.loading = false;
		},
		startImport: state => {
			state.loading = true;
			state.errorBdmer = false;
			state.errorBdmerSpecies = false;
			state.errorBdmerPlatforms = false;
			state.errorOdk = false;
		}
	},
	getters: {
		isLoading: state => {
			return state.loading;
		},
		hasErrors: state => {
			return state.errors;
		},
		hasWarnings: state => {
			return state.warnings;
		},
		hasSuccess: state => {
			return state.success;
		},
		hasErrorOdk: state => {
			return state.errorOdk;
		},
		hasErrorBdmer: state => {
			return state.errorBdmer;
		},
		hasErrorBdmerSpecies: state => {
			return state.errorBdmerSpecies;
		},
		hasErrorBdmerPlatforms: state => {
			return state.errorBdmerPlatforms;
		}
	},
	actions: {
		import: ({ commit }, user) => {
			commit("startImport");
			sync
				.seacuseyToBdmer(user)
				.then(res => {
					commit("importSuccess", res);
				})
				.catch(err => {
					commit("importErr", err);
				});
		}
	}
};
