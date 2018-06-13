<template>
<v-app dark>
  <v-toolbar fixed app dense>
<v-toolbar-title class="white--text">IRD Application</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-toolbar-items>
      <v-btn flat to="/">{{ $t("HOME") }}</v-btn>
      <v-btn flat to="signinODK">ODK</v-btn>
      <v-btn flat to="signinBdmer">BDMER³</v-btn>
    </v-toolbar-items>
    <v-menu>
      <v-toolbar-title slot="activator">
        <span class="btn btn--flat">{{ $t("LANGUAGE") }} ({{language}})</span>
        <v-icon dark>arrow_drop_down</v-icon>
      </v-toolbar-title>
      <v-list class="toggle-language">
        <v-list-tile @click="changeLanguage('fr')">
          <v-list-tile-title>Français</v-list-tile-title>
        </v-list-tile>
        <v-list-tile @click="changeLanguage('en')">
          <v-list-tile-title>English</v-list-tile-title>
        </v-list-tile>
      </v-list>
    </v-menu>
  </v-toolbar>
  <v-content>
    <router-view/>
  </v-content>
</v-app>
</template>

<script>
export default {
  data: () => ({
    drawer: false,
    themeDarkVariant: true,
    language: ""
  }),
  props: {},
  mounted: function() {
    this.language = this.$i18n.locale;
  },
  methods: {
    changeLanguage(language) {
      this.$i18n.locale = language;
      this.language = this.$i18n.locale;
    }
  }
};
</script>

<style>
.toggle-language {
  margin-top: 37px;
}

.content {
  margin-top: 100px;
}
</style>
