<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection, java.nio.file.*" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption" %>
<%@ page import="jakarta.servlet.http.Part" %>
<jsp:useBean id='objFolderConfig' scope='session' class='hitstd.group.tool.upload.FolderConfig' />
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />

<%
    Collection<Part> parts = request.getParts();

    for (Part part : parts) {
        String fileName = "";
        String contentDisposition = part.getHeader("content-disposition");

        if (contentDisposition != null) {
            String[] tokens = contentDisposition.split(";");
            for (String token : tokens) {
                if (token.trim().startsWith("filename")) {
                    fileName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                    break;
                }
            }
        }

        // 指定上傳目錄，這裡使用 Web 應用程序的根目錄
        String uploadDir = getServletContext().getRealPath("/") + "images" + File.separator;

        // 確保上傳目錄存在
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdir();
        }

        // 使用檔案名稱來構建完整的路徑
        String filePath = uploadDir + File.separator + fileName;

        // 將文件保存到指定路徑
        try (InputStream input = part.getInputStream()) {
            Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        }

        // 更新數據庫
        Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
        Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
        Statement smt = con.createStatement();
        smt.executeUpdate("UPDATE member SET pic ='" + objFolderConfig.WebsiteRelativeFilePath() + fileName + "' WHERE id ='" + session.getAttribute("numberid") + "'");
    }

    // 移出循環外部，以確保所有文件都成功上傳後再進行重定向
    response.sendRedirect("member-profile.jsp");
%>
