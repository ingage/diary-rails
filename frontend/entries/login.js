import "../styles/login.scss"

import UIkit from 'uikit';
import Icons from 'uikit/dist/js/uikit-icons';

// loads the Icon plugin
UIkit.use(Icons);

// components can be called from the imported UIkit reference
const $errors = document.getElementById('errors');
const messages_json = $errors.innerText.trim();
if (messages_json) {
  const messages = JSON.parse(messages_json)
  messages.forEach((m) => UIkit.notification(m, 'danger'));
}

console.log('login');
