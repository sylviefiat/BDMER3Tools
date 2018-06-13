<template>
<v-container fluid fill-height>
  <v-layout justify-center>
    <v-flex md4 sm6 xs10>
      <div class="display-2"> {{ $t("IMPORT_DATA_FROM") }}  <span class="deep-orange--text">ODK</span> {{ $t("TO") }} <span class="blue--text">BDMER³</span>.</div>
      <v-divider></v-divider>
      <div class="importation" v-if="!importation">
        <div>
          <v-btn class="btn-import" :color="odkConnected ? 'success' : 'primary'" to="signinODK" block @click="clear">{{ $t("CONNECT_TO") }} ODK <v-icon right v-if="odkConnected">check</v-icon></v-btn>
          <v-btn flat icon color="success" to="dbConfiguration"><v-icon>settings</v-icon></v-btn> <span class="redirect" @click="to('dbConfiguration')">{{ $t("CONFIGURE_DB_SCHEMA") }} </span>
          <v-btn class="btn-import" :color="bdmerConnected ? 'success' : 'primary'" to="signinBdmer" block @click="clear">{{ $t("CONNECT_TO") }} BDMER³  <v-icon right v-if="bdmerConnected">check</v-icon></v-btn>
        </div>

        <p> {{ $t("IMPORT_DESCRIPTION") }} </p>
        <v-tooltip bottom>
          <v-btn slot="activator" class="btn-import" color="primary" :disabled="invalid" block @click="importData">{{ $t("IMPORT_BUTTON") }}</v-btn>
          <span v-if="invalid">{{$t('IMPORT_TOOLTIP')}}</span>
          <span v-if="!invalid">{{$t('IMPORT_TOOLTIP_OK')}}</span>
        </v-tooltip bottom>
      </div>

      <div class="importation" v-if="importation">
        <div v-if="isLoading">
          <v-progress-linear :indeterminate="true"></v-progress-linear>
          <p> {{ $t("IMPORTATION") }} </p>
        </div>
        <div v-if="!isLoading">

          <v-alert v-model="alertSuccess" class="alert" type="success">
            {{success.length}} {{ $t("IMPORT_SUCCESS") }}
            <a @click="displaySuccess = !displaySuccess">{{ $t("DISPLAY_SUCCESS") }} </a>
          </v-alert>

          <v-data-table
            v-if="displaySuccess"
            :headers="headersSuccess"
            :items="success"
            class="elevation-1"
          >
            <template slot="items" slot-scope="props">
              <td>
                {{props.item.success}}
              </td>

              <td>{{ props.item.msg }}</td>
            </template>
          </v-data-table>

          <v-alert v-model="alertWarning" class="alert" type="warning">
            {{warnings.length}} {{ $t("IMPORT_WARNING") }}

            <a @click="displayWarnings = !displayWarnings">{{ $t("DISPLAY_WARNING") }} </a>
          </v-alert>

          <v-data-table
            v-if="displayWarnings"
            :headers="headersWarnings"
            :items="warnings"
            class="elevation-1"
          >
            <template slot="items" slot-scope="props">
              <td>
                {{props.item.warning}}
              </td>

              <td>{{ props.item.msg }}</td>
            </template>
          </v-data-table>

          <v-alert v-model="alertFail" class="alert" type="error">
            {{ $t("IMPORT_FAIL") }}
          </v-alert>

          <v-data-table
            :headers="headersErrors"
            :items="errors"
            class="elevation-1"
          >
            <template slot="items" slot-scope="props">
              <td>
                {{props.item.error}}
              </td>

              <td>{{ props.item.msg }}</td>
            </template>
          </v-data-table>


          <v-btn class="btn-go-back" color="primary" block @click="clear">{{ $t("GO_BACK_TO_IMPORTATION") }}</v-btn>
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
    alertSuccess: false,
    alertFail: false,
    alertWarning: false,
    language: "",
    importation: false,
    importationDone: false,
    bdmerConnected: false,
    odkConnected: false,
    invalid: true,
    errors: [],
    warnings: [],
    success: [],
    displayWarnings: false,
    displaySuccess: false,
    isLoading: false,
    headersErrors: [{ text: "Error on", value: "error" }, { text: "Description", value: "msg" }],
    headersWarnings: [{ text: "Warning on", value: "warning" }, { text: "Description", value: "msg" }],
    headersSuccess: [{ text: "Row", value: "success" }, { text: "Description", value: "msg" }]
  }),
  mounted: function() {
    this.$store.watch(
      () => this.$store.getters["importation/isLoading"],
      res => {
        this.isLoading = res;
      }
    );
    this.$store.watch(
      () => this.$store.getters["importation/hasErrors"],
      res => {
        if (res.length > 0) {
          this.errors = res;
          this.alertFail = true;
        }
      }
    );

    this.$store.watch(
      () => this.$store.getters["importation/hasWarnings"],
      res => {
        if (res.length > 0) {
          this.warnings = res;
          this.alertWarning = true;
        }
      }
    );

    this.$store.watch(
      () => this.$store.getters["importation/hasSuccess"],
      res => {
        if (res.length > 0) {
          this.success = res;
          this.alertSuccess = true;
        }
      }
    );

    this.bdmerConnected = this.$store.getters["auth/getUserBdmer"].username !== undefined ? true : false;
    this.odkConnected = this.$store.getters["auth/getUserODK"].username !== undefined ? true : false;
    this.invalid = this.$store.getters["auth/getUserBdmer"].username !== undefined && this.$store.getters["auth/getUserODK"].username !== undefined ? false : true;
    this.language = this.$i18n.locale;
  },
  methods: {
    importData() {
      let user = {
        odk: this.$store.getters["auth/getUserODK"],
        bdmer: this.$store.getters["auth/getUserBdmer"]
      };

      this.$store.dispatch("importation/import", user);

      this.importation = true;
    },
    changeLanguage(language) {
      this.$i18n.locale = language;
      this.language = this.$i18n.locale;
    },
    clear() {
      this.importationDone = false;
      this.importation = false;
      this.alertSucess = false;
      this.alertWarning = false;
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

.alert {
  margin-top: 30px;
  margin-bottom: 15px;
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
  margin-top: 30px;
}

.btn-go-back {
  margin-top: 50px;
}
</style>
