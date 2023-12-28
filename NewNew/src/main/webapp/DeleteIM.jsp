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
        int row = smt.executeUpdate("DELETE FROM prescription WHERE id='" + id + "' AND cnumber1='" + cnumber1 + "'");
        
        if (row > 0) {
            // 返回成功信息
            out.println("資料已成功刪除");
        } else {
            // 返回失敗信息
            out.println("刪除失敗");
        }
    } catch (Exception e) {
        // 返回錯誤信息
        out.println("刪除時發生錯誤：" + e.getMessage());
    }
   
	%>