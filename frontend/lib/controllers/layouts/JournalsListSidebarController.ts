import { reactive, UnwrapRef } from '@vue/composition-api';

type StateType = {
  date?: string;
};

export default class JournalsListSidebarController {
  private readonly stateObj: StateType;

  /**
   *
   */
  constructor() {
    this.stateObj = {};
  }

  /**
   * Click 時の処理
   */
  click(): void {
    console.log('click');
  }

  /**
   * component に反映させる情報
   */
  get state(): UnwrapRef<StateType> {
    return reactive(this.stateObj);
  }
}
