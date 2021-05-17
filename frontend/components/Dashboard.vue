<template>
  <div>dashboard vue</div>
</template>

<script lang="ts">
import { defineComponent } from "@vue/composition-api";
// import TodoListPage from "@/view/components/TodoListPage.vue";
import DashboardModule from "@/modules/dashboard_module";
export default defineComponent({
  // components: {
  //   TodoListPage
  // },
  setup() {
    DashboardModule.get().setup();
  }
});
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
