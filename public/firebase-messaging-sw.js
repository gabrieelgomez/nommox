// [START initialize_firebase_in_sw]
// Give the service worker access to Firebase Messaging.
// Note that you can only use Firebase Messaging here, other Firebase libraries
// are not available in the service worker.
importScripts('https://www.gstatic.com/firebasejs/6.6.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/6.6.1/firebase-messaging.js');
importScripts('https://code.jquery.com/jquery-3.4.1.slim.min.js');

// Initialize the Firebase app in the service worker by passing in the
// messagingSenderId.
firebase.initializeApp({
  'messagingSenderId': '757853850589'
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();
// [END initialize_firebase_in_sw]

// If you would like to customize notifications that are received in the
// background (Web app is closed or not in browser focus) then you should
// implement this optional method.
// [START background_handler]
messaging.setBackgroundMessageHandler(function(payload) {
  var body = payload.data.twi_body.split(':')[1].trim()
  var id   = payload.data.channel_sid;

  console.log('[firebase-messaging-sw.js] Received background message ', payload);

  docum
  $('#'+id).find('.notification-badge').removeClass('hiddden')

  // Customize notification here
  const notificationTitle = `Tienes un nuevo mensaje de ${payload.data.author}`;
  const notificationOptions = {
    body: body
  };

  return self.registration.showNotification(notificationTitle,
      notificationOptions);
});
