<!-- DeleteIM -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<%@page import="java.sql.Statement"%>
    <%@include file ="menu.jsp" %>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />

 <%
    String id = request.getParameter("id"); // 獲取從前端傳遞的 id 參數
    String cnumber1 = request.getParameter("cnumber1");
	Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
    Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
    Statement smt= con.createStatement();
	
	
    
    
    try {
        con.setAutoCommit(false); // 啟動事務
        // 執行 SQL 刪除語句
        int row = smt.executeUpdate("DELETE FROM prescription WHERE id='" + id + "' AND cnumber1='" + cnumber1 + "'");
        // 其餘代碼...

        if (row > 0) {
            // 提交事務
            con.commit();
        } else {
            // 還原事務（不提交）
            con.rollback();
        }
    } catch (Exception e) {
        // 還原事務（不提交）
        con.rollback();
        // 其餘錯誤處理代碼...
    } finally {
        con.setAutoCommit(true); // 恢復自動提交
    }
    
    %>