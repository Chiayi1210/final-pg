<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--連續處方簽預約網頁 prescription.jsp-->
<%@page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@include file ="menu.jsp" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="tool.mail.JavaMail" %>
<%@ page import="Reservation.ReservationBean" %>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<html>
<head>

</head>
<body>
<title>慢性病連續處方笺預約| 北護智慧藥局線上預約平台</title>
<%if (session.getAttribute("access") == "y"){%>
<style>
form {border: 0px solid #f1f1f1}    

input[type=text], input[type=password] {
  width: auto;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  box-sizing: border-box;
}

input[type=submit] {
  background-color: #00c6a9;
  color:white;
  width: 30%;
  padding: 14px 20px;
  margin: 8px 0;
  display: inline-block;
  border: none;
}


button {
  background-color: #00c6a9;
  color: white;
  padding: 6px 0px;
    padding-top: 6px;
    padding-right: 0px;
    padding-bottom: 3px;
    padding-left: 0px;
    border-radius: 3px;
  margin: 0px 0px 10px;
  border: 1px solid #00c6a9;
  cursor: pointer;
  width: 50%;
  font-size: 16px;
  font-weight: 300;
   -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
  text-align: center;
  display: flex;    
  align-items: center;
  box-sizing: border-box;
     height: 45px;
    
}
 
 .button:active {
    background-color: #fff;
  transition: all 0.2s ease-in-out 0s;
    transition-behavior: normal;
    transition-duration: 0.2s;
    transition-timing-function: ease-in-out;
    transition-delay: 0s;
    transition-property: all;}

button-1 {
  background-color: #00c6a9;
  color: white;
  padding: 5px 5px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 10%;
  
}

button:hover {
  opacity: 0.8;
}

.signbtn {
  width: auto;
  color:white;
  padding: 10px 18px;
  background-color: #00c6a9;
}

.imgcontainer {
  text-align: center;
  margin: 24px 0 12px 0;
}

img.avatar {
  width: 70%;
  border-radius: 50%;
}

.container {
  padding: 16px;
}

span.psw {
  float: center;
  padding-top: 50px;
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .signbtn {
     width: 50%;
  }
}

#window-container{
    display: none;
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
}
       
#window-pop{
    background: white;
    width:75%;
    z-index: 1;
    margin: 3em;;
    overflow: visible;
    border-radius: 10px;
}
        
.window-content {
    width: 70%;
    height: 480px;
    line-height: 200px
    overflow : visible;
    text-align: center;
 
  }

span {
    display: inline-block;
    vertical-align: middle;
    line-height: normal;
}


.buttonSS {
    padding: 6px 0px;
    padding-top: 6px;
    padding-right: 0px;
    padding-bottom: 6px;
    padding-left: 0px;
    border-radius: 3px;
    cursor: pointer;
    font-weight: 300;
    text-align: center;
    transition: all 0.2s ease-in-out 0s;
    transition-behavior: normal;
    transition-duration: 0.2s;
    transition-timing-function: ease-in-out;
    transition-delay: 0s;
    transition-property: all;
    display: flex;
    -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    align-items: center;
    font-size: 16px;
    box-sizing: border-box;
    width: 100%;
    margin: 0px 0px 10px;
    height: 45px;
    border: 1px solid #00c6a9;
    background: #00c6a9;
    color: rgb(255, 255, 255);}
    
.button:active{
background-color:#fff;
 color: #fff;
}

</style>

<center> <br><h1>預約資料登記</h1>
<form action="pp-InsertInto.jsp" method="post">
		<div>
		  <table style="border:2px #ccc solid" width="40%">
		  <td><label for="nmembername" >&nbsp;&nbsp;&nbsp;&nbsp;姓名：</label><br><br> 
               <label for="numberid">&nbsp;&nbsp;&nbsp;&nbsp;身分證字號：</label><br><br> 
              <label for="memberphone"  >&nbsp;&nbsp;&nbsp;&nbsp;電話號碼：</label><br><br> 
              <label for="memberid">&nbsp;&nbsp;&nbsp;&nbsp;E-mail：</label>
          </td>
          <!--  value="<%out.print(session.getAttribute("accessname"));%>"-->
          <td>
          <input type="text" name="name" value="<%out.print(session.getAttribute("membername"));%>" ><br>  
          <input type="text" name="numberid" value="<%out.print(session.getAttribute("numberid"));%>"  readonly="true"><br>  
          <input type="text" name="phone" value="<%out.print(session.getAttribute("memberphone"));%>" ><br> 
          <input type="text" name="memberid" value="<%out.print(session.getAttribute("email"));%>" >
          </td>
         </table>
   </div>
		
			<% 
                    String selectedDate = request.getParameter("date");
		            String selectedTimeSlot = request.getParameter("time");
					Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
					Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
					//out.println("Con= "+con);
					Statement smt= con.createStatement();
					String sql = "SELECT COUNT(*) AS total FROM prescription WHERE prescription.Date = ? AND prescription.Time = ?";
					PreparedStatement pstmt = con.prepareStatement(sql);
					pstmt.setString(1, selectedDate);
					pstmt.setString(2, selectedTimeSlot);
					ResultSet XX = pstmt.executeQuery();
	             %>
	
<br><label for='massage'>選擇預約日期：</label>
<input type="date" name="date" id="appointmentDate" required min="<%= LocalDate.now() %>">
<br><br><label>選擇預約時間：<input type="text" id="demo" name="time" value="" readonly="readonly"  min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"></label>
       <br>目前已預約<%
if (XX.next()) {
    out.print(XX.getString("total"));}%>人 <br><br>
    </center>
     
                 
    <center>
    <table width="70%"><tr>
    <td width="auto" align="center">
    <button type="button" id="time" class="button" onclick='document.getElementById("demo").value = "9:30-10:00" '  required for="time"  data-time="9:30-10:00">
        9:30-10:00</button> 
    
</td>
    <td  width="auto" align="center"><button type="button" onclick='document.getElementById("demo").value = "10:00-10:30" ' required for="time" >10:00-10:30</button>
    </td>
    <td width="auto"align="center"><button type="button" onclick='document.getElementById("demo").value = "10:30-11:00"'required  for="time" >10:30-11:00</button>
    </td>
    <td width="auto"align="center"><button type="button" onclick='document.getElementById("demo").value = "11:30-12:00"' required  for="time" >11:30-12:00</button>
    </td></tr>
  <tr>
    <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "12:00-12:30"' required  for="time" >12:00-12:30</button>
    </td>
    <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "13:00-13:30"' required for="time" >13:00-13:30</button>
   </td>
    <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "13:30-14:00"' required  for="time" >13:30-14:00</button>
    </td>
    <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value= "14:30-15:00"' required  for="time" >14:30-15:00</button>
    </td>     
  </tr>
  <tr>
    <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "15:30-16:00"' required  for="time" >15:30-16:00</button>
    </td>
    <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "16:30-17:00"' required  for="time" >16:30-17:00</button>
    </td>
    <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "17:30-18:00"' required  for="time" >17:30-18:00</button>
   </td>
      <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "18:00-18:30"' required  for="time" >18:00-18:30</button>
   </td>     
   </tr>
    <tr><td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "19:00-19:30"' required  for="time" >19:00-19:30</button>
   </td>
   <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "19:30-20:00"' required  for="time" >19:30-20:00</button>
  </td>
   <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "20:30-21:00"' required  for="time" >20:30-21:00</button>
   </td>
    <td width="200"align="center"><button type="button" onclick='document.getElementById("demo").value = "21:00-21:30"' required  for="time" >21:00-21:30</button>
    </td>  
    </tr></table>
    <%! // Declaration section
    int getReservationCount(ResultSet resultSet, String date, String timeSlot) throws SQLException {
        while (resultSet.next()) {
            String reservationDate = resultSet.getString("Date");
            String reservationTime = resultSet.getString("Time");
            int count = resultSet.getInt("time之筆數");

            if (reservationDate.equals(date) && reservationTime.equals(timeSlot)) {
                return count;
            }
        }
        return 0; // 若找不到對應日期和時間的預約人數，預設為0
    }
%>

    
			<br> <label for="cnumber1">慢性病卡號1：</label> <input type="text"
				name="cnumber1" required><br>
			<br> <label for="cnumber2">慢性病卡號2：</label> <input type="text"
				name="cnumber2" ><br>
			<br> <label for="cnumber3">慢性病卡號3：</label> <input type="text"
				name="cnumber3"   ><br>
			<br>
			<button type="submit">確認</button>
	</center>
</form>
	<%}else{%>
	<%out.println("<script>alert('請先登入此系統！！'); window.location='loginCheck-Select.jsp' </script>");%>
	
	<%}%>

<script>
    var dateInput = document.getElementById('appointmentDate');
    var demoInput = document.getElementById('demo');
    var reservationCountDisplay = document.getElementById('reservationCountDisplay');

    dateInput.addEventListener('input', function() {
        // 檢查是否選擇了以前的日期
        checkPastDate();

        // 檢查星期日
        noSundays();

        // 更新時間檢查
        getReservationCount(dateInput.value, demoInput.value);

        // 使用AJAX請求獲取每個時段的預約數量
        updateReservationCounts();
    });

    function checkPastDate() {
        var selectedDate = new Date(dateInput.value);
        var currentDate = new Date();

        if (selectedDate < currentDate) {
            dateInput.setCustomValidity('不可選擇以前的日期！');
        } else {
            dateInput.setCustomValidity('');
        }
    }

    function noSundays() {
        var selectedDate = new Date(dateInput.value);
        var day = selectedDate.getUTCDay();
        if (day == 0) {
            dateInput.setCustomValidity('不可選擇週日！');
        } else {
            dateInput.setCustomValidity('');
        }
    }

    function getReservationCount(selectedDate, selectedTimeSlot) {
        // 使用AJAX請求獲取預約數量
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                updateButtons(selectedDate, JSON.parse(xhr.responseText));
            }
        };
        xhr.open("GET", "getReservationCounts.jsp?date=" + selectedDate, true);
        xhr.send();
    }


    function updateReservationCounts() {
        var selectedDate = dateInput.value;

        // 使用AJAX請求獲取每個時段的預約數量
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                // 更新顯示已預約人數的區域
                reservationCountDisplay.innerHTML = "選擇日期：" + selectedDate + "<br>目前已預約人數：" + xhr.responseText + "人";
                
                // 更新相應的按鈕，這裡假設有一個按鈕的data-time屬性為"9:30-10:00"
                updateButtonCount("9:30-10:00", xhr.responseText);
            }
        };
        xhr.open("GET", "getReservationCounts.jsp?date=" + selectedDate, true);
        xhr.send();
    }

   

    
</script>
	</html>

	
	

 