<!-- 後臺預約資料 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@page import="java.sql.*"%>
 <%@include file ="menu.jsp" %>
 <jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />
<html>
   
<script src="js/jquery-3.4.1.min.js"></script>
    <!-- bootstrap js -->
    <script src="js/bootstrap.js"></script>
    <!-- nice select -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js" integrity="sha256-Zr3vByTlMGQhvMfgkQ5BtWRSKBGa2QlspKYJnkjZTmo=" crossorigin="anonymous"></script>
    <!-- owl slider -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <!-- datepicker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
    <!-- custom js -->
    <script src="js/custom.js"></script>
  <script>
  (function(){
    var bsa = document.createElement('script');
       bsa.type = 'text/javascript';
       bsa.async = true;
       bsa.src = '//s3.buysellads.com/ac/bsa.js';
    (document.getElementsByTagName('head')[0]||document.getElementsByTagName('body')[0]).appendChild(bsa);
  })();
  if (window != top) top.location.href = location.href;
  jQuery(document).ready(function($){ $('img').removeAttr('width height'); });
  var gaProperty = 'UA-120201777-1';
  var disableStr = 'ga-disable-' + gaProperty;if (document.cookie.indexOf(disableStr + '=true') > -1) {window[disableStr] = true;}
  function gaOptout() {document.cookie = disableStr + '=true; expires=Thu, 31 Dec 2045 23:59:59 UTC; path=/';window[disableStr] = true;alert('Google Tracking has been deactivated');}
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');ga('create', 'UA-120201777-1', 'auto');ga('set', 'anonymizeIp', true);ga('send', 'pageview');
  </script>
  <head>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap" rel="stylesheet">

  <!--owl slider stylesheet -->
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />

  <!-- font awesome style -->
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <!-- nice select -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
  <!-- datepicker -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css">
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="css/responsive.css" rel="stylesheet" />
  

<title>預約資料 | 北護智慧藥局線上預約平台</title>

<body> 
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


button2 {
  background-color: #00c6a9;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 40%;
  display: inline-block;
 
}

button-1 {
  background-color: #00c6a9;
  color: white;
  padding: 5px 5px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: auto;
  
}

button {
  background-color: #00c6a9;
  color: white;
  padding: 10px 10px;
  margin: 15px 0;
  border: none;
  cursor: pointer;
  width: 45%;
  border-radius:10px;
}



button:hover {
  opacity: 0.8;
}

button2:hover {
  opacity: 0.8;
}

button-1:hover {
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
    width:70%;
    z-index: 1;
    margin:  8%;
    overflow: visible;
    border-radius: 10px;
}
        
.window-content {
    width: auto;
    height: 500px;
    line-height: 200px;
    overflow:visible;
    text-align:center;
 
  }

span {
    display: inline-block;
    vertical-align: middle;
    line-height: normal;
}
<!--表格樣式-->
table {
  border: 0;
  border-collapse: collapse;
  border-radius: 8px;
  width: 100%;
}
th {
  border: solid 1px #00c6a9;
  padding: 16px 8px;
}
td {
  border: solid 1px #00c6a9;
  text-align: center;
  padding: 8px;
  color: #000000;
}
table td a{
  background-color: rgb(74, 225, 255);
  color: white;
  padding:5px 20px;
  border-radius: 30px;
  font-weight: bold;
 
}



.basic {
  background-color: #00c6a9;
}
.standard {
  background-color: rgb(3, 229, 195);
  border: 1px solid rgb(3, 229, 195);
  color: rgb(0, 0, 0);
}
.premium {
  border: 1px solid #2e3a4d;
  background-color: #2e3a4d;
  color: white;
}
.price {
  font-size: 20px;
  font-weight: 800;
}
.price td {
  color: black;
}
.main {
  width: 80%;
  margin: 20px auto;
  justify-content: center;
  align-items: center;
}
@media print {
.noPrint {
    display: none;
  }
@page{
  /*size: portrait;  直向(預設) */
  size: landscape; /* 橫向 */
  /*size: 10cm;  單值則長寬皆為10cm */
  /*size: 4cm 6cm;  寬4cm 高6cm */
  size: A4;  /* 保留字 */
  size: A4 landscape; /*  尺寸/保留字 + 方向 */
  widows: 0;

} 
}
</style>
<center><h1 class="noPrint">預約資料</h1></center>

<center>
<a class="noPrint">查詢：</a><input type="search" class="light-table-filter && noPrint" data-table="order-table" placeholder="請輸入姓名/身分證字號"><br>
   
<script>(function(document) {
    'use strict';
  
    // 建立 LightTableFilter
    var LightTableFilter = (function(Arr) {
  
      var _input;
  
      // 資料輸入事件處理函數
      function _onInputEvent(e) {
        _input = e.target;
        var tables = document.getElementsByClassName(_input.getAttribute('data-table'));
        Arr.forEach.call(tables, function(table) {
          Arr.forEach.call(table.tBodies, function(tbody) {
            Arr.forEach.call(tbody.rows, _filter);
          });
        });
      }
  
      // 資料篩選函數，顯示包含關鍵字的列，其餘隱藏
      function _filter(row) {
    	  var name = row.cells[0].textContent.toLowerCase(); // 第一欄是姓名
    	    var id = row.cells[1].textContent.toLowerCase();   // 第二欄是身分證字號
    	    var val = _input.value.toLowerCase();

    	    // 只在姓名和身分證字號中進行查詢
    	    if (name.indexOf(val) !== -1 || id.indexOf(val) !== -1) {
    	        row.style.display = 'table-row';
    	    } else {
    	        row.style.display = 'none';
    	    }
    	}
  
      return {
        // 初始化函數
        init: function() {
          var inputs = document.getElementsByClassName('light-table-filter');
          Arr.forEach.call(inputs, function(input) {
            input.oninput = _onInputEvent;
          });
        }
      };
    })(Array.prototype);
  
    // 網頁載入完成後，啟動 LightTableFilter
    document.addEventListener('readystatechange', function() {
      if (document.readyState === 'complete') {
        LightTableFilter.init();
      }
    });
  
  })(document);
</script>
 <%
	Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
    Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
    Statement smt= con.createStatement();	
	String sql1 = "SELECT * FROM prescription";	
    ResultSet rs = smt.executeQuery(sql1);

	%>

<div class="main">
    
    <table class="order-table">
        <thead>
      <tr align="center">
        <th class="basic" >姓名</th>
        <th class="standard popular">身分證字號</th>
        <th class="basic">電話號碼</th>
        <th class="standard popular">Email</th>
        <th class="basic">日期</th>
        <th class="standard popular">時間</th>
        <th class="basic">慢箋號碼</th>
        <th class="standard popular && noPrint"></th>
        <th class="basic && noPrint"></th>
        <th class="standard popular && noPrint"></th>
      </tr></thead>
      <tbody>
      <% while (rs.next()) { %>   
      <tr >
        <td><%= rs.getString("name") %></td>
        <td ><%= rs.getString("id") %></td>
        <td><%= rs.getString("phone") %></td>
        <td><%= rs.getString("email") %></td>
        <td ><%= rs.getString("date") %></td>
        <td><%= rs.getString("time") %></td>
        <td><%= rs.getString("cnumber1") %></td>
        <td class="noPrint"><a href="" class="noPrint">更改</a></td>
        <td class="noPrint"><a href="#" class="noPrint" style="background-color: magenta;" onclick="deleteData('<%= id %>')">刪除</a></td>
        <td class="noPrint"><a href="send.html" class="noPrint" style="background-color :rgb(249, 56, 27)">缺藥</a2></td>
      </tr>
       <% } %>
      </tbody>
      <script>
    function deleteData(id) {
        if (confirm("確定要刪除這筆資料嗎？")) {
            // 使用 JavaScript 的 Fetch API 向後端發送刪除請求
            fetch('jdbc:ucanaccess://"+objDBConfig.FilePath()+?id=' + id, {
                method: 'POST',
            })
            .then(response => response.json())
            .then(data => {
                alert("資料已成功刪除");
                location.reload();
            })
            .catch((error) => {
                console.error('Error deleting data:', error);
            });
        }
    }
</script>

<%
    // Your existing code...

    // 在適當的位置構建 SQL DELETE 語句，並執行它以刪除記錄
    String deleteSQL = "DELETE FROM prescription WHERE id='"+session.getAttribute("numberid")+"'";
    try (PreparedStatement deleteStatement = con.prepareStatement(deleteSQL)) {
       
        int rowsAffected = deleteStatement.executeUpdate();
        // 在這裡處理 rowsAffected，確保記錄被成功刪除
    } catch (SQLException e) {
        e.printStackTrace();
        // 處理 SQL 錯誤
    }
%>
    </table>
    </div>
    
    <button ONCLICK="window.print()" class="noPrint">列印預約資料</button>
    <script>
    function varitext(text){
        text=document
        print(text)
        }</script>
	</center>
	</body>
	</html>