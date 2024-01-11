<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<%
    // 獲取日期參數
    String selectedDate = request.getParameter("date");
            String selectedTimeSlot = request.getParameter("time");
    int totalReservationCount = 0;

    try {
        // 與資料庫建立連接，根據日期查詢預約人數
        Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
			Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
			//out.println("Con= "+con);
			Statement smt= con.createStatement();
			String sql = "SELECT COUNT(*) AS total FROM prescription WHERE prescription.Date = ? AND prescription.Time = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, selectedDate);
			pstmt.setString(2, selectedTimeSlot);
			ResultSet XX = pstmt.executeQuery();  

        if (XX.next()) {
            totalReservationCount = XX.getInt("total");
        }

        pstmt.close();
        XX.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 將預約人數回傳給前端
    response.getWriter().write(String.valueOf(totalReservationCount));
%>
