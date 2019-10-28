// [START initialize_firebase_in_sw]
// Give the service worker access to Firebase Messaging.
// Note that you can only use Firebase Messaging here, other Firebase libraries
// are not available in the service worker.
importScripts('https://www.gstatic.com/firebasejs/6.6.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/6.6.1/firebase-messaging.js');

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
  var body = payload.data.twi_body;

  console.log('[firebase-messaging-sw.js] Received background message ', payload);

  messaging.setBackgroundMessageHandler(function (payload) {
    const response = payload;

    self.clients.matchAll({includeUncontrolled: true}).then(function (clients) {
      //you can see your main window client in this list.
      clients.forEach(function(client) {
        client.postMessage(response.data.channel_sid);
      })
    })
  });

  // Customize notification here
  const notificationTitle = `Tienes un nuevo mensaje de ${payload.data.author}`;
  const notificationOptions = {
    body:   body,
    icon:   '/assets/Icon-App-20x20@3x.png',
  };

  return self.registration.showNotification(notificationTitle,
    notificationOptions);
});

self.addEventListener('notificationclick', function(event) {
  let url = 'https://www.nommox.com/chat/';
  
  event.notification.close(); // Android needs explicit close.
  event.waitUntil(
    clients.matchAll({ type: 'window' }).then( windowClients => {
      // Check if there is already a window/tab open with the target URL
      for (var i = 0; i < windowClients.length; i++) {
        var client = windowClients[i];
        // If so, just focus it.
        if (client.url === url) {
          return client.focus();
        }
      }
      // If not, then open the target URL in a new window/tab.
      if (clients.openWindow) {
        return clients.openWindow(url);
      }
    })
  );
});
