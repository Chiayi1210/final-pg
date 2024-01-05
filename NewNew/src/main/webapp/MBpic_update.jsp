<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.Part" %>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<jsp:useBean id='fileUploadHelper' class='fileUploadHelper.FileUploadHelper' scope='page'/>
<jsp:useBean id='objFolderConfig' scope='session' class='hitstd.group.tool.upload.FolderConfig' />
<%

// 建議使用 try-with-resources 管理資源
try {
 if (!request.getParts().isEmpty()) {
     Collection<Part> parts = request.getParts();
     for (Part part : parts) {
         if ("theFirstFile".equals(part.getName()) && part.getSize() > 0) {
             String fileName = fileUploadHelper.getFileName(part);
             String contentType = part.getContentType();

             out.println("檔案名稱:" + fileName + "<br>");
             out.println("檔案型態:" + contentType + "<br>");

             // 處理檔案上傳
             String uploadPath = objFolderConfig.FilePath() + File.separator + fileName;
             part.write(uploadPath);

             // 更新資料庫
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
         }
     }
 } // 缺少這個大括號
} catch (Exception e) {
 out.println("Error: " + e.getMessage() + "<br>");
 e.printStackTrace(new PrintWriter(out));
}


%>