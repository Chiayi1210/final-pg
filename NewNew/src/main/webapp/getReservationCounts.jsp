<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="tool.mail.JavaMail" %>
<%@ page import="Reservation.ReservationBean" %>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />


<%
    String selectedDate = request.getParameter("date");
    String selectedTime = request.getParameter("time");
    int reservationCount = 0;

    // 連接資料庫，執行SQL查詢
    try (Connection connection = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";")) {
        String sql = "SELECT COUNT(*) AS total FROM reservation WHERE prescription.Date = ? AND prescription.Time = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, selectedDate);
            pstmt.setString(2, selectedTime);
            ResultSet resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                reservationCount = resultSet.getInt("total");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // 將預約人數回傳給前端
    out.print(reservationCount);
%>