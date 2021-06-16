import JournalTask from '@/entities/JournalTask';
import { reactive, UnwrapRef } from '@vue/composition-api';
import { DataTableHeader } from 'vuetify';

type StateType = {
  headers: DataTableHeader[];
  tasks: JournalTask[];
};

export default class JournalTaskListController {
  private readonly stateObj: StateType;

  /**
   * @param tasks
   */
  constructor(private readonly tasks: JournalTask[]) {
    this.stateObj = {
      headers: [
        {
          text: '時間（合計 8h）',
          value: 'timeString',
        },
        {
          text: '内容',
          value: 'memo',
        },
        {
          text: 'カテゴリ',
          value: 'categoryId',
        },
      ],
      tasks: tasks ? tasks : [],
    };
  }

  /**
   * component に反映させる情報
   */
  get state(): UnwrapRef<StateType> {
    return reactive(this.stateObj);
  }
}
