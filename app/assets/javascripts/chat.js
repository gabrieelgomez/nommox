
class Chat {
  constructor(channel_sid) {
    this.channel  = null;
    this.client   = null;
    this.identity = null;
    this.channels = [];
    this.messages = [];
    this.initialize(channel_sid);
    this.getChannels();
    console.log('constructor')
  }

  initialize(channel_sid) {
    this.renderMessages();

    Rails.ajax({
      url: '/tokens',
      type: 'POST',
      success: data => {
        this.identity = data.identity;
        var that      = this;

        Twilio.Chat.Client
          .create(data.token)
          .then(function(client) {
            if (channel_sid) {
              that.setupClient(client, channel_sid);
            }
          });
      }
    });
  }

  getChannels() {
    var that = this;
    if (this.channels.length == 0) {
      Rails.ajax({
        url: '/tokens',
        type: 'POST',
        success: data => {
          this.identity = data.identity;

          Twilio.Chat.Client
            .create(data.token)
            .then(function(client) {
              client.getPublicChannelDescriptors().then(function(paginator) {
                for (i = 0; i < paginator.items.length; i++) {
                  const channel = paginator.items[i];
                  that.addChannel(channel)
                  $('.loader').addClass('hidden')
                }
              })
              .catch((error) => {
                window.location.reload()
                console.log(error)
              });
            });
        }
      });
    }
  }

  addChannel(channel) {
    console.log('Add Channel', channel)
    if (channel.uniqueName) {
      this.channels.push(channel);
    }
    this.renderChannel();
  }

  renderChannel() {
    var that             = this;
    let channelContainer = document.querySelector('.inbox_chat');

    channelContainer.innerHTML = this.channels.map(channel =>
       `<div class="chat_list" id="${channel.sid}">
        <div class="chat_people chat_box">
          <div class="chat_img">
          <img src="https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg"></img>
          </div>
          <div class="chat_ib"></div>
          <h4>
            <span style="padding-left: 20px; color: #fff">${channel.uniqueName}</span>
          </h4>
          <span style="padding-left: 20px" class="channel-date">${that.formatDate(channel.dateCreated)}</span>
          <p></p>
        </div>
      </div>`).join("");
  }

  addMessage(message) {
    console.log('addMessage', message)
    let html = "";

    if (message.author && message.body) {
      if (this.identity == message.author) {
        html += `<div class="outgoing_msg">
          <div class="sent_msg">
            <p>
              ${message.body}
            </p>
            <div class="pull-right">${this.formatAMPM(message.timestamp)}</div>
            <br>
            <div class="pull-right">${message.author}</div>
          </div>
        </div>
        <br>`
      } else {
        html +=
        `<div class="incoming_msg">
          <div class="received_msg">
            <div class="received_withd_msg"><p>${message.body}</p></div>
            <div class="pull-left">${this.formatAMPM(message.timestamp)}</div>
            <br>
            <div class="pull-left">${message.author}</div>
          </div>
        </div>
        <br>`
      }
    }

    this.messages.push(html);
    this.renderMessages();
  }

  joinChannel() {
    console.log('Join Channel', this.channel.uniqueName)

    if (this.channel.state.status !== 'joined') {
      this.channel.join().then(function(channel) {
        // console.log(`Joined ${channel.uniqueName} Channel`);
       });
    } else {
      // console.log('Join Channel', channel.uniqueName)
    }
  }

  setupChannel(channel) {
    console.log('setupChannel', channel.uniqueName)
    this.channel = null;
    this.channel = channel;
    this.joinChannel();
    this.addMessage({ body: `Joined ${channel.uniqueName} channel as ${this.identity}` });
    this.channel.on('messageAdded', message => this.addMessage(message));;

    this.getChannelMessages(channel)
  }

  getChannelMessages(channel) {
    console.log('getChannelMessages', channel.uniqueName)
    const that = this;

    channel.getMessages().then(function(messages) {
      const totalMessages = messages.items.length;
      for (i = 0; i < totalMessages; i++) {
        const message = messages.items[i];
        that.addMessage(message);
        $('.loader').addClass('hidden')
      }
    });
  }

  setupClient(client, channel_sid) {

    this.client           = client;
    window.chat.client    = client;
    var that              = this;
    this.client.getChannelBySid(channel_sid)
      .then(function(channel) {
        that.setupChannel(channel)
        window.chat.channel = channel;
      })

      this.client.on('channelJoined', function(channel) {
        console.log('Joined channel ' + channel.uniqueName);
      });
  }

  renderMessages() {
    console.log('renderMessages', this.channel)
    let messageContainer = document.querySelector(".chat .messages");
    messageContainer.innerHTML = this.messages
      .map(message => message).join("");
  }

  formatDate(date) {
    var monthNames = [
      "Enero", "Febrero", "Marzo",
      "Abril", "Mayo", "Junio", "Julio",
      "Agosto", "Septiembre", "Octubre",
      "Noviembre", "Diciembre"
    ];

    var day = date.getDate();
    var monthIndex = date.getMonth();
    var year = date.getFullYear();

    return day + ' ' + monthNames[monthIndex] + ' ' + year;
  }

  formatAMPM(date) {
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var ampm = hours >= 12 ? 'pm' : 'am';
    hours = hours % 12;
    hours = hours ? hours : 12; // the hour '0' should be '12'
    minutes = minutes < 10 ? '0'+minutes : minutes;
    var strTime = hours + ':' + minutes + ' ' + ampm;
    return strTime;
  }
};
