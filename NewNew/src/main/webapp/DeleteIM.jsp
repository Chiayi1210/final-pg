<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
    <%@include file ="menu.jsp" %>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />

 <%
    String id = request.getParameter("id"); // 獲取從前端傳遞的 id 參數
    String cnumber1 = request.getParameter("cnumber1");
	Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
    Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
    Statement smt= con.createStatement
	(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	
    
    
    try {
        // 使用 JDBC 連接到資料庫，執行 DELETE 操作
        // ...
       smt.executeUpdate("DELETE FROM prescription WHERE id='" + id + "' AND cnumber1='" + cnumber1 + "'");
        // 刪除成功的處理
        out.println("<script>alert('預約已取消'); window.location='Homepage-e.jsp';</script>");
    } catch (Exception e) {
        // 刪除失敗的處理
        out.println("<script>alert('發生錯誤!!!'); window.location='Homepage-e.jsp';</script>");
    }
    
    
	%>