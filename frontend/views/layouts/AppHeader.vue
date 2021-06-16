<template>
  <v-app-bar app color="cyan lighten-5" flat>
    <v-container class="py-0 fill-height">
      <v-avatar class="mr-10" color="grey darken-1" size="32"></v-avatar>

      <v-btn v-for="link in state.links" :key="link" text>
        {{ link }}
      </v-btn>

      <v-spacer></v-spacer>

      <v-responsive max-width="260">
        <v-text-field dense flat hide-details rounded solo-inverted></v-text-field>
      </v-responsive>
    </v-container>
  </v-app-bar>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api';
import AppHeaderController from '@/controllers/layouts/AppHeaderController';

export default defineComponent({
  setup() {
    const controller = new AppHeaderController();
    return {
      state: controller.state,
      actions: {
        click: () => controller.click(),
      },
    };
  },
});
</script>
