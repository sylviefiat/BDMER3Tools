<template>
<v-app dark>
  <v-toolbar  class="hidden-sm-and-down" fixed app dense>
    <v-toolbar-title class="white--text">IRD / SFA</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-toolbar-items>
      <v-btn flat to="/">{{ $t("HOME") }}</v-btn>
      <v-btn flat to="signinODK">Seacusey surveys</v-btn>
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

  <div class="hidden-md-and-up">
      <v-navigation-drawer
      v-model="drawer"
      clipped
      app
      fixed
      dark
      >
      <v-list>
        <v-list-tile to="/">
          <v-list-tile-action>
            <v-icon>home</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>{{ $t("HOME") }}</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile to="/signinODK">
          <v-list-tile-action>
            <v-icon>person</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Seacusey surveys</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile to="/signinBdmer">
          <v-list-tile-action>
            <v-icon>person</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>BDMER³</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-group
        prepend-icon="flag">

        <v-list-tile slot="activator">
          <v-list-tile-title>{{ $t("LANGUAGE") }} ({{language}})</v-list-tile-title>
        </v-list-tile>

        <v-list-tile @click="changeLanguage('en')">
          <v-list-tile-action>
            <v-icon></v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title >English</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile  @click="changeLanguage('fr')">
          <v-list-tile-action>
            <v-icon></v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Français</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

      </v-list-group>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar app fixed clipped-left dense flat dark>
      <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
    </v-toolbar>
  </div>

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
    },
    to(redirect) {
      router.push(redirect);
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
