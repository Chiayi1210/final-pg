<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<%
    // 獲取日期參數
    String selectedDate = request.getParameter("date");
    int totalReservationCount = 0;

    try {
        // 與資料庫建立連接，根據日期查詢預約人數
        Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
        Connection con = DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
        String sql = "SELECT Count(time之筆數) AS total FROM prescription WHERE prescription.Date = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, selectedDate);
        ResultSet resultSet = pstmt.executeQuery();

        if (resultSet.next()) {
            totalReservationCount = resultSet.getInt("total");
        }

        pstmt.close();
        resultSet.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 將預約人數回傳給前端
    response.getWriter().write(String.valueOf(totalReservationCount));
%>
