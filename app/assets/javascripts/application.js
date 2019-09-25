// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require adminlte
//= require activestorage
//= require twitter/bootstrap
//= require_tree .


document.addEventListener("DOMContentLoaded", () => {
  if (document.querySelector(".chat")) {
    window.chat = new Chat();
  }

  $('body').on('click', '.chat_list', function(e) {
    e.preventDefault();
    id = $(this).attr('id');
    window.chat = new Chat(id);
    $('.messages').html('')
    $('.channel-detail').addClass('hidden')
    $('.type_msg').removeClass('hidden')
    $('.loader').removeClass('hidden')
  });

  $('.msg_send_btn').click(function() {
    const input = $('.chat input');
    if (input.val() != "") {
      window.chat.channel.sendMessage(input.val())
      input.val('');
      setTimeout(function() {
        let messageContainer = document.querySelector(".chat .messages");
        messageContainer.scrollTop = messageContainer.scrollHeight - 10;
      }, 500)
    }
  })

  $('.chat input').keypress(function(e) {
    if(e.which == 10 || e.which == 13) {
      if ($(this).val() != "") {
        window.chat.channel.sendMessage($(this).val());
        $(this).val('');
        setTimeout(function() {
          let messageContainer = document.querySelector(".chat .messages");
          messageContainer.scrollTop = messageContainer.scrollHeight - 10;
        }, 500)
      }
    }
  });
});

navigator.serviceWorker.addEventListener('message', function (event) {
  var id      = event.data,
      element = $('#'+id);
  console.log('event listener', event.data);
  element.addClass('channel-active')
  element.find('.notification-badge').removeClass('hidden')

  var sound = new Audio("http://localhost:3000/assets/notification.mp3");
  sound.play();
});

// function send_message_to_sw(msg) {
//   return new Promise(function(resolve, reject){
//     // Create a Message Channel
//     var msg_chan = new MessageChannel();
//
//     // Handler for recieving message reply from service worker
//     msg_chan.port1.onmessage = function(event){
//       if(event.data.error){
//           reject(event.data.error);
//       }else{
//           resolve(event.data);
//       }
//     };
//
//     // Send message to service worker along with port for reply
//     navigator.serviceWorker.controller.postMessage("Client 1 says '"+msg+"'", [msg_chan.port2]);
//   });
// }

Rails.ajax({
  url: "/tokens",
  type: "POST",
  success: function(data) {
    Twilio.Chat.Client
      .create(data.token)
      .then(function(chatClient) {
        const messaging = firebase.messaging();

        if (firebase && messaging) {
          messaging.requestPermission().then(() => {
          // getting FCM token
          messaging.getToken().then((fcmToken) => {
            // passing FCM token to the `chatClientInstance` to register for push notifications
            chatClient.setPushRegistrationId('fcm', fcmToken);

            // registering event listener on new message from firebase to pass it to the Chat SDK for parsing
            messaging.onMessage(payload => {
              console.log('onMessage', payload)
              console.log('onMessage', payload.data.channel_sid)
              $('#'+payload.data.channel_sid).addClass('channel-active')
              chatClient.handlePushNotification(payload);
            });
           }).catch((err) => {
            console.log(err)
           });
         }).catch((err) => {
          console.log(err)
         });
       }
      if (window.chat.channels.length == 0) {
        chatClient.getPublicChannelDescriptors().then(function(paginator) {
          for (i = 0; i < paginator.items.length; i++) {
            const channel = paginator.items[i];
          }
        });
      }
    });
  }
});
