import JournalTask from '@/entities/JournalTask';

export default class Journal {
  id = '';
  userEmail = '';
  groupId = '';
  date = '';
  memo = '';
  secretMemo = '';
  leaveFlag = false;
  tasks: JournalTask[] = [];

  constructor(obj?: Partial<Journal>) {
    Object.assign(this, obj);
  }
}
