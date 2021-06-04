<template>
  <v-card outlined>
    <v-card-title>
      <journal-summary-title
        :date="$props.journal.date"
        :user-email="$props.journal.userEmail"
        :group-id="$props.journal.groupId"
      ></journal-summary-title>
    </v-card-title>
    <v-row>
      <v-col cols="6">
        <journal-task-list :tasks="$props.journal.tasks"></journal-task-list>
      </v-col>
      <v-col>
        <div class="px-4">
          <v-textarea
            label="所感"
            outlined
            readonly
            no-resize
            :value="$props.journal.memo"
          ></v-textarea>
        </div>
      </v-col>
    </v-row>
  </v-card>
</template>

<script lang="ts">
import { defineComponent, PropType } from '@vue/composition-api';
import Journal from '@/entities/Journal';
import JournalSummaryTitle from '@v/elements/JournalSummaryTitle.vue';
import JournalTaskList from '@v/components/JournalTaskList.vue';

export default defineComponent({
  components: {
    JournalSummaryTitle,
    JournalTaskList,
  },
  props: {
    journal: { type: Object as PropType<Journal>, required: true },
  },
  setup() {
    return {};
  },
});
</script>
