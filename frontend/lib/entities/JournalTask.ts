export default class JournalTask {
  id = '';
  categoryId = '';
  memo = '';
  startTime = '';
  endTime = '';

  constructor(obj?: Partial<JournalTask>) {
    Object.assign(this, obj);
  }

  get timeString(): string {
    // TODO: 時間の計算をちゃんとする
    return `${this.startTime} - ${this.endTime} (0.5h)`;
  }
}
