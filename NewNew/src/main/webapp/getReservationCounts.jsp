<%@ page import="java.sql.*" %>
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

//String selectedDate = request.getParameter("date");
//String selectedTime = request.getParameter("time");
//Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
//Connection con = DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
//String sql = "SELECT COUNT(*) AS total FROM prescription WHERE prescription.Date = ?";
//PreparedStatement pstmt = con.prepareStatement(sql);
//pstmt.setString(1, selectedDate);
//pstmt.setString(2, selectedTime);
//ResultSet rs = pstmt.executeQuery();

//if (rs.next()) {
  //  int reservationCount = rs.getInt("total");
  //  out.print("目前已預約人數：" + reservationCount + " 人");
//} else {
  //  out.print("目前已預約人數： 0 人"); // 如果查詢結果為空，回傳0
//}

//rs.close();
//pstmt.close();
//con.close();

%>
