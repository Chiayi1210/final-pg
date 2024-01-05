<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<jsp:useBean id='objFolderConfig' scope='session' class='hitstd.group.tool.upload.FolderConfig' />


<%
 MultipartRequest theMultipartRequest = new MultipartRequest (request,objFolderConfig.FilePath(),1024S*1024*1024) ;
 Enumeration theEnumeration = theMultipartRequest.getFileNames() ;
 while (theEnumeration.hasMoreElements()){
 String fieldName = (String)theEnumeration.nextElement () ;
 String fileName =theMultipartRequest.getFilesystemName (fieldName);
 String contentType = theMultipartRequest.getContentType (fieldName) ;
 
 File theFile = theMultipartRequest.getFile(fieldName) ;
   out.println("檔案名稱:"+fileName+"<br>") ;
   out.println("檔案型態:"+contentType+"<br>");
   out.println("檔案路徑:"+theFile.getAbsolutePath()+"<br>") ;
   Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
   Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
   Statement smt= con.createStatement();
   smt.executeUpdate("UPDATE member SET pic ='"+ objFolderConfig.WebsiteRelativeFilePath()+fileName+ "' WHERE id ='" + session.getAttribute("numberid")+"' ");
   response.sendRedirect("member-profile.jsp?numberid="+ session.getAttribute("numberid")+"");
 }  


<%
try {
    if (!request.getParts().isEmpty()) {
    	Collection<Part> parts = request.getParts();
    for (Part part : parts) {
        if ("theFirstFile".equals(part.getName()) && part.getSize() > 0) {
            String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
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
    }
}
 catch (Exception e) {
    out.println("Error: " + e.getMessage() + "<br>");
    e.printStackTrace(new PrintWriter(out));
}

%>