<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page import="java.io.*" %>
<%@ page import="fileItemToPart.FileItemToPart" %>
<%@ page import="fileUploadHelper.FileUploadHelper" %>

<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<jsp:useBean id="fileUploadHelper" class="fileUploadHelper.FileUploadHelper" scope="page" />
<jsp:useBean id='objFolderConfig' scope='session' class='hitstd.group.tool.upload.FolderConfig' />

<%
try {
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // 解析 request
        List<Part> parts = (List<Part>) request.getParts();

        for (Part part : parts) {
            if ("theFirstFile".equals(part.getName())) {
                // 將 Part 轉換為 FileItemToPart
                Part filePart = part;
                FileItemToPart fileItem = new FileItemToPart(filePart);

                String fileName = FileUploadHelper.getFileName(filePart);

                String contentType = filePart.getContentType();

                // 處理文件上傳
                String uploadPath = objFolderConfig.FilePath() + File.separator + fileName;
                try (InputStream input = fileItem.getInputStream();
                     OutputStream output = new FileOutputStream(new File(uploadPath))) {
                    byte[] buffer = new byte[1024];
                    int length;
                    while ((length = input.read(buffer)) > 0) {
                        output.write(buffer, 0, length);
                    }
                }

                // 更新資料庫
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                try (
                        Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
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
            }
        }
    }
} catch (Exception e) {
    out.println("Error: " + e.getMessage() + "<br>");
    e.printStackTrace(new PrintWriter(out));
}
%>
