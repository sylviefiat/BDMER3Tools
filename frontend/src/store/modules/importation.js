import api from "@/api";

const initialState = {
  loading: false,
  errors: []
};

export default {
  namespaced: true,
  state: {
    loading: false,
    errors: []
  },
  mutations: {
    importSuccess: (state, data) => {
      state.loading = false;
      state.errors = data;
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
    }
  },
  actions: {
    import: ({ commit }, user) => {
      commit("startLoader");
      api
        .post("/import", user)
        .then(response => {
          commit("importSuccess", response.data);
        })
        .catch(error => {
          console.log(error.response);
        });
    }
  }
};
