<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<jsp:useBean id='fileUploadHelper' class='fileUploadHelper.FileUploadHelper' scope='page'/>
<jsp:useBean id='objFolderConfig' scope='session' class='hitstd.group.tool.upload.FolderConfig' />

<%
try {
    // 創建 DiskFileItemFactory 和 ServletFileUpload
    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);

    // 解析 request
    List<FileItem> items = upload.parseRequest((javax.servlet.http.HttpServletRequest) request);

    for (FileItem item : items) {
        if (!item.isFormField() && "theFirstFile".equals(item.getFieldName())) {
            // 將 FileItem 轉換為 Part
            Part part = new FileItemToPart(item);

            String fileName = fileUploadHelper.getFileName(part);
            String contentType = item.getContentType();

            // 處理檔案上傳
            String uploadPath = objFolderConfig.FilePath() + File.separator + fileName;
            item.write(new File(uploadPath));

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
} catch (FileUploadException e) {
    out.println("File upload failed.");
    e.printStackTrace(new PrintWriter(out));
} catch (Exception e) {
    out.println("Error: " + e.getMessage() + "<br>");
    e.printStackTrace(new PrintWriter(out));
}


%>
