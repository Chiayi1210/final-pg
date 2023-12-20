<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="menu.jsp" %>
<jsp:useBean id='objDBConfig' scope='session' class='hitstd.group.tool.database.DBConfig' />

<html>

<head>
    <!-- Basic -->
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <!-- Site Metas -->
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>會員資料管理 | 北護智慧藥局線上預約平台</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

    <!-- Fonts style -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap" rel="stylesheet">

    <!-- Owl slider stylesheet -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />

    <!-- Font Awesome style -->
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <!-- Nice Select -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha256-mLBIhmBvigTFWPSCtvdu6a76T+3Xyt+K571hupeFLg4=" crossorigin="anonymous" />
    <!-- Datepicker -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css">
    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet" />
    <!-- Responsive style -->
    <link href="css/responsive.css" rel="stylesheet" />

    <style>
        .btn-primary {
            color: #fff;
            background-color: #00c6a9;
            border-color: #00c6a9;
        }

        .buttonSS {
            /* Add your buttonSS styles here */
        }

        .button:active {
            /* Add your button:active styles here */
        }

        .input_block {
            border-bottom: 1px solid rgba(0, 0, 0, .1);
        }

        /* Add your additional styles here */
         .container {
            text-align: center;
        }

    </style>

</head>

<body>
    <div class="container text-center">
        <div class="row">
            <div class="col-md-12">
                <h1>會員基本資料</h1>
    <%
        Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
        Connection con = DriverManager.getConnection("jdbc:ucanaccess://" + objDBConfig.FilePath() + ";");
        Statement smt = con.createStatement();
        String sql = "SELECT * FROM member WHERE id='" + session.getAttribute("numberid") + "'";
        ResultSet IM = smt.executeQuery(sql);
        IM.next();
    %>
   
                    <div class="row">
                        <div class="col-md-6">
                        <form action="MBpic_update.jsp" method="post" enctype="multipart/form-data">
                            <img src="<%=IM.getString("pic") %>" style="width:280px; height:200px">
                            <h3>選擇要上傳的文件:</h3>
                            <input type="file" name="theFirstFile" size="50" />
                            <input type="submit" name=submitButton value="上傳" />
                           </form>
                            <form action="MBupdate-pp.jsp?memberid=<%=request.getParameter("memberid")%>" method="post" name="form">
                            <script>
                                function del() {
                                    document.form.action = "MBpic_update.jsp";
                                    document.form.enctype = "multipart/form-data";
                                    document.form.submit();
                                }
                            </script>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label>姓名</label>
                                <input type="text" name="membername" id="membername" class="form-control" value="<%=IM.getString("name")%>">
                            </div>
                            <div class="form-group">
                                <label>身分證字號</label>
                                <input type="text" class="form-control" value="<%out.print(session.getAttribute("numberid"));%>" readonly="true">
                            </div>
                            <div class="form-group">
                                <label>電話:</label>
                                <input type="text" name="phone" class="form-control" value="<%=IM.getString("phone")%>">
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="text" name="email" class="form-control" value="<%=IM.getString("memberid")%>">
                            </div>
                            <div class="form-group">
                                <label>修改密碼</label>
                                <input type="password" name="memberpwd" class="form-control" value="<%=IM.getString("memberpwd")%>">
                            </div>
                        </div>
                    </div>

                  

                    <div class="panel-footer">
                        <button type="submit" class="btn btn-primary">修改資料</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Your existing sections go here -->

    <section class="info_section ">
        <div class="container">
            <!-- Your existing content goes here -->
        </div>
    </section>

    <footer class="footer_section">
        <div class="container">
            <p>
                &copy; <span id="displayYear"></span> All Rights Reserved By
                <a href="https://html.design/">Free Html Templates</a>
                <a>國立台北護理健康大學 Designed by 鄭嘉儀 陳祖均 林天愛</a>
            </p>
        </div>
    </footer>
</body>

</html>