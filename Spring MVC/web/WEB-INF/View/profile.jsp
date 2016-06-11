<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>My Profile</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <link href="<c:url value="/resources/profile.css"/>" rel="stylesheet" type="text/css">

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
            background-color: #edeff2;

        }

        body {
            background-color: #edeff2;
            font-family: montserrat, arial, verdana;
        }


    </style>
</head>


<body>


<%
    User myprof = (User) request.getSession().getAttribute("prof");
%>


<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="row">

        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad">


            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title"><%=myprof.getPrenom()%> <%=myprof.getNom()%>
                    </h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3 col-lg-3 " align="center"><img alt="User Pic"
                                                                            src="<c:url value="/resources/profilePic.png"/>"
                                                                            class="img-circle img-responsive"></div>


                        <div class=" col-md-9 col-lg-9 ">
                            <table class="table table-user-information">
                                <tbody>

                                <tr>
                                    <td>Email</td>
                                    <td><a href=""><%=myprof.getEmail()%>
                                    </a></td>
                                </tr>

                                <tr>
                                    <td>Date of Birth</td>
                                    <td>
                                        <%
                                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                                            String date = sdf.format(myprof.getDateNaissance());
                                        %>
                                        <%=date%>
                                    </td>
                                </tr>

                                <tr>
                                <tr>
                                    <td>Gender</td>
                                    <td><%=myprof.getSexe()%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Home Address</td>
                                    <td><%=myprof.getAdresse()%>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Phone Number</td>
                                    <td><%=myprof.getTelephone()%>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Date of Birth</td>
                                    <td>
                                        <%
                                            String date2 = sdf.format(myprof.getDateInscription());
                                        %>
                                        <%=date2%>
                                    </td>
                                </tr>

                                <tr>
                                    <td><a href="/cotransport/mesAnnonce?id=<%=myprof.getId()%>"
                                           class="btn btn-primary">Annonces</a></td>
                                    <td>
                                        <!-- Button trigger modal -->
                                        <button type="button" class="btn btn-primary" data-toggle="modal"
                                                data-target="#myModal">
                                            Envoyer un message
                                        </button>
                                    </td>
                                </tr>

                                </tbody>
                            </table>


                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
</div>




<form action="/cotransport/sendMessage" method="post">
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         style="padding-top: 150px">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Envoyer un Message à <span
                            style="color: blue;"><%=myprof.getPrenom()%> <%=myprof.getNom()%></span></h4>
                </div>
                <div class="modal-body">
                    <br/>
                    <textarea class="form-control" name="message" placeholder="message" rows="5" cols=""></textarea>
                    <input type="hidden" name="receiver" value="<%=myprof.getId()%>">
                    <input type="hidden" name="sender" value="<%=email%>">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
                    <input type="submit" class="btn btn-primary" value="Envoyer" />
                </div>
            </div>
        </div>
    </div>
</form>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


</body>
</html>