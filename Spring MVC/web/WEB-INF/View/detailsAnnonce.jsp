<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ page import="Model.Entities.Annonce" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="Model.Entities.Voyage" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Entities.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html lang="en">
<head>
    <title>Détails Annonce de Co-Transport</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous">
    <link href="<c:url value="/resources/ListAdscopy.css"/>" rel="stylesheet" type="text/css">

<%--<link rel="stylesheet" href="style1.css">--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
   <script>
        function initMap() {
            //alert("${destination.size()}");
            var directionsService = new google.maps.DirectionsService;
            var directionsDisplay = new google.maps.DirectionsRenderer;
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 8,
                center: {lat:  31.63179, lng: -7.98926}
            });
            directionsDisplay.setMap(map);

            if("${destination.size()}">0)
            calculateAndDisplayRoute(directionsService, directionsDisplay,"${destination}");
            else
                calculateAndDisplayRoute2(directionsService, directionsDisplay);


        }

        function calculateAndDisplayRoute(directionsService, directionsDisplay,destinations) {
            var waypts = [];
            var checkboxArray = [destinations];
            for (var i = 0; i < checkboxArray.length; i++) {
                waypts.push({
                    location: checkboxArray[i],
                    stopover: true
                });
            }

            directionsService.route({
                origin: "${annonce.lieuDepartInitial}",
                destination: "${annonce.lieuArriveeFinal}",
                waypoints: waypts,
                optimizeWaypoints: true,
                travelMode: google.maps.TravelMode.DRIVING
            }, function(response, status) {
                if (status === google.maps.DirectionsStatus.OK) {
                    directionsDisplay.setDirections(response);
                    var route = response.routes[0];
                    var summaryPanel = document.getElementById('directions-panel');
                    summaryPanel.innerHTML = '';
                    // For each route, display summary information.
                    for (var i = 0; i < route.legs.length; i++) {
                        var routeSegment = i + 1;
                        summaryPanel.innerHTML += '<b>Route Segment: ' + routeSegment +
                                '</b><br>';
                        summaryPanel.innerHTML += route.legs[i].start_address + ' to ';
                        summaryPanel.innerHTML += route.legs[i].end_address + '<br>';
                        summaryPanel.innerHTML += route.legs[i].distance.text + '<br><br>';
                    }
                } else {
                    window.alert('Directions request failed due to ' + status);
                }
            });
        }

        function calculateAndDisplayRoute2(directionsService, directionsDisplay) {
            directionsService.route({
                origin: "${annonce.lieuDepartInitial}",
                destination: "${annonce.lieuArriveeFinal}",
                travelMode: google.maps.TravelMode.DRIVING
            }, function(response, status) {
                if (status === google.maps.DirectionsStatus.OK) {
                    directionsDisplay.setDirections(response);
                } else {
                    window.alert('Directions request failed due to ' + status);
                }
            });
        }
    </script>
    <style>
        @import url(http://fonts.googleapis.com/css?family=Montserrat);
        body {
            /*background-color: #eeeeee;*/
            font-family: montserrat, arial, verdana;
        }

        .strong{
            font-weight: bold;
        }

        .inf{
            float: left;
            margin-right: 10px;
            color: seagreen;
        }

    </style>
    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBr4rYLJirubQX8aZgF6I-7ylwCzSzrMJ8&callback=initMap">
    </script>
</head>
<body>


<%@ include file="navbar.jsp" %>

<%
    int valide=0;
if(session.getAttribute("transporteur")!=null)
    {
        valide=1;
        session.setAttribute("transporteur",null);
    }
    Annonce ann;
    if(request.getAttribute("annonce")!=null)
         ann=(Annonce) session.getAttribute("annonce");
    else
         ann=(Annonce)request.getSession().getAttribute("annonce");
    Voyage voyage=null;
    List<Voyage> voyages=ann.getVoyageList();


    String st = "";
    for (int i = 0; i < voyages.size() - 1; i++) {
        st += voyages.get(i).getLieuDepart();
        st += " -> ";
    }
    st += ann.getLieuArriveeFinal();

    
    
    for(Voyage voy:voyages)
    {
        if(voy.getLieuDepart().equals(ann.getLieuDepartInitial()) && voy.getLieuArrivee().equals(ann.getLieuArriveeFinal()))
        {
            voyage=voy;
            break;
        }

    }
    if(valide==1){
%><br>
<div class="container">
<div class="alert alert-success">
    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    Félicitations,votre reservation a eté bien validé !
</div></div>
<% }%>
<input type="hidden" id="start" value=${annonce.lieuDepartInitial} />
<input type="hidden" id="end" value=${annonce.lieuArriveeFinal} />
<h2 style="margin-left: 140px; color: #092389;"> <%=st%>

    <img src="<c:url value="/resources/img/autoroute.jpg"/>" width="20" height="25"></h2>

<div class="container">
    <div class="col-md-8">
        <div>
            <h3>Détails de l'annonce</h3>
            <div class="content">
                <span class="RideDetails-infoLabel inf">Depart: </span> <span>${annonce.lieuDepartInitial}</span>
            </div>
            <div class="content">
                <span class="RideDetails-infoLabel inf">Arrivée: </span> <span>${annonce.lieuArriveeFinal}</span>
            </div>
            <div class="content">
                <span class="RideDetails-infoLabel inf">Date: </span>
                <%
                    Annonce an = (Annonce)request.getSession().getAttribute("annonce");
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy 'at' HH:mm");
                    String date = sdf.format(an.getDateDepart());
                %>
                 <span><%=date%></span>
            </div>
            <div class="content">
                <span class="RideDetails-infoLabel inf">Flexibilite horaire: </span> <span>+/- ${annonce.retardAccepte} minutes</span>
            </div>
            <div class="content">
                <span class="RideDetails-infoLabel inf">Categorie: </span> <span>${annonce.categorie}</span>
            </div>
        </div>
        <div>
            <h3>Description</h3>
            <div>
                ${annonce.description}
            </div>
        </div>
        <div>
            <h3>Reservation</h3>
            <div>
                <table class="table table-condensed">
                    <thead>
                    <tr>
                        <th width="20%">
                        </th>
                        <th width="20%">
                            <center><label class="glyphicon glyphicon-user"> </label></center>
                        </th>
                        <%for(int j=0;j<ann.getTotalPlaces();j++)
                        {%>
                        <th width="20%">
                            <center><img src="<c:url value="/resources/img/full-seat.png"/>" width="40px" height="35px"></center>
                        </th>
                        <% } %>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                       for(int i=0;i<voyages.size();i++)
                       {
                    %>
                    <tr>
                        <td width="20%">

                                <div>
                                    <img src="<c:url value="/resources/img/start.jpg"/>" width="25px" height="30px"/><%= voyages.get(i).getLieuDepart()%>
                                </div>
                                <div>
                                    <b>
                                        |<br>
                                        |<br>
                                        |<br>
                                        |<br>
                                        |<br>
                                    </b>
                                </div>
                                <div>
                                    <img src="<c:url value="/resources/img/finish.png"/>" width="35px" height="35px"/><%= voyages.get(i).getLieuArrivee()%>
                                </div>
                        </td>
                        <td width="20%">
                            <center>
                                <div>
                                    <%= voyages.get(i).getPrix()%>
                                </div><br>
                                <div>
                                    ~ <%= voyages.get(i).getDistance()%> KM
                                </div><br>
                                <div>
                                    <% int h=(int)voyages.get(i).getDureeEstimee();
                                        int m=(int)((voyages.get(i).getDureeEstimee()-h)*10);%>

                                    ~ <%=h%>H <%=m%> mn <br><i><font size="2pt">(temps total estimes)</font></i>
                                </div>
                            </center>
                        </td>
                        <%
                            int tot=voyages.get(i).getReserveurs().size();
                            for(int y=0;y<tot;y++)
                            {
                        %>
                        <td width="20%" >
                            <div><br><br><a href="/Annonce/reserver?id=<%=i%>"  class="btn btn-danger" disabled title="place dèja réservé"> Reserver Voyage</a></div>
                        </td>

                        <%
                            }
                        %>
                        <%for(int j=0;j<ann.getTotalPlaces()-tot;j++)
                        {
                            %>
                        <td width="20%" >
                            <div><br><br><a href="/cotransport/Annonce/reserver?id=<%=i%>"  class="btn btn-success" > Reserver Voyage</a></div>
                        </td>
                        <% } %>
                    </tr>
                   <%  } %>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

    <div class="col-md-4" >
        <div style="border-width:3px">
            <center> <h3 style="color: red;"> <%=voyage.getPrix()%> DH</h3>
                <div> Pour tout le trajet</div><br>

                </center>
        </div>
        <div class="modal fade" id="popUpWindow">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- header -->
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h3>contacter l'annonceur</h3>

                    </div>

                    <!-- body (form) -->
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group"><input type="text" class="form-control" name="receiver" value="To : ${annonce.annonceur.nom} ${annonce.annonceur.prenom}" disabled></div>
                            <div class="form-group">
									<textarea name="message" placeholder="votre message : " rows="8" cols="30" class="form-control">

									</textarea>
                            </div>
                        </form>
                    </div>

                    <!-- button -->
                    <div class="modal-footer">
                        <button class="btn btn-primary ">envoyer</button>
                    </div>

                </div>
            </div>
        </div>
        <br>
        <h3>Trajet</h3>
        <div id="map" style="height:350px; width: 360px;"></div><br><br>
        <div>
            <h3>Transporteur</h3>
            <div style="float:left;margin-right:25px;margin-left:5px" ><img class="img-circle" width="72" height="72" src=<c:url value="/resources/profilePic.png"/>> </div>
            <div style="margin-left:15px" >
                <div style="margin-left:15px">${annonce.annonceur.nom} ${annonce.annonceur.prenom}</div>
                <% if(Math.abs(ann.getAnnonceur().getLikes()-ann.getAnnonceur().getDislikes())>5){%>
                <div style="margin-left:15px"><img src="<c:url value="/resources/img/rating.png"/>"width="18px" height="20px">&nbsp;<img src="<c:url value="/resources/img/rating.png"/>"width="18px" height="20px">&nbsp;<img src="<c:url value="/resources/img/rating.png"/>" width="18px" height="20px">&nbsp;<img src="<c:url value="/resources/img/rating.png"/>" width="18px" height="20px"></div>
                <%}
                else
                {
                    int rate=Math.abs(ann.getAnnonceur().getLikes()-ann.getAnnonceur().getDislikes());
                    for(int o=0;o<rate;o++)
                    {

                %>
                <div style="margin-left:15px"><img src="<c:url value="/resources/img/rating.png"/>"width="18px" height="20px">&nbsp;
                    <%
                            }
                        }

                    %></div>
            </div>
            <div style="margin-left:10%">
                <div> <img src="<c:url value="/resources/img/verified.png"/>" width="18px" height="20px"> Confirme</div>
                <div> <img src="<c:url value="/resources/img/checked.png"/>" width="18px" height="20px"> Email verifie</div>
                <%--<div>${annonce.annonceur.nbrAnnonces} annonces publiees par ${annonce.annonceur.prenom}</div>--%>
                <div> Inscription : <%
                    date = sdf.format(ann.getAnnonceur().getDateInscription());
                %>
                <%=date%></div>
                <% request.setAttribute("annonce",ann);%>
                <div><a href="/loadClient/getClientById"> Voir Profile</a></div>

            </div>
            <div>
                <h3>Vehicule</h3>
                <div>
                    <div> <span class="inf">Marque:</span> ${annonce.annonceur.vehicule.marque}  </div>
                </div>
                <div> <span class="inf">Modele:</span> ${annonce.annonceur.vehicule.model}</div>
                <div> <span class="inf">Couleur:</span> ${annonce.annonceur.vehicule.couleur} </div>
                <div>
                </div>
            </div>
    </div>
</div>

</div>
<br/>
<br/>
<br/>
<br/>
<%@ include file="footer.jsp" %>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

</body>
</html>
