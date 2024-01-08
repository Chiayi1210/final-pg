<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@page import="java.sql.*"%>
    <%@include file ="menu.jsp" %>
   <jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />

<!DOCTYPE html>
<html>
 <%
	Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
	Connection con=DriverManager.getConnection("jdbc:ucanaccess://"+objDBConfig.FilePath()+";");
	//out.println("Con= "+con);
	Statement smt= con.createStatement();
	String sql = "SELECT * FROM indexIM ";
	ResultSet IM = smt.executeQuery(sql);
	
	IM.next();
	  
	%>
<body>
 <div class="hero_area">
  <form method="post" action="logout.jsp" >
  <%if (session.getAttribute("access") == "y"){%>

<!-- 登出頁 -->
  
      
    <!-- end header section -->
    <!-- slider section -->
    <section class="slider_section ">
      <div id="customCarousel1" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <div class="container ">
              <div class="row">
                <div class="col-md-6">
                  <div class="detail-box">
                    
                    <h1>
                     <%out.print(session.getAttribute("membername"));%><br>北護智慧藥局<br>員工介面<br>
                       <span>
                        NTUNHS Pharmacy
                       </span>
                    </h1>
                    <a href="index-P.jsp#3456">
                      聯絡我們
                    </a>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="img-box">
                    <img src="images/Pharmacy.jpg" alt="">
                  </div>
                </div>
              </div>
            </div>
          </div>  
          </div> 
    </section>
    
    </form>
    <!-- end slider section -->
    
    <%}else{%>
    
    
 <!-- 登入頁 -->

    <!-- end header section -->
    <!-- slider section -->
  <div class="hero_area">
   <section class="slider_section ">
      <div class="dot_design">
        <img src="images/dots.png" alt="">
      </div>
      <div id="customCarousel1" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <div class="container ">
              <div class="row">
                <div class="col-md-6">
                  <div class="detail-box">
                    
                    <h1>
                     北護智慧藥局線上預約平台 <br>
                       <span>
                        NTUNHS Pharmacy
                        </span>
                    </h1>  
                    <a href="index-P.jsp#3456">
                      聯絡我們
                    </a>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="img-box">
                    <img src="images/Pharmacy.jpg" alt="">
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      </div>
   </section>
 
    <!-- end 登入頁 -->
<%}%>
  <!-- book section -->
 <div class="hero_area">
  <section class="book_section layout_padding">
    <div class="container">
      <div class="row">
        <div class="col">
          
        </div>
      </div>
    </div>
  </section>  <!-- about section -->
<form action="indexpp.jsp">
<section class="about_section">
    <div class="container  ">
      <div class="row">
        <div class="col-md-6 ">
          <div class="img-box">
                    <img src="images/about.jpg" alt="">
                  </div>
        </div>
        <div class="col-md-6" id="112233">
          <div class="detail-box">
            <div class="heading_container"  >
              <h2>
                關於 <span>北護智慧藥局</span>
              </h2>
            </div>
            <p id="P1">
            <%=IM.getString("P1")%>
             <textarea id="P1" name="P1" rows="4" cols="50"></textarea>
            <button type="submit">修改</button>
              <!-- 本藥局受復康活力藥局及其他贊助廠商捐贈「智能身體成分分析儀」、「智慧感測墊」、「輪椅、助行推車及四腳枴」、「智慧健康手錶」、「保健品」、「藥局申報系統」、「智慧膝力環及足速適客製化鞋墊」等，提供學生良好的學習環境和資源， 讓學生更了解實務操作及有助於推動藥局服務教育和研究發展。此外，還可以使學生們了解門市的營運方式及管理，為未來就業提早做準備，增加學生們的信心，提高競爭力。 -->
            </p><!-- 改成關於藥局的資料 -->
          </div>
        </div>
      </div>
    </div>
    </div> 
  </section>

  <!-- end about section -->



  <!-- info section -->
  <section class="info_section ">
    <div class="container">
      <div class="info_top">
        <div class="info_logo">
          <a href="">
            <img src="images/logo.png" alt="">
          </a>
        </div>     
      </div>
      <div class="info_bottom layout_padding2">
        <div class="row info_main_row">
          <div class="col-md-6 col-lg-3">
            <h5>
              聯絡資訊
            </h5>
            <div class="info_contact">
              <a href="https://maps.app.goo.gl/MQRkGSyGmgwZGcRx6">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                <span>
                  位置
                   <br>
                   <a>台北市北投區明德路365號</a>
                </span>
              </a>
              <a href="">
                <i class="fa fa-phone" aria-hidden="true"></i>
                <span>
                  電話 02-1234567890
                </span>
              </a>
              <a href="">
                <i class="fa fa-envelope"></i>
                <span>
                  Ntunhs@gmail.com
                </span>
              </a>
            </div>
            <div class="social_box">
              <a href="">
                <i class="fa fa-facebook" aria-hidden="true"></i>
              </a>
              <a href="">
                <i class="fa fa-twitter" aria-hidden="true"></i>
              </a>
              <a href="">
                <i class="fa fa-linkedin" aria-hidden="true"></i>
              </a>
              <a href="https://www.instagram.com/ntunhs_dhcm/">
                <i class="fa fa-instagram" aria-hidden="true"></i>
              </a>
            </div>
          </div>
          <div class="col-md-6 col-lg-3">
            <div class="info_links">
              <h5>
                連結
              </h5>
              <div class="info_links_menu">
                <a class="active" href="index-P.jsp">
                  首頁
                </a>
                <a href="index-P.jsp/#112233">
                  關於我們
                </a>
                <a href="index-P.jsp#1234">
                 藥師簡介
                </a>
                <%if (session.getAttribute("access") == "y"){%>
                <a href="P-prescription.jsp">
                  慢箋預約
                <%}else{%>
                <a href="#">
                  慢箋預約
                </a>
                <%}%>
                <a href="index2.jsp#3456">
                  聯絡我們
                </a>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3">
            <div class="info_post">
             
              <h5>
                最新消息
              </h5>
              <div class="post_box">
                <div class="img-box">
                  <img src="images/post3.jpg" alt="">
                </div>
                <p>
                  <%=IM.getString("P2")%>
                </p>
              </div>
              <textarea id="P2" name="P2" rows="2" cols="30"></textarea>
            <button type="submit">修改</button>
              <div class="post_box">
                <div class="img-box">
                  <img src="images/post4.png" alt="">
                </div>
                <p>
                  <%=IM.getString("P3")%>
                </p>
              </div>
              <textarea id="P3" name="P3" rows="2" cols="30" ></textarea>
            <button type="submit">修改</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- end info_section -->


  <!-- footer section -->
  <footer class="footer_section">
    <div class="container">
      <p>
        &copy; <span id="displayYear"></span> All Rights Reserved By
        <a href="https://html.design/">Free Html Templates</a>
        <a>國立台北護理健康大學 Designed by 鄭嘉儀 陳祖均 林天愛</a>
      </p>
    </div>
    
     </footer>
  <!-- footer section -->
  </div>
  
<!-- jQery -->
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

 </form>


</body>

</html>    