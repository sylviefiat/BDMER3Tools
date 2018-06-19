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
    success: []
  },
  mutations: {
    importSuccess: (state, data) => {
      state.loading = false;
      state.errors = data.errors;
      state.warnings = data.warnings;
      state.success = data.success;
    },
    startLoader: state => {
      state.loading = true;
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
    }
  },
  actions: {
    import: ({ commit }, user) => {
      commit("startLoader");
      sync
        .seacuseyToBdmer(user)
        .then(res => {
          commit("importSuccess", res);
        })
        .catch(err => {
          console.log(err);
        });
    }
  }
};
