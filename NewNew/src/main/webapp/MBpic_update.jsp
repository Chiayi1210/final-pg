<!-- 會員資料更新程式 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<jsp:useBean id='objDBConfig' scope='application' class='hitstd.group.tool.database.DBConfig' />
<html>
<body>
<%
try {
    MultipartRequest theMultipartRequest = new MultipartRequest(request, objFolderConfig.FilePath(), 10 * 1024 * 1024);
    Enumeration theEnumeration = theMultipartRequest.getFileNames();
    while (theEnumeration.hasMoreElements()) {
        String fieldName = (String) theEnumeration.nextElement();
        String fileName = theMultipartRequest.getFilesystemName(fieldName);
        String contentType = theMultipartRequest.getContentType(fieldName);

        Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
        Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
        Statement smt = con.createStatement();
        smt.executeUpdate("UPDATE leelab SET pic ='" + objFolderConfig.WebsiteRelativeFilePath() + fileName + "' WHERE memberId ='" + session.getAttribute("accessId") + "' ");
        response.sendRedirect("member.jsp?memberId=" + session.getAttribute("accessId"));
    }
} catch (Exception e) {
    e.printStackTrace();
    out.println("文件上传和数据库更新失败：" + e.getMessage());
}
%>
</body>
</html>