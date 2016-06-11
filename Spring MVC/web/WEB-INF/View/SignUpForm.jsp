<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Inscription</title>
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
<form id="msform" action="/cotransport/sinscrir" method="post">
    <!-- progressbar -->
    <ul id="progressbar">
        <li class="active">Account Setup</li>
        <li>Personal Details</li>
        <li>Profile Details</li>

    </ul>
    <!-- fieldsets -->
    <fieldset>
        <h2 class="fs-title">Create your account</h2>
        <div id="result1" style="color: red;"></div>
        <input type="text" name="email" placeholder="Email"/>
        <input type="password" name="pass" placeholder="Password"/>
        <input type="password" name="passc" placeholder="Confirm Password"/>
        <input type="hidden" name="step" value="1"/>
        <input type="button" name="next" class="next action-button" value="Next"/>
    </fieldset>

    <fieldset>
        <h2 class="fs-title">Personal Details</h2>
        <div id="result2" style="color: red;"></div>
        <input type="text" name="fname" placeholder="First Name"/>
        <input type="text" name="lname" placeholder="Last Name"/>

        <input type="radio" name="sex" value="Male" class="st" checked="checked">Male
        <input type="radio" name="sex" value="Female" class="st">Female

        <input type="text" name="phone" placeholder="Phone"/>
        <input type="text" name="bdate" placeholder="Birth date (dd-mm-yyyy)"/>
        <textarea name="address" placeholder="Address"></textarea>
        <input type="button" name="previous" class="previous action-button" value="Previous"/>
        <input type="button" name="next" class="next action-button" value="Next"/>
    </fieldset>

    <fieldset>
        <h2 class="fs-title">Profile Details</h2>
        <div id="result3" style="color: red;"></div>

        <span class="btn btn-default btn-file">
            Profile image <input type="file" name="image">
        </span>

        <textarea name="description" placeholder="Description"></textarea>
        <input type="text" name="marque" placeholder="Marque vehicule"/>
        <input type="text" name="model" placeholder="Model"/>
        <input type="text" name="couleur" placeholder="Couleur"/>


        <input type="button" name="previous" class="previous action-button" value="Previous"/>
        <input type="submit" name="submit" class="submit action-button" value="Submit"/>

    </fieldset>
</form>

<!-- jQuery -->
<script src="http://thecodeplayer.com/uploads/js/jquery-1.9.1.min.js" type="text/javascript"></script>
<!-- jQuery easing plugin -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="http://thecodeplayer.com/uploads/js/jquery.easing.min.js" type="text/javascript"></script>

<script src="<c:url value="/multiform/jquery_m.js"/>" type="text/javascript"></script>
</body>
</html>
