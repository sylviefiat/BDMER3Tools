<template>
<v-container fluid fill-height>
  <v-layout justify-center>
    <v-flex md4 sm6 xs10>
      <div class="display-2"> {{ $t("IMPORT_DATA_FROM") }}  <span class="deep-orange--text">ODK</span> {{ $t("TO") }} <span class="blue--text">BDMER³</span>.</div>
      <v-divider></v-divider>
      <div class="importation" v-if="!importation">
        <div>
          <v-btn class="btn-import" :color="odkConnected ? 'success' : 'primary'" to="signinODK" block @click="clear">{{ $t("CONNECT_TO") }} ODK</v-btn>
          <v-btn flat icon color="success" to="dbConfiguration"><v-icon>settings</v-icon></v-btn> <span class="redirect" @click="to('dbConfiguration')">{{ $t("CONFIGURE_DB_SCHEMA") }} </span>
          <v-btn class="btn-import" :color="bdmerConnected ? 'success' : 'primary'" to="signinBdmer" block @click="clear">{{ $t("CONNECT_TO") }} BDMER³</v-btn>
        </div>

        <p> {{ $t("IMPORT_DESCRIPTION") }} </p>
        <v-tooltip bottom>
          <v-btn slot="activator" class="btn-import" color="primary" :disabled="invalid" block @click="importData">{{ $t("IMPORT_BUTTON") }}</v-btn>
          <span v-if="invalid">{{$t('IMPORT_TOOLTIP')}}</span>
          <span v-if="!invalid">{{$t('IMPORT_TOOLTIP_OK')}}</span>
        </v-tooltip bottom>
      </div>

      <div class="importation" v-if="importation">
        <div v-if="!importationDone">
          <v-progress-linear :indeterminate="true"></v-progress-linear>
          <p> {{ $t("IMPORTATION") }} </p>
        </div>
        <div v-if="importationDone">
          <v-alert v-model="alertSucess" type="success">
            {{ $t("IMPORT_SUCCESS") }}
          </v-alert>

          <v-alert v-model="alertFail" type="error">
            {{ $t("IMPORT_FAIL") }}
          </v-alert>

          <v-btn class="btn-import" color="primary" block @click="clear">{{ $t("GO_BACK_TO_IMPORTATION") }}</v-btn>
        </div>
      </div>
    </v-flex>

  </v-layout>
</v-container>
</template>

<script>
import store from "@/store";
import router from "@/router";

export default {
  data: () => ({
    alertSucess: false,
    alertFail: false,
    language: "",
    importation: false,
    importationDone: false,
    bdmerConnected: false,
    odkConnected: false,
    invalid: true
  }),
  mounted: function() {
    this.bdmerConnected =
      this.$store.getters["signin/getUserBdmer"].username !== undefined
        ? true
        : false;
    this.odkConnected =
      this.$store.getters["signin/getUserODK"].username !== undefined
        ? true
        : false;
    this.invalid =
      this.$store.getters["signin/getUserBdmer"].username !== undefined &&
      this.$store.getters["signin/getUserODK"].username !== undefined
        ? false
        : true;
    this.language = this.$i18n.locale;
  },
  methods: {
    importData() {
      this.$store.dispatch("import/importation");
      this.importation = true;
      setTimeout(() => {
        this.importationDone = true;
        if (Math.random() >= 0.5) {
          this.alertSucess = true;
        } else {
          this.alertFail = true;
        }
      }, 2500);
    },
    changeLanguage(language) {
      this.$i18n.locale = language;
      this.language = this.$i18n.locale;
    },
    clear() {
      this.importationDone = false;
      this.importation = false;
      this.alertSucess = false;
      this.alertFail = false;
    },
    to(redirect) {
      router.push(redirect);
    }
  }
};
</script>

<style>
.display-2 {
  margin-bottom: 30px;
}

.importation {
  margin-top: 30px;
}

.lang {
  height: 30px;
  width: auto;
  cursor: pointer;
  margin-bottom: 15px;
}

.redirect {
  cursor: pointer;
}

.btn-import {
  margin-top: 20px;
}
</style>
