<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registration</title>
    
    <style type="text/css">
        .error{
            color: #dd0000;
        }
        .fieldError{
            border-color: #dd0000;;
        }
    </style>
</head>
<body>
<div align="center">
    <form:form action="register" method="post" commandName="userForm">
        <table border="0">
            <tr>
                <td colspan="2" align="center"><h2>
                    <spring:message code="form.header" argumentSeparator="," arguments="Yassine,cheqri" />
                </h2></td>
            </tr>
            <tr>
                <td>User Name:</td>
                <td><form:input path="username" cssErrorClass="fieldError"/></td>
                <td><form:errors path="username" cssClass="error"/></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><form:password path="password" cssErrorClass="fieldError"/></td>
                <td><form:errors path="password" cssClass="error"/></td>
            </tr>
            <tr>
                <td>E-mail:</td>
                <td><form:input path="email" cssErrorClass="fieldError"/></td>
                <td><form:errors path="email" cssClass="error"/></td>
            </tr>
            <tr>
                <td>Birthday (mm/dd/yyyy):</td>
                <td><form:input path="birthDate" cssErrorClass="fieldError"/></td>
                <td><form:errors path="birthDate" cssClass="error"/></td>
            </tr>
            <tr>
                <td>Profession:</td>
                <td><form:select path="profession" items="${professionList}" /></td>
                <td><form:errors path="profession" items="${professionList}" /></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="submit" value="Register" /></td>
            </tr>
        </table>
    </form:form>
</div>
</body>
</html>