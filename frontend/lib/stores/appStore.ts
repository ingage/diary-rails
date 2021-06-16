import { defineStore } from 'pinia';

export const useAppStore = defineStore({
  id: 'application',

  // a function that returns a fresh state
  state: () => ({
    csrfToken: '',
    environment: '',
  }),

  // optional getters
  getters: {},

  // optional actions
  actions: {
    reload() {
      this.csrfToken = getHtmlMetaElement('csrf-token').content;
      this.environment = getHtmlMetaElement('environment').content;
    },
  },
});

function getHtmlMetaElement(name: string): HTMLMetaElement {
  return <HTMLMetaElement>document.querySelectorAll(`meta[name="${name}"]`)[0];
}
