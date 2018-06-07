import Vue from 'vue'
import Router from 'vue-router'
import store from '@/store'
import Home from '@/components/Home'
import SigninBdmer from '@/components/signin/SigninBdmer'
import SigninODK from '@/components/signin/SigninODK'

Vue.use(Router)

const router =  new Router({
  routes: [
    {
      path: '/signinBdmer',
      name: 'SigninBdmer',
      component: SigninBdmer
    },
    {
      path: '/signinODK',
      name: 'SigninODK',
      component: SigninODK
    },
    {
      path: '/',
      name: 'Home',
      component: Home
    }
  ]
})

router.beforeEach((to, from, next) => {
  if (to.name != 'SigninODK' && to.name != 'SigninBdmer' && !store.getters['signin/isConnected']) {
    console.log(to.name)
    next({
      name: 'SigninODK'
    })
  } else {
    next()
  }
})

export default router
