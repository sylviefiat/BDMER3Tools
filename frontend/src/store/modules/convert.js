import api from '@/api'
// import ls from '@/services/ls'

const initialState = {

}

export default {
  namespaced: true,
  state: {},
  mutations: {},
  getters: {},
  actions: {
    convert: ({
      commit
    }) => {
      api.post('/convert').then((response) => {
        console.log(response)
      }).catch((error) => {
        console.log(error.response)
      })
    }
  }
}
