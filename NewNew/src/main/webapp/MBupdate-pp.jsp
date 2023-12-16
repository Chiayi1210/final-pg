<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>

<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>修改資料</title>
  
</head>
<body>
<%
Connection con = null;
Statement smt = null;

try {
    Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
    con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
    smt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

    String name = new String(request.getParameter("membername").getBytes("ISO-8859-1"));
    String id = request.getParameter("numberid");
    String phone = new String(request.getParameter("phone"));
    String memberid = new String(request.getParameter("email"));
    String memberpwd = new String(request.getParameter("memberpwd"));

    // 使用 PreparedStatement 防止 SQL 注入
    String updateQuery = "UPDATE member SET name=?, phone=?, memberid=?, memberpwd=? WHERE id=?";
    try (PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
        pstmt.setString(1, name);
        pstmt.setString(2, phone);
        pstmt.setString(3, memberid);
        pstmt.setString(4, memberpwd);
        pstmt.setString(5, (String) session.getAttribute("numberid"));
        pstmt.executeUpdate();
    }

    out.println("<script>alert('資料修改成功!!'); window.location='member-profile.jsp' </script>");
} catch (Exception e) {
    e.printStackTrace();
} finally {
    // 关闭资源
    try {
        if (smt != null) smt.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
</body>
</html>