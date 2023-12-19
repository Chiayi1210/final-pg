<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<jsp:useBean id='objFolderConfig' scope='session' class='hitstd.group.tool.upload.FolderConfig' />
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />

<%
Connection con = null;

try {
    MultipartRequest theMultipartRequest = new MultipartRequest(request, objFolderConfig.FilePath(), 10 * 1024 * 1024);
    Enumeration theEnumeration = theMultipartRequest.getFileNames();

    while (theEnumeration.hasMoreElements()) {
        String fieldName = (String) theEnumeration.nextElement();
        String fileName = theMultipartRequest.getFilesystemName(fieldName);

        // Ensure fileName is not null before proceeding
        if (fileName != null) {
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
            Statement smt = con.createStatement();

            // Use PreparedStatement to prevent SQL injection
            String updateQuery = "UPDATE member SET pic = ? WHERE id = ?";
            try (PreparedStatement pstmt = con.prepareStatement(updateQuery)) {
                pstmt.setString(1, objFolderConfig.WebsiteRelativeFilePath() + fileName);
                pstmt.setString(2, (String) session.getAttribute("numberid"));
                pstmt.executeUpdate();
            }

            response.sendRedirect("member-profile.jsp?id=" + session.getAttribute("numberid"));
        } else {
            out.println("檔案上傳失敗：未選擇文件");
        }
    }
} catch (Exception e) {
    out.println("檔案上傳失敗：" + e.getMessage());
    e.printStackTrace();
} finally {
    // Close the connection in the finally block to ensure it's always closed
    try {
        if (con != null && !con.isClosed()) {
            con.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>