import { reactive, UnwrapRef } from '@vue/composition-api';

type StateType = {
  loading: boolean;
};

export default class AppController {
  private readonly stateObj: StateType;

  /**
   * @param loading
   */
  constructor(loading = false) {
    this.stateObj = {
      loading: loading,
    };
  }

  startLoad(): void {
    this.stateObj.loading = true;
  }

  endLoad(): void {
    this.stateObj.loading = false;
  }

  /**
   * component に反映させる情報
   */
  get state(): UnwrapRef<StateType> {
    return reactive(this.stateObj);
  }
}
