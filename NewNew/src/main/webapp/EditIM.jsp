<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />

<%
    // 這部分程式碼負責更新資料庫中的資料
    try {
        Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
        Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");

        // 使用 PreparedStatement 防範 SQL 注入攻擊
        String updateSql = "UPDATE prescription SET date = ?, time = ? WHERE id = ? AND cnumber1 = ?";
        try (PreparedStatement pstmt = con.prepareStatement(updateSql)) {
            // 從 request 中取得參數
            String newId = request.getParameter("newid");
            String newCnumber1 = request.getParameter("newcnumber1");
            String newDate = request.getParameter("newdate");
            String newTime = request.getParameter("newtime");

            // 設定 PreparedStatement 的參數
            pstmt.setString(1, newDate);
            pstmt.setString(2, newTime);
            pstmt.setString(3, newId);
            pstmt.setString(4, newCnumber1);

            // 執行更新
            int rowsUpdated = pstmt.executeUpdate();

            // 檢查是否有成功更新資料
            if (rowsUpdated > 0) {
                out.println("<script>alert('資料更改成功!!'); window.location='prescription-Imformation.jsp';</script>");
                
            } else {
                out.println("<script>alert('更新失敗!!!'); window.location='prescription-Imformation.jsp';</script>");
                
            }
        }

        // 關閉資源
        con.close();
    } catch (Exception e) {
        out.println("發生錯誤：" + e.getMessage());
        e.printStackTrace();
    }
%>
