<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<%@include file = "menu.jsp" %>
<jsp:useBean id='objDBConfig' scope='application' class='hitstd.group.tool.database.DBConfig' />
<html>
<body>
<%
	Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
	Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
	Statement smt= con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	String date =request.getParameter("date");
	String time =request.getParameter("time");
	
	String SappointmentId = request.getParameter("SappointmentId");
	if (SappointmentId != null && !SappointmentId.isEmpty()) {
	    try {
	        // 使用 JDBC 連接到資料庫，執行 DELETE 操作
	        // ...
           smt.executeUpdate("UPDATE prescription SET date=?, time=? WHERE cnumber1=?");
           PreparedStatement preparedStatement = con.prepareStatement(updateQuery);
        // 將日期和時間轉換成 java.sql.Date 和 java.sql.Time 類型
           java.sql.Date sqlDate = java.sql.Date.valueOf(date);
           java.sql.Time sqlTime = java.sql.Time.valueOf(time + ":00");
           preparedStatement.setString(3, SappointmentId);
           preparedStatement.executeUpdate();

           // 更新成功的處理
           out.println("<script>alert('預約更改成功!!'); window.location='Homepage-e.jsp';</script>");
       } catch (Exception e) {
           // 更新失敗的處理
           out.println("<script>alert('預約更改失敗!!!'); window.location='Homepage-e.jsp';</script>");
       }
   } else {
       // 沒有提供有效的 SappointmentId
       out.println("<script>alert('請選擇要更改的預約'); window.location='Homepage-e.jsp';</script>");}
	
	 con.close();
	    // 移除單引號
	    //response.sendRedirect("Inquire.jsp?id=" + session.getAttribute("numberid"));
	%>
	
	</body>
	</html>