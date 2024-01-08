<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page import="java.io.*" %>
<%@ page import="fileItemToPart.FileItemToPart" %>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<jsp:useBean id='fileUploadHelper' class='fileUploadHelper.FileUploadHelper' scope='page'/>
<jsp:useBean id='objFolderConfig' scope='session' class='hitstd.group.tool.upload.FolderConfig' />
<!-- MBpic_update.jsp -->
<%
try {
    // 解析 request
    List<Part> parts = (List<Part>) request.getParts();

    for (Part part : parts) {
        if ("theFirstFile".equals(part.getName())) {
            // 将 Part 转换为 FileItem
            FileItem fileItem = new FileItemToPart(part);

            String fileName = fileUploadHelper.getFileName(part);
            String contentType = part.getContentType();

            // 处理文件上传
            String uploadPath = objFolderConfig.FilePath() + File.separator + fileName;
            try (InputStream input = fileItem.getInputStream();
                 OutputStream output = new FileOutputStream(new File(uploadPath))) {
                byte[] buffer = new byte[1024];
                int length;
                while ((length = input.read(buffer)) > 0) {
                    output.write(buffer, 0, length);
                }
            }

            // 更新数据库
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
} catch (Exception e) {
    out.println("Error: " + e.getMessage() + "<br>");
    e.printStackTrace(new PrintWriter(out));
}
%>
