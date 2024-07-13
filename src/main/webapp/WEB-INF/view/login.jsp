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
        <form id="loginForm" class="login-form" onsubmit="login(event)">
            <h2>Login</h2>
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" id="login-btn">Login</button>
            <button type="button" onclick="modalOpen()" >Join</button>
            <div id="error-message"></div>
        </form>
    </div>


	<div class="modal-background" id="modal-background" ></div>
    <div class="request-container" id="user-modal">
        <form id="userequestForm" class="request-form" onsubmit="join(event)">
            <h2>Join <span style="float: right; color:darkgray; cursor: pointer;" onclick="modalCloase()">X</span></h2>
            <div class="input-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" required >
            </div>
            <div class="input-group">
                <label for="team">비밀번호</label>
                <input type="password" id="pwd" name="pwd" required>
            </div>
           
            <button type="submit" id="submit-btn">등록</button>

            <div id="success-message"></div>
        </form>
    </div>
    <script>
    
	    function modalOpen(){
	    	document.getElementById('name').value ='';
 			document.getElementById('pwd').value ='';
	        const modal = document.getElementById('user-modal');
	        const background = document.getElementById('modal-background');
	        modal.style.display = 'block';
	        background.style.display = 'block';
	
	    }
	    async function join(event){
	    	document.getElementById("submit-btn").disabled = true;
	    	event.preventDefault();

	    	const data = {
   			  username: document.getElementById('name').value,
   			  pwd: document.getElementById('pwd').value
   			};
	    	console.log(data)
	    	await axios.post('http://localhost:8080/join',data)
		    	.then((res) => {
		    		if(res.data == -1){
		    			alert('이미 있는 이름')
		    		}else{
		    			alert('가입 성공')
		    			modalCloase();
		    		}
		    	}).catch( (err) =>{
		    		console.log(err)
		    		alert('에러 발생')
		    	})
            document.getElementById('submit-btn').disabled = false;
	    }
	    async function login(event){
	    	document.getElementById("login-btn").disabled = true;
	    	event.preventDefault();

	    	const data = {
   			  username: document.getElementById('username').value,
   			  pwd: document.getElementById('password').value
   			};
	    	await axios.post('http://localhost:8080/login',data)
		    	.then((res) => {
		    		if(res.data == -1){
		    			alert('아이디와 비밀번호를 확인하세요')
		    		}else{
		    			location.href = '/'
		    			modalCloase();
		    		}
		    	}).catch( (err) =>{
		    		console.log(err)
		    		alert('에러 발생')
		    	})
		    	
            document.getElementById('login-btn').disabled = false;
	    }
	    function modalCloase(){
	        const modal = document.getElementById('user-modal');
	        const background = document.getElementById('modal-background');
	        modal.style.display = 'none';
	        background.style.display = 'none';
	    }
		
	</script>
</body>
</html>
