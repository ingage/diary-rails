<template>
  <v-app id="journals">
    <v-main class="white">
      <app-header></app-header>
      <v-container>
        <v-row>
          <v-col cols="3">
            <journals-list-sidebar></journals-list-sidebar>
          </v-col>

          <v-col>
            <journals-list-content></journals-list-content>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api';
import JournalsListPageController from '@/controllers/pages/JournalsListPageController';
import AppHeader from '@v/layouts/AppHeader.vue';
import JournalsListContent from '@v/layouts/JournalsListContent.vue';
import JournalsListSidebar from '@v/layouts/JournalsListSidebar.vue';

export default defineComponent({
  components: {
    AppHeader,
    JournalsListContent,
    JournalsListSidebar,
  },
  setup() {
    const controller = new JournalsListPageController();
    return {
      state: controller.state,
      actions: {
        click: () => controller.click(),
      },
    };
  },
});
</script>
