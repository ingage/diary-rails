<template>
  <div>
    <div v-if="state.loading">loading...</div>
    <router-view v-if="!state.loading" />
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from '@vue/composition-api';
import AppModule from '@/modules/AppModule';
import AppController from '@/controllers/AppController';

export default defineComponent({
  setup() {
    const controller = new AppController();
    controller.startLoad();

    onMounted(() => {
      AppModule.get()
        .setup()
        .then(() => {
          controller.endLoad();
        });
    });

    return {
      state: reactive(controller.state),
    };
  },
});
</script>
