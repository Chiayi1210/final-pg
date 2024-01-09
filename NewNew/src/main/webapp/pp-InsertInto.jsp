 <%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<%@ page import="tool.mail.JavaMail" %>
<html>
<body>
	<%	
	Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
	Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
	Statement smt= con.createStatement
			(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	String name = request.getParameter("name");
	String id = request.getParameter("numberid");
	String phone =new String(request.getParameter("phone"));
	String memberid =new String(request.getParameter("memberid"));
	String date =request.getParameter("date");
	String time =request.getParameter("time");
	String cnumber1 =request.getParameter("cnumber1");
	String cnumber2 =request.getParameter("cnumber2");
	String cnumber3 =request.getParameter("cnumber3");
	
	
	smt.executeUpdate("UPDATE member SET name='" + name+"' , phone='" + phone+"' , memberid ='"+ memberid+"' WHERE id='"+session.getAttribute("numberid")+"'");
	
	//if(request !=null){
	//String sql;
	//sql="INSERT INTO member VALUES('"+memberid+"','"+memberpwd+"')";
	
if ((cnumber1 != null && !cnumber1.trim().isEmpty()) ||
    (cnumber2 != null && !cnumber2.trim().isEmpty()) ||
    (cnumber3 != null && !cnumber3.trim().isEmpty())) {
    
    // 在這裡進行寫入資料庫的操作
    if (cnumber1 != null && !cnumber1.trim().isEmpty()) {
        smt.execute("INSERT INTO prescription (name, id, phone, email, date, time, cnumber1) VALUES(N'" + name + "','" + session.getAttribute("numberid") + "','" + phone + "','" + memberid + "','" + date + "','" + time + "','" + cnumber1 + "')");
      
    }

    if (cnumber2 != null && !cnumber2.trim().isEmpty()) {
        smt.execute("INSERT INTO prescription (name, id, phone, email, date, time, cnumber1) VALUES('" + name + "','" + session.getAttribute("numberid") + "','" + phone + "','" + memberid + "','" + date + "','" + time + "','" + cnumber2 + "')");
    }

    if (cnumber3 != null && !cnumber3.trim().isEmpty()) {
        smt.execute("INSERT INTO prescription (name, id, phone, email, date, time, cnumber1) VALUES('" + name + "','" + session.getAttribute("numberid") + "','" + phone + "','" + memberid + "','" + date + "','" + time + "','" + cnumber3 + "')");
    }

    con.close();
    try{
  	     String customer = request.getParameter("memberid");
  	     //String code1 = String.format("%06d", new Random().nextInt(1000000));// 驗證碼6碼生成的程式碼
  	     
  	     JavaMail mail = new JavaMail();   
  	     mail.setCustomer(customer);
           //信件標題
  	     mail.setSubject("慢箋預約成功!!");
           //信件內文樣式(沒圖片版)
  	     mail.setTxt( "<table style=\"margin: 0 auto;\">"+
   		        "<tr><td height=\"200px\" align='center' valign='middle'><H2>"+ name+"，您好<br>慢箋號碼："+cnumber1+"</H2><br><a>您的慢箋預約成功，以下為您預約的日期及時間<br>"+date+"<br>"+time+"<br>記得攜帶健保卡至藥局領藥喔!<br>有任何問題歡迎致電(02)1234-5678</a><br></td></tr>"+
   		    	"</table>");
  	   //信件內文樣式(有圖片版)
//   	     mail.setTxt( "<table style=\"margin: 0 auto;\">"+
//    		        "<tr><td><p><img src=\"cid:image\"></p><hr></td></tr>"+
//    		        "<tr><td height=\"200px\" align='center' valign='middle'><H1>驗證碼："+code1+"</H1><br></td></tr>"+
//    		    	"</table>");
  	     //設置session     
  	       //session.setMaxInactiveInterval(60);   // 設置 Session 過期時間為 60 秒
  	       
  	       session.setAttribute("email", customer);
  	       mail.SendMail();  
  	       response.sendRedirect("success.jsp");
  	     	  
  	   }catch(Exception e){
  	      e.printStackTrace(new PrintWriter(out));
  	   }
    //response.sendRedirect("success.jsp");
} else {
    out.println("<script>alert('預約失敗，請重新預約'); window.location.href='prescription.jsp'</script>");
}
	
	


	
	
		//con.close();
	//out.println("<script>alert('已有預約，請至我的預約查看'); window.location.href='prescription.jsp'</script>");}
	 %>
 
</body>
</html>