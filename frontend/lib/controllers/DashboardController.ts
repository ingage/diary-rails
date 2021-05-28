import DashboardState from '@/states/DashboardState';

export default class DashboardController {
  /**
   * State の初期化をする
   * 本来はデフォルトの検索条件で検索した結果を入れる
   * @param state
   */
  constructor(private state: DashboardState) {
    state.cards = ['Today', 'Yesterday'];
    state.drawer = null;
    state.links = [
      ['mdi-inbox-arrow-down', 'Inbox'],
      ['mdi-send', 'Send'],
      ['mdi-delete', 'Trash'],
      ['mdi-alert-octagon', 'Spam'],
    ];
  }

  /**
   * Click 時の処理
   */
  click(): void {
    console.log('click');
    this.state.cards.push('Tomorrow');
  }
}
