<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.util.*"%>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<%@ page import="tool.mail.JavaMail" %>

<%
    // 獲取日期參數
    String selectedDate = request.getParameter("date");

    // 在這裡使用適當的數據庫連接代碼
    // 执行查询，獲取每個時段的預約數
    // 這裡的 reservationCounts 是一個包含時間和對應預約數的JSON對象
    // 例如: { "9:30-10:00": 5, "10:00-10:30": 3, ... }

    // 將 reservationCounts 轉換為JSON字符串
    String reservationCountsJson = "{ \"9:30-10:00\": 5, \"10:00-10:30\": 3 }"; // 替換為實際數據

    // 將JSON字符串發送回客戶端
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(reservationCountsJson);
%>