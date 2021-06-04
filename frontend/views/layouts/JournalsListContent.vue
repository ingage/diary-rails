<template>
  <v-sheet min-height="70vh" rounded="lg">
    <journal-summary
      v-for="journal in state.journals"
      :key="journal.id"
      :journal="journal"
    ></journal-summary>
  </v-sheet>
</template>

<script lang="ts">
import { defineComponent } from '@vue/composition-api';
import JournalsListContentController from '@/controllers/layouts/JournalsListContentController';
import JournalSummary from '@v/components/JournalSummary.vue';

export default defineComponent({
  components: {
    JournalSummary,
  },
  setup() {
    const controller = new JournalsListContentController();
    return {
      state: controller.state,
      actions: {
        click: () => controller.click(),
      },
    };
  },
});
</script>
