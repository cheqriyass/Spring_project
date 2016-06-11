<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="<c:url value="/multiform/css/formStyle.css"/>">

    <style>
        body {
            background-color: transparent;
        }

        .btn-file {
            position: relative;
            overflow: hidden;
            margin: 10px;

        }

        .btn-file input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            min-width: 100%;
            min-height: 100%;
            font-size: 100px;
            text-align: right;
            filter: alpha(opacity=0);
            opacity: 0;
            outline: none;
            background: white;
            cursor: inherit;
            display: block;
            margin: 10px;
        }
    </style>


</head>
<body>

<%@ include file="navbar.jsp" %>

<!-- multistep form -->
<form id="msform" action="/cotransport/dologin" method="post" style="padding-top: 100px">

    <fieldset>
        <h2 class="fs-title">Login</h2>
        <div id="result1" style="color: red;">
            <ul>
                ${loginerror}
            </ul>
        </div>
        <input type="text" name="email" placeholder="Email" value="${email}"/>
        <input type="password" name="pass" placeholder="Password" />
        <input type="submit" class="next action-button" value="Submit"/>
    </fieldset>

</form>

<!-- jQuery -->
<script src="http://thecodeplayer.com/uploads/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<!-- jQuery easing plugin -->
<script src="http://thecodeplayer.com/uploads/js/jquery.easing.min.js" type="text/javascript"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


<script src="<c:url value="/multiform/jquery_m.js"/>" type="text/javascript"></script>
</body>
</html>
