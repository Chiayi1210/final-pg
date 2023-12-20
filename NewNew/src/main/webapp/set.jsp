<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*, java.util.*"%>
<jsp:useBean id='objDBConfig' scope='application' class='hitstd.group.tool.database.DBConfig' />
<html>
<body>
<%
try {
    Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
    Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
    Statement smt = con.createStatement();

    String id = request.getParameter("PID");
    String action = request.getParameter("action");

    if (id != null && !id.isEmpty() && action != null && !action.isEmpty()) {
        if ("1".equals(action)) {
            // 假設 '1' 代表設定權限
            smt.executeUpdate("UPDATE member SET CK = '1' WHERE id = '" + id + "'");
            out.println("<script>alert('權限設定成功！！'); window.location.href='loginCheck-Select.jsp'</script>");
        } else if ("0".equals(action)) {
            // 假設 '0' 代表刪除權限
            smt.executeUpdate("UPDATE member SET CK = '0' WHERE id = '" + id + "'");
            out.println("<script>alert('權限刪除成功！！'); window.location.href='loginCheck-Select.jsp'</script>");
        }
    }
    con.close();
} catch (Exception e) {
    e.printStackTrace();
    out.println("發生錯誤：" + e.getMessage());
}
%>
</body>
</html>