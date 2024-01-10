<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.ResultSet" %>
<%@page import="com.google.gson.Gson"%>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />

<%! // Declaration section
    int getReservationCount(ResultSet resultSet, String date, String timeSlot) throws SQLException {
        int totalCount = 0;
        while (resultSet.next()) {
            String reservationDate = resultSet.getString("Date");
            String reservationTime = resultSet.getString("Time");
            int count = resultSet.getInt("time之筆數");

            if (reservationDate.equals(date) && reservationTime.equals(timeSlot)) {
                totalCount += count;
            }
        }
        return totalCount;
    }
%>
<%
    // 獲取日期參數
    String selectedDate = request.getParameter("date");
try {
    Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
    Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
    String sql = "SELECT prescription.Date, prescription.Time, Count(prescription.Time) AS time之筆數 FROM prescription WHERE prescription.Date = ? GROUP BY prescription.Date, prescription.Time ORDER BY prescription.Time";
    
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, selectedDate);
    
    ResultSet resultSet = pstmt.executeQuery();
    
    Map<String, Integer> reservationCounts = new HashMap<>();
    while (resultSet.next()) {
        String timeSlot = resultSet.getString("Time");
        int count = resultSet.getInt("time之筆數");
        reservationCounts.put(timeSlot, count);
    }
    
    // 使用 Gson 库將 Map 轉換為 JSON 字串
    Gson gson = new Gson();
    String reservationCountsJson = gson.toJson(reservationCounts);
    
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(reservationCountsJson);
    
    pstmt.close();
    resultSet.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
    response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
}
%>