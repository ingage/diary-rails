import JournalsPageState from '@/states/JournalsPageState';

export default class JournalsPageController {
  /**
   * State の初期化をする
   * 本来はデフォルトの検索条件で検索した結果を入れる
   * @param state
   */
  constructor(private state: JournalsPageState) {
    state.cards = ['Today', 'Yesterday'];
    state.drawer = null;
    state.links = ['Dashboard', 'Messages', 'Profile', 'Updates'];
  }

  /**
   * Click 時の処理
   */
  click(): void {
    console.log('click');
    this.state.cards.push('Tomorrow');
  }
}
