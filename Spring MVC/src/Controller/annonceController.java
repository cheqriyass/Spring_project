package Controller;

import Model.DAO.AnnonceDaoImpl;
import Model.DAO.UserDaoImpl;
import Model.Entities.Annonce;
import Model.Entities.User;
import Model.Entities.Voyage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
public class annonceController {
    @RequestMapping(value = "/addAnnonce", method = RequestMethod.GET)
    public String AnnonceForm(ModelMap model) {

        Map<String, String> villes = new HashMap<String, String>();
        villes.put("Casablanca", "Casablanca");
        villes.put("Rabat", "Rabat");
        villes.put("Marrakech", "Marrakech");
        villes.put("El Jadida", "El Jadida");
        villes.put("Tanger", "Tanger");
        villes.put("Meknes", "Meknes");

        model.put("villes", villes);


        Map<String, String> categorie = new HashMap<String, String>();
        categorie.put("Mobilier", "Mobilier");
        categorie.put("Fragiles", "Fragiles");
        categorie.put("Animaux", "Animaux");
        categorie.put("Agro-Alimentaire", "Agro-Alimentaire");
        categorie.put("Divers", "Divers");


        StringBuilder st1 = new StringBuilder();

        st1.append("<option value=\"0\">Selectionner une ville</option>");

        for (Map.Entry<String, String> e : villes.entrySet()) {
            st1.append("<option value=\"" + e.getValue() + "\">" + e.getKey() + "</option>");
        }

        model.put("villes", st1.toString());


        StringBuilder st2 = new StringBuilder();

        st2.append("<option value=\"0\">Selectionner une categorie</option>");

        for (Map.Entry<String, String> e : categorie.entrySet()) {
            st2.append("<option value=\"" + e.getValue() + "\">" + e.getKey() + "</option>");
        }
        model.put("categorie", st2.toString());


        return "PublierAnnonce";
    }


    @RequestMapping(value = "/publierAnnonce", method = RequestMethod.POST)
    public String publier(HttpServletRequest req) {

        Random rand = new Random();
        Annonce annonce = new Annonce();

        Cookie[] cookies = req.getCookies();
        String email = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("email")) {
                    email = cookie.getValue();
                }
            }
        }

        UserDaoImpl dao = new UserDaoImpl();
        User user = dao.findByUserName(email);

        annonce.setAnnonceur(user);
        annonce.setCategorie(req.getParameter("categorie"));
        annonce.setLieuDepartInitial(req.getParameter("depart"));
        annonce.setLieuArriveeFinal(req.getParameter("arrive"));
        annonce.setPrix(Double.parseDouble(req.getParameter("prix")));

        Date date = new Date();
        annonce.setDatePublication(date);
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
        try {
            date = sdf.parse(req.getParameter("ddepart"));
            annonce.setDateDepart(date);
            annonce.setDescription(req.getParameter("description"));
            annonce.setTotalPlaces(Integer.parseInt(req.getParameter("nbrPlace")));
            annonce.setTaillePaquet(req.getParameter("taille"));
            annonce.setRetardAccepte(Integer.parseInt(req.getParameter("retard")));
            annonce.setDuree(rand.nextInt(300 - 30 + 1) + 30);

        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<Voyage> voyageList = annonce.getVoyageList();

        int nbr = Integer.parseInt(req.getParameter("nbrArret"));



        Voyage voyage;


        if (nbr != 0){

            voyage = new Voyage();
            //first case
            voyage.setLieuDepart(annonce.getLieuDepartInitial());
            voyage.setLieuArrivee(req.getParameter("arret" + 1));
            voyage.setPrix(Double.parseDouble(req.getParameter("prix" + 1)));
            voyage.setDureeEstimee(rand.nextInt(120 - 30 + 1) + 30);
            voyage.setDistance(rand.nextInt(400 - 100 + 1) + 100);
            voyage.setAnnonce(annonce);
            voyageList.add(voyage);
            //intermediate

            for (int i = 1; i < nbr; i++) {
                Voyage tmp = voyageList.get(i - 1);
                voyage = new Voyage();
                voyage.setLieuDepart(tmp.getLieuArrivee());
                System.out.println("******* arret = " + req.getParameter("arret" + (i+1)));
                voyage.setLieuArrivee(req.getParameter("arret" + (i+1)));
                System.out.println("******* prix = " + req.getParameter("prix" + (i+1)));
                voyage.setPrix(Double.parseDouble(req.getParameter("prix" + (i+1))));
                voyage.setDureeEstimee(rand.nextInt(120 - 30 + 1) + 30);
                voyage.setDistance(rand.nextInt(400 - 100 + 1) + 100);
                voyage.setAnnonce(annonce);
                voyageList.add(voyage);
            }

//            //last case
//            Voyage tmp = voyageList.get(nbr - 1);
//            voyage = new Voyage();
//            voyage.setLieuDepart(tmp.getLieuArrivee());
//            voyage.setLieuArrivee(req.getParameter(annonce.getLieuArriveeFinal()));
//            voyage.setPrix(Double.parseDouble(req.getParameter("prix" + nbr)));
//            voyage.setDureeEstimee(rand.nextInt(120 - 30 + 1) + 30);
//            voyage.setDistance(rand.nextInt(400 - 100 + 1) + 100);
//            voyage.setAnnonce(annonce);
//            voyageList.add(voyage);

        }

        voyage = new Voyage();
        voyage.setLieuDepart(annonce.getLieuDepartInitial());
        voyage.setLieuArrivee(annonce.getLieuArriveeFinal());
        voyage.setPrix(Double.parseDouble(req.getParameter("prix")));
        voyage.setDureeEstimee(rand.nextInt(120 - 30 + 1) + 30);
        voyage.setDistance(rand.nextInt(400 - 100 + 1) + 100);
        voyage.setAnnonce(annonce);
        voyageList.add(voyage);


        AnnonceDaoImpl annonceDao = new AnnonceDaoImpl();
        annonceDao.insert(annonce);

        return "PublicationSuccess";
    }




}
