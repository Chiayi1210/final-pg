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
		  <td><label for="name">&nbsp;&nbsp;&nbsp;&nbsp;姓名：</label><br><br> 
               <label for="numberid">&nbsp;&nbsp;&nbsp;&nbsp;身分證字號：</label><br><br> 
              <label for="phone" >&nbsp;&nbsp;&nbsp;&nbsp;電話號碼：</label><br><br> 
              <label for="memberid">&nbsp;&nbsp;&nbsp;&nbsp;E-mail：</label>
          </td>
          <!--  value="<%out.print(session.getAttribute("accessname"));%>"-->
          <td>
<<<<<<< Updated upstream
          <input type="text" name="name" value="<%out.print(session.getAttribute("membername"));%>" ><br>  
          <input type="text" name="numberid" value="<%out.print(session.getAttribute("numberid"));%>"  readonly="true"><br>  
          <input type="text" name="phone" value="<%out.print(session.getAttribute("memberphone"));%>" ><br> 
          <input type="text" name="memberid" value="<%out.print(session.getAttribute("memberid"));%>" >
          </td>
         </table>
   </div>
		
	
	
<br><label for='massage'>選擇預約日期：</label>
<input type="date" name="date" id="appointmentDate" required min="<%= LocalDate.now() %>">
<br>
 
=======
          <input type="text" name="name" id="name" value="<%out.print(session.getAttribute("membername"));%>" ><br>  
          <input type="text" name="numberid" id="numberid" value="<%out.print(session.getAttribute("numberid"));%>"  readonly="true"><br>  
          <input type="text" name="phone" id="phone" value="<%out.print(session.getAttribute("memberphone"));%>" ><br> 
          <input type="text" name="memberid" id="memberid" value="<%out.print(session.getAttribute("email"));%>" >
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
					
					int reservationCount = 0;
				    if (XX.next()) {
				        reservationCount = XX.getInt("total");
				    }
	             %>
			
	
<br><label >選擇預約日期：
<input type="date" name="date" id="appointmentDate" required min="<%= LocalDate.now() %>"  onchange="getReservationCount()"></label>
<br><%= reservationCount %>
>>>>>>> Stashed changes


<br><br><label>選擇預約時間：<input type="text" id="demo" name="time" value="" readonly="readonly"  ></label>
        </center>
     
                 
    <center>
    <table width="70%"><tr>
    <td width="auto" align="center">
    <button type="button" id="time" class="button" onclick='selectTime("9:30-10:00")'  required for="time"  data-time="9:30-10:00">
        9:30-10:00</button> 
    
</td>
    <td  width="auto" align="center"><button type="button" onclick='selectTime("10:00-10:30") ' required for="time" data-time="10:00-10:30">10:00-10:30</button>
    </td>
    <td width="auto"align="center"><button type="button" onclick='selectTime("10:30-11:00")'required  for="time" data-time="10:30-11:00">10:30-11:00</button>
    </td>
    <td width="auto"align="center"><button type="button" onclick='selectTime("11:30-12:00")' required  for="time" data-time="11:30-12:00">11:30-12:00</button>
    </td></tr>
  <tr>
    <td width="200"align="center"><button type="button" onclick='selectTime("12:00-12:30")' required  for="time" data-time="12:00-12:30">12:00-12:30</button>
    </td>
    <td width="200"align="center"><button type="button" onclick='selectTime("13:00-13:30")' required for="time" data-time="13:00-13:30">13:00-13:30</button>
   </td>
    <td width="200"align="center"><button type="button" onclick='selectTime("13:30-14:00")' required  for="time" data-time="13:30-14:00">13:30-14:00</button>
    </td>
    <td width="200"align="center"><button type="button" onclick='selectTime("14:30-15:00")' required  for="time" data-time="14:30-15:00">14:30-15:00</button>
    </td>     
  </tr>
  <tr>
    <td width="200"align="center"><button type="button" onclick='selectTime("15:30-16:00")' required  for="time" data-time="15:30-16:00">15:30-16:00</button>
    </td>
    <td width="200"align="center"><button type="button" onclick='selectTime("16:30-17:00")' required  for="time" data-time="16:30-17:00">16:30-17:00</button>
    </td>
    <td width="200"align="center"><button type="button" onclick='selectTime("17:30-18:00")' required  for="time" data-time="17:30-18:00">17:30-18:00</button>
   </td>
      <td width="200"align="center"><button type="button" onclick='selectTime("18:00-18:30")' required  for="time" data-time="18:00-18:30">18:00-18:30</button>
   </td>     
   </tr>
    <tr><td width="200"align="center"><button type="button" onclick='selectTime("19:00-19:30")' required  for="time" data-time="19:00-19:30">19:00-19:30</button>
   </td>
   <td width="200"align="center"><button type="button" onclick='selectTime("19:30-20:00")' required  for="time" data-time="19:30-20:00">19:30-20:00</button>
  </td>
   <td width="200"align="center"><button type="button" onclick='selectTime("20:30-21:00")' required  for="time" data-time="20:30-21:00">20:30-21:00</button>
   </td>
    <td width="200"align="center"><button type="button" onclick='selectTime("21:00-21:30")' required  for="time" data-time="21:00-21:30">21:00-21:30</button>
    </td>  
    </tr></table>
  <script>
function getReservationCount() {
    var selectedDate = document.getElementById("appointmentDate").value;
    var selectedTime = document.getElementById("demo").value;

    // 使用XMLHttpRequest對伺服器發送請求
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            // 伺服器回傳的預約人數
            var reservationCount = xhr.responseText;
            alert("目前已預約人數：" + reservationCount + " 人");
        }
    };

    // 設定請求方法、URL以及是否為非同步請求
    xhr.open("GET", "getReservationCount.jsp?date=" + selectedDate + "&time=" + selectedTime, true);
    xhr.send();
}

// 修改時間按鈕的點擊事件
function selectTime(time) {
    document.getElementById("demo").value = time;
    getReservationCount(); // 選擇時間後直接觸發顯示預約人數的函數
}
</script>

    
			<br> <label>慢性病卡號1： <input type="text"
				name="cnumber1" required></label><br>
			<br> <label >慢性病卡號2：<input type="text"
				name="cnumber2" ></label> <br>
			<br> <label >慢性病卡號3：<input type="text"
				name="cnumber3"   ></label> <br>
			<br>
			<button type="submit">確認</button>
	</center>
</form>
	<%}else{%>
	<%out.println("<script>alert('請先登入此系統！！'); window.location='loginCheck-Select.jsp' </script>");%>
	
	<%}%>

<script>
<<<<<<< Updated upstream
   
=======
//確保document已經載入後再執行JavaScript代碼
document.addEventListener('DOMContentLoaded', function() {
    var dateInput = document.getElementById('appointmentDate');

>>>>>>> Stashed changes
    dateInput.addEventListener('input', function() {
        // 檢查星期日
        noSundays();
<<<<<<< Updated upstream

=======
        // 檢查過去的日期
        checkPastDate();
    });
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
=======
});
</script>
>>>>>>> Stashed changes


	</html>

	
	

 