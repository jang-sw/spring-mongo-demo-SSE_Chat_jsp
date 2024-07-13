<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <style>
		/* General Styles */
		body {
			margin: 0;
			font-family: Arial, sans-serif;
			background-color: #f0f0f0;
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100vh;
		}

		/* Login Container */
		.login-container {
			background-color: white;
			padding: 20px;
			border-radius: 5px;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			width: 300px;
		}

		/* Login Form */
		.login-form {
			display: flex;
			flex-direction: column;
		}

		.login-form h2 {
			margin: 0 0 20px 0;
			text-align: center;
		}

		.input-group {
			margin-bottom: 15px;
		}

		.input-group label {
			margin-bottom: 5px;
			display: block;
		}

		.input-group input {
			width: 100%;
			padding: 10px;
			box-sizing: border-box;
			border: 1px solid #ccc;
			border-radius: 5px;
		}

		button {
			padding: 10px;
			border: none;
			border-radius: 5px;
			background-color: #0044cc;
			color: white;
			font-size: 16px;
			cursor: pointer;
			transition: background-color 0.3s;
   			margin-bottom: 3px;
		}

		button:hover {
			background-color: #002080;
		}

		#error-message {
			color: red;
			text-align: center;
			margin-top: 10px;
		}

		.request-container {
		    background-color: white;
		    padding: 20px;
		    border-radius: 5px;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    width: 257px;
		    position: fixed;
		    z-index: 2;
		    top: 20px;
		    left: 40%;
		    display: none;
		}
		
		/* Request Form */
		.request-container .request-form {
		    display: flex;
		    flex-direction: column;
		}
		
		.request-container .request-form h2 {
		    margin: 0 0 20px 0;
		    text-align: center;
		}
		
		.request-container .request-form .input-group {
		    margin-bottom: 15px;
		}
		
		.request-container .request-form .input-group label {
		    margin-bottom: 5px;
		    display: block;
		}
		
		.request-container .request-form .input-group input {
		    width: 100%;
		    padding: 10px;
		    box-sizing: border-box;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		}
		.modal-background{
		  z-index: 1;
		  background-color: #333333a6;
		  height: 100%;
		  width: 100%;
		  position: fixed;
		  top: 0;
		  left: 0;
		  display: none;
		}
		@media (max-width: 768px) {
		   
		    .request-container{
		        width: 81%;
		        left: 4%;
		    }
		
		}   
	</style>
</head>
<body>
    <div class="login-container">
        <form id="loginForm" class="login-form" onsubmit="joinRoom(event)">
            <h2>Join Room</h2>
            <div class="input-group">
                <label for="room">room</label>
                <input type="text" id="room" name="room" required>
            </div>
            <button type="submit"  >Join Room</button>
        </form>
    </div>

    <script>
    	function joinRoom(event){
	    	event.preventDefault();
	    	const room = document.getElementById('room').value;
			location.href = ('/chat/' + room);
	    }
	   
		
	</script>
</body>
</html>
