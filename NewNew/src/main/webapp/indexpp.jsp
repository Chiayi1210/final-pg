<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<%@include file = "menu.jsp" %>
<jsp:useBean id='objDBConfig' scope='application' class='hitstd.group.tool.database.DBConfig' />
<html>
<!-- indexpp.jsp -->
<body>
<%
Connection con = null;
Statement smt = null;

try {
    Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
    con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
    smt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

    String P1 = request.getParameter("P1");
    String P2 = request.getParameter("P2");
    String P3 = request.getParameter("P3");

    // 檢查是否有值
    if (P1 != null && !P1.isEmpty()) {
        P1 = "N'" + P1 + "'";
    } else {
        P1 = "P1"; // 如果沒有值，保持原樣
    }

    if (P2 != null && !P2.isEmpty()) {
        P2 = "'" + P2 + "'";
    } else {
        P2 = "P2"; // 如果沒有值，保持原樣
    }

    if (P3 != null && !P3.isEmpty()) {
        P3 = "'" + P3 + "'";
    } else {
        P3 = "P3"; // 如果沒有值，保持原樣
    }

    int rowsAffected = smt.executeUpdate("UPDATE indexIM SET P1= " + P1 + ", P2=" + P2 + ", P3=" + P3);

    if (rowsAffected > 0) {
        out.println("<script>alert('資料更改成功!!'); window.location='index-P.jsp';</script>");
    } else {
        out.println("<script>alert('資料更改失敗!!!'); window.location='index-P.jsp';</script>");
    }
} catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
    out.println("Update failed. Exception: " + e.getMessage());
} finally {
    try {
        if (smt != null) smt.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>