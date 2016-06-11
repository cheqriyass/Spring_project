<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Registration</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
        integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
  <style type="text/css">
    /*custom font*/
    @import url(http://fonts.googleapis.com/css?family=Montserrat);

    /*basic reset*/
    * {
      margin: 0;
      padding: 0;
    }

    html {
      height: 100%;
      /*background-color: #cccccc;*/

      /*Image only BG fallback*/
      background: url('http://thecodeplayer.com/uploads/media/gs.png')  top right no-repeat;
      background-attachment:fixed;
      background-repeat: no-repeat;

      /*background = gradient + image pattern combo*/
      background: linear-gradient(rgba(196, 102, 0, 0.2), rgba(155, 89, 182, 0.2)),
      url('http://thecodeplayer.com/uploads/media/gs.png');

    }

    body {
      font-family: montserrat, arial, verdana;
    }


  </style>
</head>


<body>

<%@ include file="WEB-INF/View/navbar.jsp" %>




</body>
</html>