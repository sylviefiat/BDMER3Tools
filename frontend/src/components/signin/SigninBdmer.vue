<template>
  <v-container fluid fill-height>
    <v-layout align-center justify-center>
      <v-flex md4 sm6 xs10>
        <div class="headline">
          {{ $t("CONNECT_TO") }} <span class="blue--text">BDMER³</span>.
          <img class="lang" src="../../assets/en.png">
        </div>

        <v-form ref="form" v-model="valid" lazy-validation>
          <v-text-field
         prepend-icon="link"
         v-model="user.url"
         label="Url "
         :error-messages="errors"
         required></v-text-field>

          <v-text-field v-model="user.username"
         :label="$t('USERNAME')"
         prepend-icon="person"
         :error-messages="errors"
         required></v-text-field>

          <v-text-field single-line
          prepend-icon="lock"
          :append-icon="e1 ? 'visibility' : 'visibility_off'"
          :append-icon-cb="() => (e1 = !e1)"
          :type="e1 ? 'password' : 'text'"
          v-model="user.password"
          :label="$t('PASSWORD')"
          :error-messages="errors"
          required></v-text-field>

          <v-btn block :disabled="!isCompleted" class="primary" @click="submit">{{$t('SIGNIN')}}</v-btn>
        </v-form>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import store from '@/store'

export default {
 data: () => ({
   e1: true,
   user:{
     url: "",
     username: "",
     password: ""
   },
   usernames: [],
   mails: [],
   valid: true,
   errors: []
 }),
 computed: {
  isCompleted () {
    return this.user.username && this.user.password && this.user.url;
  }
},
created: ()=>{
  console.log(this)
},
 methods: {
   submit () {
     this.$store.dispatch('account/signup', this.newUser)
   }
 }
}
</script>

<style scoped>
.headline{
 margin-bottom: 20px;
}
.lang{
  float: right;
  height: auto;
  width: 50px;
}
</style>
