import consumer from "./consumer"

consumer.subscriptions.create({ channel: "MessagesChannel", conversation_id: 1 }, {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        // Called when there's incoming data on the websocket for this channel
        const messages = document.getElementById('messages');
        messages.innerHTML += data.message;
    }
});