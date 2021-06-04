<template>
  <v-sheet rounded="lg">
    <v-list color="transparent">
      <v-list-item v-for="n in 5" :key="n" link>
        <v-list-item-content>
          <v-list-item-title> List Item {{ n }} </v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-divider class="my-2"></v-divider>

      <v-list-item link color="grey lighten-4">
        <v-list-item-content>
          <v-list-item-title> Refresh </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-sheet>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api';
import JournalsListSidebarController from '@/controllers/layouts/JournalsListSidebarController';

export default defineComponent({
  setup() {
    const controller = new JournalsListSidebarController();
    return {
      state: controller.state,
      actions: {
        click: () => controller.click(),
      },
    };
  },
});
</script>
