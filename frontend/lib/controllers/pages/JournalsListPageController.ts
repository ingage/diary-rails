import { reactive, UnwrapRef } from '@vue/composition-api';

type StateType = {
  cards: string[];
  drawer: boolean | null;
};

export default class JournalsListPageController {
  private readonly stateObj: StateType;

  /**
   */
  constructor() {
    this.stateObj = {
      cards: ['Today', 'Yesterday'],
      drawer: null,
    };
  }

  /**
   * Click 時の処理
   */
  click(): void {
    console.log('click');
    this.stateObj.cards.push('Tomorrow');
  }

  /**
   * component に反映させる情報
   */
  get state(): UnwrapRef<StateType> {
    return reactive(this.stateObj);
  }
}
