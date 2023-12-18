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
	String cnumber1 = request.getParameter("Sappointment");
	String sql1 = "SELECT * FROM prescription WHERE cnumber1='" + cnumber1 + "'";
	ResultSet rs = smt.executeQuery(sql1);
	
	if (cnumber1 != null && !cnumber1.isEmpty()) {
        try {
            // 使用 PreparedStatement 進行更新
            String updateQuery = "UPDATE prescription SET date=?, time=? WHERE cnumber1=?";
            PreparedStatement preparedStatement = con.prepareStatement(updateQuery);
            preparedStatement.setString(1, date);
            preparedStatement.setString(2, time);
            preparedStatement.setString(3, cnumber1);

            // 執行更新操作
            int rowsUpdated = preparedStatement.executeUpdate();

            // 檢查是否有行被更新
            if (rowsUpdated > 0) {
                // 更新成功的處理
                out.println("<script>alert('預約更改成功!!'); window.location='Homepage-e.jsp';</script>");
            } else {
                // 行數為0，表示沒有匹配的預約
                out.println("<script>alert('找不到匹配的預約，請檢查您的預約ID'); window.location='Homepage-e.jsp';</script>");
            }
        } catch (Exception e) {
            // 更新失敗的處理
            out.println("<script>alert('預約更改失敗!!!'); window.location='Homepage-e.jsp';</script>");
        }
    } else {
        // 沒有提供有效的 SappointmentId
        out.println("<script>alert('請選擇要更改的預約'); window.location='Homepage-e.jsp';</script>");
    }

    con.close();
%>
	
	</body>
	</html>