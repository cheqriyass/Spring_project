<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous">


    <style type="text/css">
        /*custom font*/
        @import url(http://fonts.googleapis.com/css?family=Montserrat);

        /*basic reset*/
        * {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: montserrat, arial, verdana;
            background: url('<c:url value="/resources/jumbo.jpg"/>');
            background-size: 100%;
            background-repeat: no-repeat;

        }


         input select{
             height: 100px;
         }

        select.transparent-input{
            background-color: rgba(255, 255, 255, 0.6);
            border:none;
        }
    </style>
</head>


<body>

<%@ include file="navbar.jsp" %>


<form class="form-horizontal" role="form" action="homeSearch" method="post">

    <div class="form-group" style="padding-top: 250px;">
        <div class="col-md-12">
            <div class="form-group row">
                <div class="col-md-2"></div>
                <div class="col-md-3">
                    <select class="form-control input-lg transparent-input" name="depart">
                        <option value="0">  ---  Ville de depart  --- </option>
                        ${villes}
                    </select>
                </div>

                <div class="col-md-3">
                    <select class="form-control input-lg transparent-input" name="arrive">
                        <option value="0">  ---  Ville d'arrivee  --- </option>
                        ${villes}
                    </select>
                </div>

                <div class="col-md-2">
                    <input type="submit" class="btn btn-block btn-primary btn-lg" value="Recherche">
                </div>
            </div>
        </div>
    </div>
</form>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


</body>
</html>