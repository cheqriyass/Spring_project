<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ page import="Model.Entities.Annonce" %>
<%@ page import="Model.Entities.Voyage" %>
<%@ page import="Model.Entities.User" %><%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 09/06/2016
  Time: 00:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <%--<link rel="stylesheet" href="style1.css">--%>

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous">
    <link href="<c:url value="/resources/ListAdscopy.css"/>" rel="stylesheet" type="text/css">


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <title>reserver voyage</title>
    <style>
        @import url(http://fonts.googleapis.com/css?family=Montserrat);
        body {
            /*background-color: #eeeeee;*/
            font-family: montserrat, arial, verdana;
        }

        .inf{
            float: left;
            margin-right: 10px;
            color: seagreen;
        }
    </style>

    <script>
        function initMap() {
            //alert("${destination.size()}");
            var directionsService = new google.maps.DirectionsService;
            var directionsDisplay = new google.maps.DirectionsRenderer;
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 8,
                center: {lat: 31.63179, lng: -7.98926}
            });
            directionsDisplay.setMap(map);

            <%--if ("${destination.size()}" > 0)--%>
            <%--calculateAndDisplayRoute(directionsService, directionsDisplay, "${destination}");--%>
            <%--else--%>
            calculateAndDisplayRoute2(directionsService, directionsDisplay);


        }

        function calculateAndDisplayRoute(directionsService, directionsDisplay, destinations) {
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
            }, function (response, status) {
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
                origin: "${voyage.lieuDepart}",
                destination: "${voyage.lieuArrivee}",
                travelMode: google.maps.TravelMode.DRIVING
            }, function (response, status) {
                if (status === google.maps.DirectionsStatus.OK) {
                    directionsDisplay.setDirections(response);
                } else {
                    window.alert('Directions request failed due to ' + status);
                }
            });
        }
    </script>
    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBr4rYLJirubQX8aZgF6I-7ylwCzSzrMJ8&callback=initMap">
    </script>
</head>
<body>
<%

    Annonce ann = (Annonce) session.getAttribute("annonce");

    if (request.getAttribute("voyage") != null)
        session.setAttribute("id", ((Voyage) request.getAttribute("voyage")).getId());

    session.setAttribute("id", ((Voyage) request.getAttribute("voyage")).getPrix());
%>
<%@ include file="navbar.jsp" %>

<%

    if (session.getAttribute("transporteur") != null) {
        session.setAttribute("transporteur", null);
%>

<div class="container">
    <div class="alert alert-success">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        Erreur lors du paiement, veuillez ressayer plus tard ou recharger votre compte <a href="#">içi</a> !
    </div>
</div>
<% }%>
<div class="container">
    <br>
    <div class="col-md-8">

        <div>
            <h2>Recapitulatif Voyage</h2>
            <hr>
            <div>
                <div class="inf">Lieu Depart: </div>
                <div> ${voyage.lieuDepart}</div>
            </div>
            <div>
                <div class="inf">Lieu Arrivé: </div>
                <div> ${voyage.lieuArrivee}</div>
            </div>
            <div>
                <div class="inf">date Depart: </div>
                <div> ${annonce.dateDepart}</div>
            </div>
            <div>
                <div class="inf">distance estiméé: </div>
                <div> ${voyage.distance} Km</div>
            </div>
            <div>
                <div class="inf">durée estimée: </div>
                <div> ${voyage.dureeEstimee}</div>
            </div>
        </div>
        <br><br>
        <div>
            <h2>Recapitulatif Paiement</h2>
            <hr>
            <div>
                <div class="inf"><strong>Réserveur:</strong></div>
                <div><%=((User) session.getAttribute("user")).getPrenom()%> <%=((User) session.getAttribute("user")).getNom()%>
                </div>
            </div>
            <div>
                <div class="inf">Transporteur: </div>
                <div> ${annonce.annonceur.nom} ${annonce.annonceur.prenom}</div>
            </div>
            <div>
                <div class="inf">monnaie utilisé: </div>
                <div> &nbsp;&nbsp;DH</div>
            </div>
            <div>
                <div class="inf">Total à payer: </div>
                <div> ${voyage.prix} DH</div>
            </div>
            <div>
                <div class="inf">Frais Réservation: </div>
                <div> 5 DH</div>
            </div>
        </div>
        <br><br>

        <div><br><br>
            <div class="modal-footer">
                <a href="/cotransport/Annonce/getAnnonceId?id=<%=ann.getId()%>" class="btn btn-danger">Annuler Reservation</a>

                <%session.setAttribute("transporteur", ((Annonce) request.getAttribute("annonce")).getAnnonceur());%>
                <a href='/cotransport/Annonce/payer?prix=${voyage.prix}&voyageid=${voyage.id}' class="btn btn-success"><span
                        class="badge pull-left"><label class="glyphicon glyphicon-ok"></label></span>
                    &nbsp;&nbsp;Payer ${voyage.prix} DH </a>
            </div>
        </div>


    </div>


    <div class="col-md-4">
        <h2> Trajet</h2>
        <div id="map" style="height:350px; width: 360px;"></div>
        <br><br>

    </div>
</div>
<br/>
<br/>
<br/>
<br/>
<%@ include file="footer.jsp" %>

</body>
</html>
