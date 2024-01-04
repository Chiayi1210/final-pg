<!doctype html>
<html lang="en">
 <%@ page import="java.sql.*"%>
 <%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
 <%@ page import="java.io.*,java.util.*" %>
 <%@ page import="tool.mail.JavaMail" %>
 <head>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />  
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            border: none;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
    </style>
  </head>
 
  <%  
	  Object customer = session.getAttribute("email");  
	  Object storedCode = session.getAttribute("code1");  
  %>
  <body>
   <div class="container">
        <div class="card mx-auto w-50">
            <div class="card-body">
                <h2 class="card-title text-center mb-4">註冊</h2>
                <form action="memberVC.jsp" method="post" id="myForm">
                    <div class="form-group">
                        <label for="email">信箱:</label>
                        <div class="input-group">
                        <input type="email" class="form-control" id="email" name="email" <%if (customer !=null) {out.println("value="+customer);}%> required>
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit" id="allBtn">取得驗證碼</button>
                        </div>
                    </div>
                    </div>
                    <div class="form-group">
                        <label for="verificationCode">驗證碼:</label>
                            <input type="text" class="form-control" id="verificationCode" name="verificationCode">
                            
                    </div>
                    <div class="form-group">
                        <button type="button" onclick="checkForm()"  class="btn btn-success btn-block">送出</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
	</body>
	<script>
	//function checkForm(){
	 // const VerificationCode = document.getElementById('verificationCode').value;		
	
	  // 進行驗證碼的比對
	  //if (VerificationCode === correctCaptcha) {
		 // alert('驗證成功');
	 // } else {
	   //   alert('驗證錯誤');
	  //}
	// }
	</script>
	<script>
	// 每 60 秒刷新一次session（刷新秒數照session設定秒數去改，確認驗證碼有沒有過期）
	    //setInterval(function() {
	    	//<% if (customer != null) {%>
	        	//alert("驗證碼已過期，請重新取得")
	            //location.reload();
	        //<% }%>
	    //}, 60000);
	</script>
	</html>