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
        button {
            background-color: #00c6a9;
            color: white;
            padding: 10px 18px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 40%;
        }

        button:hover {
            opacity: 0.8;
        }

        input[type=text],
        input[type=password],
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        input[type=text],
        input[type=password] {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            box-sizing: border-box;
        }

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

        body {
            text-align: center;
        }

        .container {
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            text-align: left;
            width: 70%;
        }
         .footer_section {
            padding: 0px 5px; /* 調整上下 padding，減小高度 */
            background-color: #252525; /* 附加的：設定背景色 */
        }

        .footer_section p {
            margin-bottom: 5px; /* 調整段落內容的下邊距，使其更加緊湊 */
        }

        .footer_section a {
            margin-left: 5px; /* 給超連結之間添加一點間距 */
        }
    </style>

    <script>
        function submitForm() {
            document.form.submit();
        }
       
    </script>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <br><br>
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
                    <div class="col-md-12 form-container">
                        <form action="MBupdate-pp.jsp?memberid=<%=request.getParameter("memberid")%>" method="post" name="form">
                            <div class="form-group">
                                <label for="membername">姓名</label>
                                <input type="text" name="membername" id="membername" class="form-control" value="<%=IM.getString("name")%>">
                            </div>
                            <div class="form-group">
                                <label for="numberid">身分證字號</label>
                                <input type="text" class="form-control" value="<%out.print(session.getAttribute("numberid"));%>" readonly="true">
                            </div>
                            <div class="form-group">
                                <label for="phone">電話:</label>
                                <input type="text" name="phone" class="form-control" value="<%=IM.getString("phone")%>">
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="text" name="email" class="form-control" value="<%=IM.getString("memberid")%>">
                            </div>
                            <div class="form-group">
                                <label for="memberpwd">修改密碼</label>
                                <input type="password" name="memberpwd" class="form-control" value="<%=IM.getString("memberpwd")%>">
                            </div>
                        </form>
                    </div>
                </div>

                <div class="panel-footer">
                    <button type="button" class="button" onclick="submitForm()">修改資料</button>
                </div>
            </div>
        </div>
    </div>

    <br><br><br><br>
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
