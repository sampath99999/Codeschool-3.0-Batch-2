function sendMessage() {
    console.log('Send button clicked!');
    var messageInput = document.getElementById('message-input');
    var message = messageInput.value;
    if (message.trim() !== '') {
        appendUserMessage(message);

        setTimeout(function() {
            appendBotMessage('Hi there!');
        }, 1000);
        messageInput.value = '';
    }
}

function appendUserMessage(message) {
    appendMessage('user-message', 'You: ' + message);
}

function appendBotMessage(message) {
    appendMessage('bot-message', 'Bot: ' + message);
}

function appendMessage(className, message) {
    var chatBox = document.getElementById('chat-box');
    var newMessage = document.createElement('div');
    newMessage.className = className;
    newMessage.textContent = message;
    chatBox.appendChild(newMessage);

    chatBox.scrollDown = chatBox.scrollHeight;
}