import { reactive, UnwrapRef } from '@vue/composition-api';

type StateType = {
  cards: string[];
  drawer: boolean | null;
  links: string[][];
};

export default class DashboardPageController {
  private readonly stateObj: StateType;

  /**
   *
   */
  constructor() {
    this.stateObj = {
      cards: ['Today', 'Yesterday'],
      drawer: null,
      links: [
        ['mdi-inbox-arrow-down', 'Inbox'],
        ['mdi-send', 'Send'],
        ['mdi-delete', 'Trash'],
        ['mdi-alert-octagon', 'Spam'],
      ],
    };
  }

  /**
   * Click 時の処理
   */
  click(): void {
    console.log('click');
    this.state.cards.push('Tomorrow');
  }

  /**
   * component に反映させる情報
   */
  get state(): UnwrapRef<StateType> {
    return reactive(this.stateObj);
  }
}
