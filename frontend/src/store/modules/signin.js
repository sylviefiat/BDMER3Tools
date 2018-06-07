import api from '@/api'
// import ls from '@/services/ls'
import router from '@/router'

const initialState = {
  urlError: null,
  authError: null,
  connected: false
}

export default {
  namespaced: true,
  state: {
    urlError: null,
    authError: null
  },
  mutations: {
    signinBdmer: (state) => {
      state.connected = true
      router.push({
        name: 'Home'
      })
    },
    signinODK: (state) => {
      router.push({
        name: 'SigninBdmer'
      })
    },
    signinErrors: (state, err) => {
      if (err.status === 400 || err.status === 500 || err.status === 404) {
        state.urlError = true
      }else{
        state.authError = true
      }
    },
    resetUrlError: (state) => {
      state.urlError = null
    },
    resetAuthError: (state) => {
      state.authError = null
    }
  },
  getters: {
    hasUrlError: (state) => {
      return state.urlError
    },
    hasAuthError: (state) => {
      return state.authError
    },
    isConnected: (state) => {
      return state.connected
    }
  },
  actions: {
    signinBdmer: ({
      commit
    }, user) => {
      api.post('/signinBdmer', user).then((response) => {
        commit('signinBdmer', response.data)
      }).catch((error) => {
        commit("signinErrors", error.response)
      })
    },
    signinODK: ({
      commit
    }, user) => {
      api.post('/signinODK', user).then((response) => {
        commit('signinODK', response.data)
      }).catch((error) => {
        commit("signinErrors", error.response)
      })
    },
    resetAuthError: ({
      commit
    }) => {
      commit("resetAuthError")
    },
    resetUrlError: ({
      commit
    }) => {
      commit("resetUrlError")
    }
  }
}
