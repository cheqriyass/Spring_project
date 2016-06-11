<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registration</title>

    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
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
            background-color: #edeff2;

        }

        body {
            background-color: #edeff2;
            font-family: montserrat, arial, verdana;
        }


    </style>
</head>


<body>

<%@ include file="navbar.jsp" %>


<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="tableaudebord">
                <div class="contact_container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <h2>Publier une annonce</h2> <br/><br/>
                            <div class="nb_com" style="display:none">9</div>
                        </div>
                    </div>
                </div>

                <div class='container'>
                    <div class='row'>


                        <form class="form-horizontal" role="form" action="/cotransport/publierAnnonce" method="post">
                            <div class='row'>

                                <div class="col-lg-6">
                                    <!--<form class="form-horizontal" role="form">-->
                                    <div class="form-group">
                                        <label for="categorie" class="col-sm-3 control-label">Categorie </label>
                                        <div class="col-sm-8">
                                            <select class="form-control" name="categorie" id="categorie">
                                                ${categorie}
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="depart" class="col-sm-3 control-label">Ville de depart </label>
                                        <div class="col-sm-8">
                                            <select class="form-control" name="depart" id="depart">
                                                ${villes}
                                            </select>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label for="ddepart" class="col-sm-3 control-label">Date de depart</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="ddepart" id="ddepart"
                                                   placeholder="dd-MM-YYYY HH:mm">
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label for="arrive" class="col-sm-3 control-label">Ville d'arrivée </label>
                                        <div class="col-sm-8">
                                            <select class="form-control" name="arrive" id="arrive">
                                                ${villes}
                                            </select>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label for="prix" class="col-sm-3 control-label">Prix </label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="prix" id="prix">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="nbrPlace" class="col-sm-3 control-label">nbr de places </label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="nbrPlace" id="nbrPlace">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="retard" class="col-sm-3 control-label">Retard Accepté </label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="retard" id="retard">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="taille" class="col-sm-3 control-label">Taille du paquet </label>
                                        <div class="col-sm-8">
                                            <select class="form-control" name="taille" id="taille">
                                                <option value="0">Selectionner une taille</option>
                                                <option value="grand">grand</option>
                                                <option value="moyen">moyen</option>
                                                <option value="petit">petit</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="description" class="col-sm-3 control-label">Description </label>
                                        <div class="col-sm-8">
                                            <textarea class="form-control" name="description"
                                                      id="description"></textarea>
                                        </div>
                                    </div>


                                    <%--<div class="form-group">--%>
                                    <%--<span class="col-sm-3 control-label"></span>--%>
                                    <%--<div class="col-sm-8">--%>
                                    <%--<label class="checkbox inline no_indent">--%>
                                    <%--<input type="checkbox" id="auto" value="auto"> Autoroute--%>
                                    <%--</label>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>

                                </div>


                                <div class="col-lg-6">
                                    <span class="col-sm-4 control-label"></span>
                                    <div class="form-group">
                                        <input type="button" name="ajouterarret" onclick="ajouterArret()"
                                               value="Ajouter un arret intermediaire" class="btn btn-success">
                                    </div>

                                    <div id="arret">
                                    </div>

                                    <input type="hidden" name="nbrArret" id="nbrArret" value="0">

                                </div>


                            </div>


                            <br/><br/>
                            <br/><br/>

                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="boutton">
                                        <div class="col-lg-5 col-md-7 hidden-md hidden-xs"></div>
                                        <div class="col-lg-1 col-md-1 col-xs-12">
                                            <input type="submit" name="submit" value="Publier Annonce"
                                                   class="btn btn-primary">
                                        </div>

                                    </div>
                                </div>
                            </div>

                        </form>

                        <br/><br/>
                        <br/><br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="application/javascript">


    function ajouterArret() {

        var x = document.getElementById("depart");
        var i;

        var div = document.getElementById('arret');
        var hid = document.getElementById('nbrArret');

        var nbr = hid.value;
        nbr = parseInt(nbr) + 1;

        var nwdiv = '';

        nwdiv += '<div class="form-group">';
        nwdiv += '    <label for="depart" class="col-sm-3 control-label">Arret ' + nbr + ' </label>';
        nwdiv += '    <div class="col-sm-5">';
        nwdiv += '        <select class="form-control" name="arret' + nbr + '">';
        for (i = 0; i < x.length; i++) {
            nwdiv += '<option value="' + x.options[i].value + '">' + x.options[i].text + '</option>';
        }
        nwdiv += '        </select>';
        nwdiv += '    </div>';
        nwdiv += '    <div class="col-sm-3">';
        nwdiv += '    <input type="text" class="form-control" name="prix' + nbr + '" placeholder="prix">';
        nwdiv += '    </div>';
        nwdiv += '</div>';

        div.innerHTML = div.innerHTML + nwdiv;

        hid.value = nbr;
    }

</script>


</body>
</html>

