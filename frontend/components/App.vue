<template>
  <div>
    <div v-if="state.loading">loading...</div>
    <router-view v-if="!state.loading" />
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from '@vue/composition-api';
import AppModule from '@/modules/AppModule';
import AppState from '@/states/AppState';

export default defineComponent({
  setup() {
    const state = new AppState();
    state.loading = true;

    onMounted(() => {
      AppModule.get()
        .setup()
        .then(() => {
          state.loading = false;
        });
    });

    return {
      state: reactive(state),
    };
  },
});
</script>
