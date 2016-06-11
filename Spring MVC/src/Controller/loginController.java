package Controller;

import Model.DAO.UserDaoImpl;
import Model.Entities.User;
import Model.forms.UserForm;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Controller
public class loginController {

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

    @RequestMapping(value="/home", method = RequestMethod.GET)
    public String viewHome(ModelMap model) {

        model.put("villes", vill());

        return "home";
    }


    @RequestMapping(value="/login", method = RequestMethod.GET)
    public String viewLogin(ModelMap model) {
        return "loginForm";
    }


    @RequestMapping(value="/dologin", method = RequestMethod.POST)
    public String login(HttpServletResponse res, HttpServletRequest req, @RequestParam("email") String email, @RequestParam("pass") String password, ModelMap model){

        String st = req.getParameter("email");
        UserDaoImpl dao = new UserDaoImpl();
        User user = dao.findByCredentials(st,password);

        model.remove("loginerror");
        model.addAttribute("email",st );

        if (user==null){
            model.addAttribute("loginerror", "email or password incorrect!");
            return "loginForm";
        }

        Cookie cookie = new Cookie("email", email);
        cookie.setMaxAge(60*60*24*30);
        res.addCookie(cookie);

        req.getSession().setAttribute("user",user);

        return "redirect:/home";
    }


}
