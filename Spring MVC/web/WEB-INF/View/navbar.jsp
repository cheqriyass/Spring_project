<%@ page import="Model.Entities.User" %>
<%@ page import="Model.DAO.UserDaoImpl" %>
<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/cotransport/index.jsp">Co-Transport</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="/cotransport/home">Home</a></li>
            <li><a href="/cotransport/allannonce">Tous les annonces</a></li>
            <li><a href="#">About Us</a></li>
            <li><a href="#">Contact</a></li>
        </ul>

        <ul class="nav navbar-nav navbar-right">
            <%

                UserDaoImpl dao = new UserDaoImpl();

                Cookie[] cookies = request.getCookies();
                String email = null;
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("email")) {
                            email = cookie.getValue();
                        }
                    }
                }


                if (email.equals("")) {
            %>
            <li><a href="/cotransport/inscription"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
            <li><a href="/cotransport/login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
            <%
            } else {

                User user = dao.findByUserName(email);


            %>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <span class="glyphicon glyphicon-menu-hamburger"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="/cotransport/addAnnonce">Publier annonce</a></li>
                    <li><a href="/cotransport/mesAnnonce?id=<%=user.getId()%>">Mes annonces</a></li>
                    <li><a href="/cotransport/myprofile?id=<%=user.getId()%>">Profile</a></li>
                    <li><a href="/cotransport/mymessage?id=<%=user.getId()%>">Mes message</a></li>
                    <li><a href="/cotransport/signout">Sign Out</a></li>
                </ul>
            </li>
            <%}%>
        </ul>
    </div>
</nav>

<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>--%>
<%--<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>--%>
