<template>
<v-container fluid fill-height>
  <v-layout align-center justify-center>
    <v-flex md4 sm6 xs10>
      <div class="display-2"> {{ $t("CONVERT") }}</div>
      <img v-if="language !== 'en'" @click="changeLanguage('en')" class="lang" src="../assets/en.png">
      <img v-if="language !== 'fr'" @click="changeLanguage('fr')" class="lang" src="../assets/fr.png">
      <v-divider></v-divider>
      <div class="convertion" v-if="!convertion">

        <p> {{ $t("CONVERT_DESCRIPTION") }} </p>
        <v-btn class="btn-convert" color="primary" block @click="convert">{{ $t("CONVERT_BUTTON") }}</v-btn>
      </div>

      <div class="convertion" v-if="convertion">
        <div v-if="!convertionDone">
          <v-progress-linear :indeterminate="true"></v-progress-linear>
          <p> {{ $t("CONVERTION") }} </p>
        </div>
        <div v-if="convertionDone">
          <v-alert v-model="alertSucess" type="success" dismissible>
            {{ $t("CONVERT_SUCCESS") }}
          </v-alert>

          <v-alert v-model="alertFail" type="error" dismissible>
            {{ $t("CONVERT_FAIL") }}
          </v-alert>

          <v-btn class="btn-convert" color="primary" block @click="clear">{{ $t("GO_BACK_TO_CONVERION") }}</v-btn>
        </div>
      </div>
    </v-flex>

  </v-layout>
</v-container>
</template>

<script>
import store from '@/store'

export default {
  data: () => ({
    alertSucess: false,
    alertFail: false,
    language: "",
    convertion: false,
    convertionDone: false
  }),
  mounted: function() {
    this.language = this.$i18n.locale
  },
  methods: {
    convert() {
      this.$store.dispatch('convert/convertion')
      this.convertion = true
      setTimeout(() => {
        this.convertionDone = true
        if (Math.random() >= 0.5) {
          this.alertSucess = true
        } else {
          this.alertFail = true
        }
      }, 2500)
    },
    changeLanguage(language) {
      this.$i18n.locale = language
      this.language = this.$i18n.locale
    },
    clear(){
      this.convertionDone = false
      this.convertion = false
      this.alertSucess = false
      this.alertFail = false
    }
  }
}
</script>

<style scoped>
.display-2 {
  margin-bottom: 30px;
}

.convertion {
  margin-top: 30px;
}

.lang {
  height: 30px;
  width: auto;
  cursor: pointer;
  margin-bottom: 15px;
}

.btn-convert {
  margin-top: 20px;
}
</style>
