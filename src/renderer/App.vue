<template>
<v-app dark>
      <v-toolbar  class="hidden-sm-and-down" fixed app dense>
        <v-toolbar-title class="white--text">IRD / SFA</v-toolbar-title>

        <v-tooltip bottom>
          <span slot="activator" v-if="online" class="dot-green"></span>
          <span>{{$t('ONLINE')}}</span>
        </v-tooltip bottom>

        <v-tooltip bottom>
          <span slot="activator" v-if="!online" class="dot-red"></span>
          <span>{{$t('OFFLINE')}}</span>
        </v-tooltip bottom>
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
          disable-resize-watcher
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
          <v-toolbar-title class="white--text">IRD / SFA</v-toolbar-title>
          <v-tooltip bottom>
            <span slot="activator" v-if="online" class="dot-green"></span>
            <span>{{$t('ONLINE')}}</span>
          </v-tooltip bottom>

          <v-tooltip bottom>
            <span slot="activator" v-if="!online" class="dot-red"></span>
            <span>{{$t('OFFLINE')}}</span>
          </v-tooltip bottom>
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
		language: "",
		online: null
	}),
	props: {},
	mounted: function() {
		this.language = this.$i18n.locale;
		const self = this;
		window.addEventListener("load", function() {
			self.updateOnlineStatus();
			window.addEventListener("online", self.updateOnlineStatus);
			window.addEventListener("offline", self.updateOnlineStatus);
		});
	},
	methods: {
		updateOnlineStatus() {
			this.online = navigator.onLine || false;
		},
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
.dot-green {
	height: 20px;
	width: 20px;
	background-color: #4caf50;
	border-radius: 50%;
	display: inline-block;
	margin-left: 25px;
	margin-top: 5px;
}
.dot-red {
	height: 20px;
	width: 20px;
	background-color: #f44336;
	border-radius: 50%;
	display: inline-block;
	margin-left: 25px;
	animation: offline 3s infinite;
	margin-top: 5px;
}

@keyframes offline {
	0% {
		opacity: 0;
	}
	25% {
		opacity: 1;
	}
	50% {
		opacity: 0;
	}
	75% {
		opacity: 1;
	}
	100% {
		opacity: 0;
	}
}

::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: #555;
}

::-webkit-scrollbar {
	width: 8px;
	background-color: #555;
}

::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	background-color: #f5f5f5;
}

.toggle-language {
	margin-top: 37px;
}

.content {
	overflow: auto;
	margin-top: 30px;
}
</style>
