<template>
  <span> [{{ $props.date }}] {{ state.groupName }} - {{ state.userName }} </span>
</template>

<script lang="ts">
import { useUserStore } from '@/stores/persistents/userStore';
import { useGroupStore } from '@/stores/persistents/groupStore';
import { defineComponent, reactive } from '@vue/composition-api';

type PropsType = {
  date: string;
  userEmail: string;
  groupId: string;
};

export default defineComponent({
  props: {
    date: { type: String, required: true },
    userEmail: { type: String, required: true },
    groupId: { type: String, required: true },
  },
  setup(props: PropsType) {
    const userStore = useUserStore();
    const groupStore = useGroupStore();

    const state = reactive({
      userName: userStore.find(props.userEmail)?.name,
      groupName: groupStore.find(props.groupId)?.name,
    });

    return {
      state,
    };
  },
});
</script>
