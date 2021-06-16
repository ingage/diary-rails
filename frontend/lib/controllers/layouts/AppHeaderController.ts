import { reactive, UnwrapRef } from '@vue/composition-api';

type StateType = {
  links: string[];
};

export default class AppHeaderController {
  private readonly stateObj: StateType;

  /**
   *
   */
  constructor() {
    this.stateObj = {
      links: ['Dashboard', 'Messages', 'Profile', 'Updates'],
    };
  }

  /**
   * component に反映させる情報
   */
  get state(): UnwrapRef<StateType> {
    return reactive(this.stateObj);
  }

  /**
   * Click 時の処理
   */
  click(): void {
    console.log('click');
  }
}
