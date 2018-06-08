<template>
  <v-container fluid fill-height>
    <v-layout justify-center>
      <v-flex md4 sm6 xs10>
        <div class="display-2">
            {{ $t("CONNECT_TO") }} <span class="deep-orange--text">ODK</span>.
        </div>
        <v-divider></v-divider>
        <v-form class="form" ref="form" v-model="valid" lazy-validation>
          <v-text-field
         prepend-icon="link"
         v-model="user.url"
         label="Url ( ex: 193.55.100.40:5555 ) "
         :error-messages="hasUrlError"
         @input="$v.user.url.$touch()"
         @blur="$v.user.url.$touch()"
         required></v-text-field>

          <v-text-field v-model="user.username"
         :label="$t('USERNAME')"
         prepend-icon="person"
         :error-messages="hasUsernameError"
         @input="$v.user.username.$touch()"
         @blur="$v.user.username.$touch()"
         required></v-text-field>

          <v-text-field single-line
          prepend-icon="lock"
          :error-messages="hasPasswordError"
          @input="$v.user.password.$touch()"
          @blur="$v.user.password.$touch()"
          :append-icon="e1 ? 'visibility' : 'visibility_off'"
          :append-icon-cb="() => (e1 = !e1)"
          :type="e1 ? 'password' : 'text'"
          v-model="user.password"
          :label="$t('PASSWORD')"
          required></v-text-field>

          <v-btn block type="submit" :disabled="!isCompleted" class="primary" @click="submit">{{$t('SIGNIN')}}</v-btn>
          <v-btn flat small block to="home" color="red">{{$t('RETURN')}}</v-btn>
        </v-form>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import store from "@/store";
import { required } from "vuelidate/lib/validators";

export default {
  data: () => ({
    e1: true,
    user: {
      url: "",
      username: "",
      password: "",
      dbConfiguration: {
        schema: "",
        db: ""
      }
    },
    usernames: [],
    mails: [],
    valid: true,
    errorUrl: [],
    errorAuth: []
  }),
  validations: {
    user: {
      url: {
        required
      },
      username: {
        required
      },
      password: {
        required
      }
    }
  },
  computed: {
    isCompleted() {
      return this.user.username && this.user.password && this.user.url;
    },
    hasUrlError() {
      let errors = [];
      if (!this.$v.user.url.$dirty) return errors;
      !this.$v.user.url.required && errors.push(this.$i18n.t("REQUIRED"));
      if (this.$store.getters["signin/hasUrlError"]) {
        errors.push(this.$i18n.t("URL_ERROR"));
        this.$store.dispatch("signin/resetUrlError");
      }
      return errors;
    },
    hasUsernameError() {
      let errors = [];
      if (!this.$v.user.username.$dirty) return errors;
      !this.$v.user.username.required && errors.push(this.$i18n.t("REQUIRED"));
      if (this.$store.getters["signin/hasAuthError"]) {
        errors.push(this.$i18n.t("USERNAME_PW_ERROR"));
        this.user.password = "";
        this.$store.dispatch("signin/resetAuthError");
      }
      return errors;
    },
    hasPasswordError() {
      let errors = [];
      if (!this.$v.user.password.$dirty) return errors;
      !this.$v.user.password.required && errors.push(this.$i18n.t("REQUIRED"));
      return errors;
    }
  },
  mounted: function() {
    if (this.$store.getters["signin/getUserODK"].username !== undefined) {
      this.user = this.$store.getters["signin/getUserODK"];
    }
  },
  methods: {
    submit() {
      this.user.dbConfiguration = this.$store.getters[
        "signin/getDbConfiguration"
      ];
      this.$store.dispatch("signin/signinODK", this.user);
    }
  }
};
</script>

<style scoped>
.form {
  margin-top: 30px;
}

.headline {
  margin-bottom: 20px;
}

.connect {
  margin-top: 20px;
}

.lang {
  float: right;
  height: 30px;
  width: auto;
  cursor: pointer;
}
</style>
