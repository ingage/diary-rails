<template>
  <v-data-table
    :headers="state.headers"
    :items="state.tasks"
    :hide-default-footer="true"
  ></v-data-table>
</template>

<script lang="ts">
import { defineComponent, PropType } from '@vue/composition-api';
import JournalTask from '@/entities/JournalTask';
import JournalTaskListController from '@/controllers/components/JournalTaskListController';

export default defineComponent({
  props: {
    tasks: { required: true, type: Array as PropType<JournalTask[]> },
  },
  setup(props) {
    const controller = new JournalTaskListController(props.tasks);
    return {
      state: controller.state,
    };
  },
});
</script>
