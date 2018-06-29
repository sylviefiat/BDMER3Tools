<template>
  <v-container fluid fill-height>
    <v-layout justify-center>
      <v-flex md5 sm8 xs10>
        <div class="display-2">
              {{ $t("CONNECT_TO") }} <span class="deep-orange--text">Seacusey surveys</span> (Api).
        </div>
        <v-divider></v-divider>
        <v-form class="form" ref="form" v-model="valid" v-on:submit.prevent="submit" lazy-validation>
          <v-text-field
         prepend-icon="link"
         v-model="user.url"
         label="Url "
         :error-messages="hasUrlError"
         hint="ex: http://bdmer3api.ird.nc"
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
import { required } from "vuelidate/lib/validators";
import CryptoJS from "crypto-js";
import config from "@/config";
import Cookies from "js-cookie";

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
			if (this.$store.getters["auth/hasUrlError"]) {
				errors.push(this.$i18n.t("URL_ERROR"));
				this.$store.dispatch("auth/resetUrlError");
			}
			return errors;
		},
		hasUsernameError() {
			let errors = [];
			if (!this.$v.user.username.$dirty) return errors;
			!this.$v.user.username.required && errors.push(this.$i18n.t("REQUIRED"));
			if (this.$store.getters["auth/hasAuthError"]) {
				errors.push(this.$i18n.t("USERNAME_PW_ERROR"));
				this.user.password = "";
				this.$store.dispatch("auth/resetAuthError");
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
	created: function() {
		this.user.url = this.$store.getters["auth/getUserODK"].url;
		this.user.username = this.$store.getters["auth/getUserODK"].username;
		this.user.password = this.$store.getters["auth/getUserODK"].password;
	},
	methods: {
		submit() {
			if (!this.user.url.startsWith("http://") && !this.user.url.startsWith("https://")) {
				this.user.url = "http://" + this.user.url;
			}
			this.user.dbConfiguration = this.$store.getters["auth/getDbConfiguration"];
			this.$store.dispatch("auth/signinODK", this.user);
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
