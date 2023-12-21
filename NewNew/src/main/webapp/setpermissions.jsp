<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file ="menu.jsp" %>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<!DOCTYPE html>
<html>
<%if (session.getAttribute("access") == "y"){%>
      <style>
        form {border: 0px solid #f1f1f1}    
        
        input[type=text], input[type=password] {
          width: auto;
          padding: 12px 20px;
          margin: 8px 0;
          display: inline-block;
          box-sizing: border-box;
        }
        
        input[type=submit] {
          background-color: #00c6a9;
          color:white;
          width: 30%;
          padding: 14px 20px;
          margin: 8px 0;
          display: inline-block;
          border: none;
        }
        
        
        button2 {
          background-color: #00c6a9;
          color: white;
          padding: 14px 20px;
          margin: 8px 0;
          border: none;
          cursor: pointer;
          width: 20%;
          display: inline-block;
         
        }
        
        button-1 {
          background-color: #00c6a9;
          color: white;
          padding: 5px 5px;
          margin: 8px 0;
          border: none;
          cursor: pointer;
          width: auto;
          
        }
        
        button {
          background-color: #00c6a9;
          color: white;
          padding: 10px 100px;
          margin: 15px 0;
          border: none;
          cursor: pointer;
          width: auto;
          border-radius:10px;
          display: inline-block;
        }
         button:hover {
          opacity: 0.8;
        }
        <!--border-radius圓角-->
        
       
        
        button2:hover {
          opacity: 0.8;
        }
        
        button-1:hover {
          opacity: 0.8;
        }
        .signbtn {
          width: auto;
          color:white;
          padding: 10px 18px;
          background-color: #00c6a9;
        }
        
        .imgcontainer {
          text-align: center;
          margin: 24px 0 12px 0;
        }
        
        img.avatar {
          width: 70%;
          border-radius: 50%;
        }
        
        .container {
          padding: 16px;
        }
        
        span.psw {
          float: center;
          padding-top: 50px;
        }
        
        /* Change styles for span and cancel button on extra small screens */
        @media screen and (max-width: 300px) {
          span.psw {
             display: block;
             float: none;
          }
          .signbtn {
             width: 50%;
          }
        }
        
        #window-container{
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
               
        #window-pop{
            background: white;
            width:70%;
            z-index: 1;
            margin:  8%;
            overflow: visible;
            border-radius: 10px;
        }
                
        .window-content {
            width: auto;
            height: 500px;
            line-height: 200px
            overflow : visible;
            text-align: center;
         
          }
        
        span {
            display: inline-block;
            vertical-align: middle;
            line-height: normal;
        }
        
        </style>
<center><h1>權限設定</h1><br>
<form action="set.jsp" method="post" name="form">
       <a>請輸入身份證字號以設定員工權限</a>
      <br> <input type="text" name="PID" required>
      <br> <input type="submit" name="action" value="設定">
    <br> <input type="submit" name="action" value="刪除">
      </form>
      
<%}else{%>
<%out.println("<script>alert('請先登入此系統！！'); window.location='loginCheck-Select.jsp' </script>");}%>     
</center>

</body>
</html>