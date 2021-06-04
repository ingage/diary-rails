import { reactive, UnwrapRef } from '@vue/composition-api';
import Journal from '@/entities/Journal';
import JournalTask from '@/entities/JournalTask';

type StateType = {
  journals: Journal[];
};

export default class JournalsListContentController {
  private readonly stateObj: StateType;

  /**
   *
   */
  constructor() {
    this.stateObj = {
      // TODO: 検索条件を元にAPIから取得する
      journals: [
        new Journal({
          date: '2021/4/27',
          userEmail: 'nagata@ingage.jp',
          groupId: 'dev',
          memo: [
            '人事部のスケジュールが多すぎてかなり入れにくい。初めに面接に入る人をキチンと聞いたほうが良かった。',
            '',
            'config.time_zone を変更したことによるテストエラーが辛かった。',
            'Time と TimeWithZone で iso8601 の表現が変わるとか知らんわ。。。',
          ].join('\n'),
          tasks: [
            new JournalTask({
              categoryId: 'improvement',
              startTime: '09:00',
              endTime: '11:00',
              memo: '#10001',
            }),
            new JournalTask({
              categoryId: 'feature',
              startTime: '13:00',
              endTime: '21:00',
              memo: '日報システム',
            }),
          ],
        }),
      ],
    };
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
