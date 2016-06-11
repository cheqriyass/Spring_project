<%@ page import="Model.Entities.Annonce" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="Model.Entities.Voyage" %>
<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>--%>
    <%--<script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>--%>
    <%--<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet"--%>
    <%--type="text/css">--%>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous">

    <link href="<c:url value="/resources/ListAds.css"/>" rel="stylesheet" type="text/css">
    <style>

        @import url(http://fonts.googleapis.com/css?family=Montserrat);

        nav {
            /*background-color: #eeeeee;*/
            font-family: montserrat, arial, verdana;
        }

        /*.color {*/
        /*color: black;*/
        /*border: none;*/
        /*background-color: #5bc0de;*/
        /*}*/

        .recherche {
            border-top: solid;
            border-bottom: solid;
            border-width: 1px;
            border-color: grey;
        }

        /*.divannonces {*/
        /*background: #eeeeee;*/
        /*}*/

        .annonce {
            padding-top: 15px;
            border: solid 2px #bbbbbb;
            border-radius: 10px;
            background: white;
        }
    </style>

</head>
<body>


<%@ include file="navbar.jsp" %>


<div class="section recherche">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center text-primary">
                    Recherche
                </h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal" role="form" action="/cotransport/rechercheAnnonce" method="post">
                    <div class="form-group">
                        <div class="col-sm-4">
                            <select class="form-control input-lg" name="depart" placeholder="Lieu de depart">
                                <option value="0">Ville de depart</option>
                                ${villes}
                            </select>
                            <br>
                            <input type="date" class="form-control input-lg" name="ddepart"
                                   placeholder="Date de depart">
                        </div>
                        <div class="col-sm-4">
                            <select class="form-control input-lg" name="arrive" placeholder="Lieu d'arrivee">
                                <option value="0">Ville d'arrivee</option>
                                ${villes}
                            </select>
                            </select>
                            <br/>
                            <input type="text" class="form-control input-lg" name="prixmin" placeholder="Prix Min">
                        </div>
                        <div class="col-sm-4">

                            <%--<div class="col-sm-8">--%>
                            <select class="form-control input-lg" name="categorie" id="categorie">
                                ${categorie}
                            </select>
                            <%--</div>--%>
                            <br/>
                            <input type="text" class="form-control input-lg" name="prixmax"
                                   placeholder="Prix Max">

                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-4">
                            <input type="submit" class="btn btn-block btn-info btn-lg" value="Rechercher">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<div class="section" style="background-color: #eeeeee;">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="section">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-11">
                                <div class="section">
                                    <div class="container">

                                        <%
                                            List<Annonce> list = (List<Annonce>) request.getSession().getAttribute("annonceList");

                                            for (Annonce an : list) {
                                                String st = "";
                                                List<Voyage> l = an.getVoyageList();
                                                for (int i = 0; i < l.size() - 1; i++) {
                                                    st += l.get(i).getLieuDepart();
                                                    st += " -> ";
                                                }
                                                st += an.getLieuArriveeFinal();

                                        %>
                                        <br/>
                                        <div class="row annonce">
                                            <div class="col-md-3">
                                                <div class="thumbnail">
                                                    <img src="<c:url value="/resources/profilePic.png"/>"
                                                         width="300" height="300" class="img-responsive">
                                                    <div class="caption">
                                                        <a href="/cotransport/showProfile?id=<%=an.getAnnonceur().getId()%>">
                                                            <h3 style="color: darkorange"><%=an.getAnnonceur().getPrenom()%>
                                                                <%=an.getAnnonceur().getNom()%>
                                                            </h3></a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <a href="/cotransport/Annonce/getAnnonceId?id=<%=an.getId()%>"><h4
                                                        style="color: #00a0f5"><%=st%>
                                                </h4></a>
                                                <%
                                                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy 'at' HH:mm");
                                                    String date = sdf.format(an.getDateDepart());
                                                %>
                                                <h4 style="color: darkorange"><%=date%>
                                                </h4>
                                                <h4 style="color: #00a0f5"><%=an.getCategorie()%>
                                                </h4>
                                                <p><%=an.getDescription()%>
                                                </p>
                                            </div>
                                            <div class="col-md-2"></div>

                                            <div class="col-md-2">
                                                <h3 class="text-right"><%=an.getPrix()%> DH</h3>
                                                <br/>
                                                <br/>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <a class="btn btn-block btn-primary"
                                                           href="/cotransport/Annonce/getAnnonceId?id=<%=an.getId()%>">Plus
                                                            d'infos..</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <%
                                            }
                                        %>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="row">
    <div class="col-md-12 text-center">
        <ul class="pagination">
            <li><a href="#">Prev</a></li>
            <li><a href="#">1</a></li>
            <li><a href="#">Next</a></li>
        </ul>
    </div>
</div>


<%@ include file="footer.jsp" %>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


</body>
</html>