<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<!-- 後台預約寫入 -->
<html>
<body>
	<%	
	Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
	Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
	Statement smt= con.createStatement
			(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	String name = request.getParameter("name");
	String id = request.getParameter("numberid");
	String phone =request.getParameter("phone");
	String memberid =request.getParameter("memberid");
	String date =request.getParameter("date");
	String time =request.getParameter("time");
	String cnumber1 =request.getParameter("cnumber1");
	String cnumber2 =request.getParameter("cnumber2");
	String cnumber3 =request.getParameter("cnumber3");
	
	//smt.executeUpdate("UPDATE member SET name='" + name+"' , phone='" + phone+"' , memberid ='"+ memberid+"' WHERE id='"+session.getAttribute("numberid")+"'");
	
	//if(request !=null){
	//String sql;
	//sql="INSERT INTO member VALUES('"+memberid+"','"+memberpwd+"')";
	
	if ((cnumber1 != null && !cnumber1.trim().isEmpty()) ||
    (cnumber2 != null && !cnumber2.trim().isEmpty()) ||
    (cnumber3 != null && !cnumber3.trim().isEmpty())) {
		
		  
	    // 在這裡進行寫入資料庫的操作
	    if (cnumber1 != null && !cnumber1.trim().isEmpty()) {
	        smt.execute("INSERT INTO prescription (name, id, phone, email, date, time, cnumber1) VALUES('" + name + "','" + id + "','" + phone + "','" + memberid + "','" + date + "','" + time + "','" + cnumber1 + "')");
	    }

	    if (cnumber2 != null && !cnumber2.trim().isEmpty()) {
	        smt.execute("INSERT INTO prescription (name, id, phone, email, date, time, cnumber1) VALUES('" + name + "','" + id + "','" + phone + "','" + memberid + "','" + date + "','" + time + "','" + cnumber2 + "')");
	    }

	    if (cnumber3 != null && !cnumber3.trim().isEmpty()) {
	        smt.execute("INSERT INTO prescription (name, id, phone, email, date, time, cnumber1) VALUES('" + name + "','" + id + "','" + phone + "','" + memberid + "','" + date + "','" + time + "','" + cnumber3 + "')");
	    }

	    con.close();
	response.sendRedirect("prescription-Imformation.jsp");
	}
	else {out.println("<script>alert('已有預約，請至我的預約查看'); window.location.href='Homepage-e.jsp'</script>");}
	
		//con.close();
	//out.println("<script>alert('已有預約，請至我的預約查看'); window.location.href='prescription.jsp'</script>");}
	 %>
 
</body>
</html>