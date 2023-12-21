<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*, java.util.*"%>
<jsp:useBean id='objDBConfig' scope='application' class='hitstd.group.tool.database.DBConfig' />

<%

    String action = request.getParameter("action");
    String id = request.getParameter("PID");

    if ("設定".equals(action) || "刪除".equals(action)) {
        // 處理設定和刪除
        try {
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
            Statement smt = con.createStatement();

            if ("設定".equals(action)) {
                // 處理設定
                smt.execute("UPDATE member SET CK='1' WHERE id='" + id + "'");
            } else if ("刪除".equals(action)) {
                // 處理刪除
                smt.execute("UPDATE member SET CK='0' WHERE id='" + id + "'");
            }

            con.close();
            out.println("<script>alert('操作成功！！'); window.location='setpermissions.jsp'</script>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('操作失敗，請再次輸入！！'); window.location='setpermissions.jsp'</script>");
        }
    }

%>

