<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
    <%@page import="java.io.*,java.util.*"%>
    <jsp:useBean id='objDBConfig' scope='application' class='hitstd.group.tool.database.DBConfig' />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DELETE</title>
</head>
<body>
<%
	Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
	Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
	Statement smt= con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

	
	//smt.executeUpdate("DELETE FROM prescription WHERE id='"+session.getAttribute("numberid")+"'");
	//response.sendRedirect("index2.jsp?id='"+session.getAttribute("numberid")+"");
	
	String appointmentId = request.getParameter("appointmentId");
	if (appointmentId != null && !appointmentId.isEmpty()) {
	    try {
	        // 使用 JDBC 連接到資料庫，執行 DELETE 操作
	        // ...
           smt.executeUpdate("DELETE FROM prescription WHERE cnumber1='" + appointmentId + "'");
	        // 刪除成功的處理
	        out.println("<script>alert('預約已取消'); window.location='Homepage-e.jsp';</script>");
	    } catch (Exception e) {
	        // 刪除失敗的處理
	        out.println("<script>alert('發生錯誤!!!'); window.location='Homepage-e.jsp';</script>");
	    }
	} else {
	    // 沒有提供有效的 appointmentId
	    out.println("<script>alert('請選擇要取消的預約'); window.location='Homepage-e.jsp';</script>");
	}
	
	%>



</body>
</html>