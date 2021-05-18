import '../styles/login.scss';

import UIkit from 'uikit';
import Icons from 'uikit/dist/js/uikit-icons';

// loads the Icon plugin
UIkit.use(Icons);

// components can be called from the imported UIkit reference
const $errors = document.getElementById('errors');
const messageJson = $errors.innerText.trim();
if (messageJson) {
  const messages = JSON.parse(messageJson);
  messages.forEach(m => UIkit.notification(m, 'danger'));
}

console.log('login');
