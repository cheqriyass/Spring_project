package Controller;

import Model.DAO.UserDaoImpl;
import Model.Entities.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;

@Controller
public class UserController {

    @RequestMapping(value = "/showProfile", method = RequestMethod.GET)
    public String showProfile(HttpServletRequest req, ModelMap model) throws ParseException {

        int id =  Integer.parseInt(req.getParameter("id"));
        UserDaoImpl dao = new UserDaoImpl();
        User user = dao.findById(id);

        req.getSession().setAttribute("prof", user);

        return "profile";
    }

    @RequestMapping(value = "/myprofile", method = RequestMethod.GET)
    public String myprofile(HttpServletRequest req, ModelMap model) throws ParseException {

        int id =  Integer.parseInt(req.getParameter("id"));
        UserDaoImpl dao = new UserDaoImpl();
        User user = dao.findById(id);

        req.getSession().setAttribute("myprof", user);
        return "monProfile";
    }

    @RequestMapping(value = "/signout", method = RequestMethod.GET)
    public String signout(HttpServletRequest req, HttpServletResponse res, ModelMap model)  {

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (int i=0; i<cookies.length ; i++) {
                if (cookies[i].getName().equals("email")) {
                    cookies[i].setValue("");
                    res.addCookie(cookies[i]);
                    break;
                }
            }
        }

        return "home";
    }





}
