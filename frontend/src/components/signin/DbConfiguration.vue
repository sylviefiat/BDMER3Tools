<template>
  <v-container fluid fill-height>
    <v-layout justify-center>
      <v-flex md4 sm6 xs10>
        <div class="display-2">
            {{ $t("CONFIGURE") }} <span class="deep-orange--text">{{ $t("DB") }}</span>.
        </div>
        <v-divider></v-divider>
        <v-form class="form" ref="form" lazy-validation>

         <v-text-field
         prepend-icon="save"
         v-model="dbConfiguration.db"
         :label="$t('DB')"
         :error-messages="hasDbError"
         @input="$v.dbConfiguration.db.$touch()"
         @blur="$v.dbConfiguration.db.$touch()"
         required></v-text-field>

          <v-text-field v-model="dbConfiguration.schema"
         label="Schema "
         prepend-icon="share"
         :error-messages="hasSchemaError"
         @input="$v.dbConfiguration.schema.$touch()"
         @blur="$v.dbConfiguration.schema.$touch()"
         required></v-text-field>


          <v-btn block type="submit" :disabled="!isCompleted" class="primary" @click="submit">{{$t('SAVE')}}</v-btn>
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
    dbConfiguration: {
      schema: "",
      db: ""
    }
  }),
  validations: {
    dbConfiguration: {
      schema: {
        required
      },
      db: {
        required
      }
    }
  },
  mounted: function() {
    if (this.$store.getters["signin/getDbConfiguration"].db !== undefined) {
      this.dbConfiguration = this.$store.getters["signin/getDbConfiguration"];
    }
  },
  computed: {
    isCompleted() {
      return this.dbConfiguration.schema && this.dbConfiguration.db;
    },
    hasDbError() {
      let errors = [];
      if (!this.dbConfiguration.db.$dirty) return errors;
      !this.dbConfiguration.db.required &&
        errors.push(this.$i18n.t("REQUIRED"));
      return errors;
    },
    hasSchemaError() {
      let errors = [];
      if (!this.dbConfiguration.schema.$dirty) return errors;
      !this.dbConfiguration.schema.required &&
        errors.push(this.$i18n.t("REQUIRED"));
      return errors;
    }
  },
  methods: {
    submit() {
      this.$store.dispatch("signin/saveDbConfiguration", this.dbConfiguration);
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
