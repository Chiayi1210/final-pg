<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="tool.mail.JavaMail" %>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />

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

String appointmentId = request.getParameter("appointmentId");

if (appointmentId != null && !appointmentId.isEmpty()) {
    try {
        // 使用 JDBC 連接到資料庫，執行 DELETE 操作
        smt.executeUpdate("DELETE FROM prescription WHERE cnumber1='" + appointmentId + "'");
        // 刪除成功的處理
        out.println("<script>alert('預約已取消，提醒已發您的電子信箱!'); window.location='Homepage-e.jsp';</script>");
       
        // 發送取消預約通知郵件
        try {
            String name = request.getParameter("name");
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            String customer =(String) session.getAttribute("memberid");
            
            JavaMail mail = new JavaMail();   
            mail.setCustomer(customer);
            
            //信件標題
            mail.setSubject("慢箋預約取消通知");
            
            // 构造邮件内容
            StringBuilder mailContent = new StringBuilder();
            mailContent.append("<table style=\"margin: 0 auto;\">");
            mailContent.append("<tr><td height=\"200px\" align='center' valign='middle'><p>")
                        .append(name).append("，您好!<br>");
            mailContent.append("您的慢箋預約已取消，以下為您取消的預約資料<br>")
                        .append("慢箋號碼:<b>").append(appointmentId).append("<br>")
                        .append(date).append("<br>").append(time).append("</b>")
                        .append("<br>有任何問題歡迎致電(02)1234-5678</p><br></td></tr>");
            mailContent.append("</table>");

            mail.setTxt(mailContent.toString());
            
            session.setAttribute("email", customer);
            mail.SendMail();  
            response.sendRedirect("Cancel.jsp");
        } catch(Exception e) {
            e.printStackTrace(new PrintWriter(out));
        }
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
