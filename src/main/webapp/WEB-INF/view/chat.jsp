<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Chat</title>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
   
    <style>
		* {
			box-sizing: border-box;
			margin: 0;
			padding: 0;
			font-family: Arial, sans-serif;
		}

		body, html {
			height: 100%;
			display: flex;
			flex-direction: column;
			background-color: #f0f0f0;
		}

		header {
			background-color: #a3bedb;
			color: white;
			padding: 15px;
			text-align: center;
			font-size: 1.5em;
		}

		main {
			flex: 1;
			padding: 10px;
			overflow-y: auto;
			display: flex;
			flex-direction: column;
			gap: 10px;
		}

		footer {
			display: flex;
			padding: 10px;
			background-color: white;
			border-top: 1px solid #ddd;
		}

		#message-input {
			flex: 1;
			padding: 10px;
			border: 1px solid #ddd;
			border-radius: 5px;
			margin-right: 10px;
		}

		#send-button {
			padding: 10px 20px;
			background-color: #a3bedb;
			color: white;
			border: none;
			border-radius: 5px;
			cursor: pointer;
		}

		.message {
			padding: 10px;
			border-radius: 5px;
		}	
		
		.msg-container {
			padding: 10px;
			border-radius: 5px;
			max-width: 70%;
		}
		.msg-container.server {
			align-self: flex-start;
		}
		.msg-container.user {
			align-self: flex-end;
		}
		.message.user {
			background-color: #a3bedb;
			color: white;
			clear: right;
		}
		.message.server {
			background-color: #e0e0e0;
			color: black;
			clear: left;
		}
		.userName{
			float: right;
		}
		.serverName{
			float: left;
		}

	</style>
</head>
<body>
    <header>
        <h1>Mobile Chat </h1>
    </header>
    <main id="chat-container">
        <!-- Chat messages will appear here -->
    </main>
    <footer>
        <input id="message-input" type="text" placeholder="Type your message">
        <button id="send-button" onclick="sendMsg()">Send</button>
    </footer>
    <script>
    	
    	const username = `${user.username}`
   		const room = `${room}`
   		
	    function addMessage(data, sender) {
	    	const chatContainer = document.getElementById("chat-container");
			const messageInput = document.getElementById("message-input");
			const sendButton = document.getElementById("send-button");
						
			const msgContainer =  document.createElement("div")
			msgContainer.classList.add("msg-container", sender);
			console.log(sender)
			msgContainer.innerHTML='<span class="'+(sender == "user" ? "userName" : "serverName")+'">'+data.sender+'</span>';
			
			const messageElement = document.createElement("div")
			messageElement.classList.add("message", sender);
			messageElement.innerText = data.msg;
			msgContainer.appendChild(messageElement)
			chatContainer.appendChild(msgContainer);

			chatContainer.scrollTop = chatContainer.scrollHeight;
		}
	    
    	const eventSource = new EventSource("http://localhost:8080/chatting/" + room);
    	eventSource.onmessage = (event) => {
    		const data = JSON.parse(event.data)
    		addMessage(data, data.sender == username ? 'user' : 'server');
    	}
		async function sendMsg(){
			document.getElementById("send-button").disabled = true;
	    	event.preventDefault();

	    	const data = {
   			  msg: document.getElementById('message-input').value,
   			  sender: username,
   			  room: room
   			};
	    	console.log(data)
	    	await axios.post('http://localhost:8080/chatting', data)
		    	.then((res) => {
		    		document.getElementById('message-input').value = '';
		    	}).catch( (err) =>{
		    		console.log(err)
		    		alert('에러 발생')
		    	})
	    	document.getElementById("send-button").disabled = false;
		}
    	

	</script>
</body>
</html>
