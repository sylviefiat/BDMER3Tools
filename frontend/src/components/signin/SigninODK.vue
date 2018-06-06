<template>
  <v-container grid-list-md text-xs-center>
    <v-layout row wrap>
      <v-flex xs10 offset-xs1>
        <v-form ref="form" v-model="valid" lazy-validation>

          <v-text-field v-model="user.mail"
          label="E-mail"
          :error-messages="errors.passwordErrors"
          required></v-text-field>

          <v-text-field single-line
          :append-icon="e1 ? 'visibility' : 'visibility_off'"
          :append-icon-cb="() => (e1 = !e1)"
          :type="e1 ? 'password' : 'text'"
          v-model="user.password"
          label="Mot de passe"
          :error-messages="errors.passwordErrors"
          required></v-text-field>

          <v-btn :disabled="!valid" @click="submit">S'inscrire</v-btn>
          <v-btn @click="clear">clear</v-btn>

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
    e2: true,
    user:{
      mail: "",
      password: "",
    },
    valid: true,
    errors:{
      mailErrors: "",
      passwordError: ""
    }
  }),

  methods: {
    submit () {
      if (this.$refs.form.validate()) {
        this.$store.dispatch('account/signup', this.newUser)
      }
    },
    clear () {
      this.$refs.form.reset();
    }
  }
}
</script>
