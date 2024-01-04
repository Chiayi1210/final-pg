<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.util.*, com.oreilly.servlet.MultipartRequest"%>
<jsp:useBean id='objFolderConfig' scope='session' class='hitstd.group.tool.upload.FolderConfig' />
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />

<%
try {
    MultipartRequest theMultipartRequest = new MultipartRequest(request, objFolderConfig.FilePath(), 1024 * 1024 * 1024);
    Enumeration theEnumeration = theMultipartRequest.getFileNames();

    if (theEnumeration.hasMoreElements()) {
        String fieldName = (String) theEnumeration.nextElement();
        String fileName = theMultipartRequest.getFilesystemName(fieldName);
        String contentType = theMultipartRequest.getContentType(fieldName);

        File theFile = theMultipartRequest.getFile(fieldName);

        out.println("檔案名稱:" + fileName + "<br>");
        out.println("檔案型態:" + contentType + "<br>");
        out.println("檔案路徑:" + theFile.getAbsolutePath() + "<br>");

        if (fileName != null) {
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            try (Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
                 Statement smt = con.createStatement()) {

                String updateQuery = "UPDATE member SET pic ='" + objFolderConfig.WebsiteRelativeFilePath() + fileName + "' WHERE id ='" + session.getAttribute("numberid") + "'";
                out.println("Update Query: " + updateQuery + "<br>");

                int rowsUpdated = smt.executeUpdate(updateQuery);

                if (rowsUpdated > 0) {
                    response.sendRedirect("member-profile.jsp?numberid=" + session.getAttribute("numberid"));
                } else {
                    out.println("Database update failed.");
                }
            }
        } else {
            out.println("No file uploaded.");
        }
    }
} catch (Exception e) {
    out.println("Error: " + e.getMessage() + "<br>");
    e.printStackTrace(new PrintWriter(out));
}
%>