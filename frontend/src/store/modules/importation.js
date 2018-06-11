import api from "@/api";

const initialState = {};

export default {
  namespaced: true,
  state: {},
  mutations: {},
  getters: {},
  actions: {
    import: ({ commit }, user) => {
      api
        .post("/import", user)
        .then(response => {
          console.log(response);
        })
        .catch(error => {
          console.log(error.response);
        });
    }
  }
};
