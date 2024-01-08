<!doctype html>
 <%@ page import="java.sql.*"%>
 <%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
 <%@ page import="java.io.*,java.util.*" %>
 <%@ page import="tool.mail.JavaMail" %>
    <!-- send.jsp -->
  <%
  	try{
	     String customer = request.getParameter("email");
	     String cnumber1 =request.getParameter("cnumber1");
	 	
	     //String code1 = String.format("%06d", new Random().nextInt(1000000));// 驗證碼6碼生成的程式碼
	     
	     JavaMail mail = new JavaMail();   
	     mail.setCustomer(customer);
         //信件標題
	     mail.setSubject("缺藥通知");
         //信件內文樣式(沒圖片版)
	     mail.setTxt( "<table style=\"margin: 0 auto;\">"+
 		        "<tr><td height=\"200px\" align='center' valign='middle'><H1>慢箋號碼："+cnumber1+"</H1><br><a>非常抱歉!您的藥物目前缺藥中，本次預約將取消，請重新預約!<br>有任何問題歡迎致電(02)1234-5678</a><br></td></tr>"+
 		    	"</table>");
	   //信件內文樣式(有圖片版)
// 	     mail.setTxt( "<table style=\"margin: 0 auto;\">"+
//  		        "<tr><td><p><img src=\"cid:image\"></p><hr></td></tr>"+
//  		        "<tr><td height=\"200px\" align='center' valign='middle'><H1>驗證碼："+code1+"</H1><br></td></tr>"+
//  		    	"</table>");
	     //設置session     
	       //session.setMaxInactiveInterval(60);   // 設置 Session 過期時間為 60 秒
	       
	       session.setAttribute("email", customer);
	       mail.SendMail();  
	       response.sendRedirect("prescription-Imformation.jsp");
	     	  
  	} catch (Exception e) {
        e.printStackTrace(new PrintWriter(out));
        
        // 返回 JSON 格式的錯誤訊息
        response.getWriter().write("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
    }
%>