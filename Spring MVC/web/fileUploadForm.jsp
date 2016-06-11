<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<form method="post" action="/register/uploadFile" enctype="multipart/form-data">
    Profile image <input type="file" name="image"><br/>
    <input type="submit" value="submit">
</form>
</body>
</html>
