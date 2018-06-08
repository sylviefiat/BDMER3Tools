import Vue from "vue";
import Router from "vue-router";
import store from "@/store";
import Home from "@/components/Home";
import SigninBdmer from "@/components/signin/SigninBdmer";
import SigninODK from "@/components/signin/SigninODK";
import DbConfiguration from "@/components/signin/DbConfiguration";

Vue.use(Router);

const router = new Router({
  routes: [
    {
      path: "/signinBdmer",
      name: "SigninBdmer",
      component: SigninBdmer
    },
    {
      path: "/signinODK",
      name: "SigninODK",
      component: SigninODK
    },
    {
      path: "/dbConfiguration",
      name: "DbConfiguration",
      component: DbConfiguration
    },
    {
      path: "/",
      name: "Home",
      component: Home
    }
  ]
});

router.beforeEach((to, from, next) => {
  if (
    to.name != "SigninODK" &&
    to.name != "SigninBdmer" &&
    to.name != "DbConfiguration" &&
    to.name != "Home"
  ) {
    next({
      name: "Home"
    });
  } else {
    next();
  }
});

export default router;
