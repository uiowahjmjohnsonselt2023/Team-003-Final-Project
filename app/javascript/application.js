document.addEventListener('turbolinks:load', () => {
    const messageForm = document.getElementById('new_message');

    messageForm.addEventListener('ajax:success', (event) => {
        const [data, status, xhr] = event.detail;
        const messageBody = document.getElementById('message_body');

        // append the message to the chat box
        const chatMessages = document.querySelector('.chat-messages');
        const newMessageDiv = document.createElement('div');
        newMessageDiv.className = 'chat-message right'; // Assuming 'right' class is for sent messages
        newMessageDiv.textContent = messageBody.value;

        chatMessages.appendChild(newMessageDiv);

        // clear the message input field
        messageBody.value = '';
    });
});
