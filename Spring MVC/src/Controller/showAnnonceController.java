package Controller;


import Model.DAO.AnnonceDaoImpl;
import Model.DAO.UserDaoImpl;
import Model.Entities.Annonce;
import Model.Entities.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class showAnnonceController {

    @RequestMapping(value = "/userAnnonce", method = RequestMethod.GET)
    public String viewUserAnnonces(HttpServletRequest req, ModelMap model) {

        int id = Integer.parseInt(req.getParameter("id"));

        UserDaoImpl userDao = new UserDaoImpl();
        User user = userDao.findById(id);

        AnnonceDaoImpl annonceDao = new AnnonceDaoImpl();
        List<Annonce> annonceList = annonceDao.findAll();

        req.getSession().setAttribute("annonceList", annonceList);


        model.put("categorie", cate());

        return "allAnnonce";
    }

    @RequestMapping(value = "/allannonce", method = RequestMethod.GET)
    public String viewAlAnnonce(HttpServletRequest req, ModelMap model) {


        AnnonceDaoImpl annonceDao = new AnnonceDaoImpl();
        List<Annonce> annonceList = annonceDao.findAll();

        req.getSession().setAttribute("annonceList", annonceList);



        model.put("villes", vill());

        model.put("categorie", cate());

        return "allAnnonce";
    }




    @RequestMapping(value = "/rechercheAnnonce", method = RequestMethod.POST)
    public String rechercher(HttpServletRequest req, ModelMap model) throws ParseException {


        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String depart = req.getParameter("depart");
        String arrive = req.getParameter("arrive");
        Date ddepart = sdf.parse(req.getParameter("ddepart"));
        String cat = req.getParameter("categorie");
        double prixmin = Double.parseDouble(req.getParameter("prixmin"));
        double prixmax = Double.parseDouble(req.getParameter("prixmax"));

        AnnonceDaoImpl annonceDao = new AnnonceDaoImpl();
        List<Annonce> annonceList = annonceDao.findByInfo(depart, arrive, ddepart, cat, prixmin, prixmax);

        req.getSession().setAttribute("annonceList", annonceList);


        model.put("categorie", cate());

        return "allAnnonce";
    }




    public String cate() {
        Map<String, String> categorie = new HashMap<String, String>();
        categorie.put("Mobilier", "Mobilier");
        categorie.put("Fragiles", "Fragiles");
        categorie.put("Animaux", "Animaux");
        categorie.put("Agro-Alimentaire", "Agro-Alimentaire");
        categorie.put("Divers", "Divers");

        StringBuilder st2 = new StringBuilder();

        st2.append("<option value=\"0\">Categorie</option>");

        for (Map.Entry<String, String> e : categorie.entrySet()) {
            st2.append("<option value=\"" + e.getValue() + "\">" + e.getKey() + "</option>");
        }

        return st2.toString();
    }

    public String vill() {
        Map<String, String> villes = new HashMap<String, String>();
        villes.put("Casablanca", "Casablanca");
        villes.put("Rabat", "Rabat");
        villes.put("Marrakech", "Marrakech");
        villes.put("El Jadida", "El Jadida");
        villes.put("Tanger", "Tanger");
        villes.put("Meknes", "Meknes");

        StringBuilder st2 = new StringBuilder();


        for (Map.Entry<String, String> e : villes.entrySet()) {
            st2.append("<option value=\"" + e.getValue() + "\">" + e.getKey() + "</option>");
        }

        return st2.toString();
    }



    @RequestMapping(value = "/mesAnnonce", method = RequestMethod.GET)
    public String ShowUserAnnonce(HttpServletRequest req, ModelMap model) throws ParseException {


        int id = Integer.parseInt(req.getParameter("id"));
        AnnonceDaoImpl dao = new AnnonceDaoImpl();
        List<Annonce> list = dao.findByAnnonceurId(id);

        req.getSession().setAttribute("annonceList", list);

        return "UserAnnonce";
    }



    @RequestMapping(value = "/homeSearch", method = RequestMethod.POST)
    public String homeSearch(HttpServletRequest req, ModelMap model) throws ParseException {

        String depart = req.getParameter("depart");
        String arrive = req.getParameter("arrive");

        AnnonceDaoImpl dao = new AnnonceDaoImpl();
        List<Annonce> list = dao.findByVilles(depart,arrive);

        req.getSession().setAttribute("annonceList", list);

        return "allAnnonce";
    }


}