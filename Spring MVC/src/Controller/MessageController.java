package Controller;


import Model.DAO.AnnonceDaoImpl;
import Model.DAO.MessageDaoImpl;
import Model.DAO.UserDaoImpl;
import Model.Entities.Annonce;
import Model.Entities.Contacts;
import Model.Entities.Message;
import Model.Entities.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.*;

@Controller
public class MessageController {

    @RequestMapping(value = "/sendMessage", method = RequestMethod.POST)
    public String sendMessage(HttpServletRequest req, ModelMap model) throws ParseException {

        int receiverId = Integer.parseInt(req.getParameter("receiver"));
        String senderEmail = req.getParameter("sender");
        String message = req.getParameter("message");

        UserDaoImpl dao = new UserDaoImpl();
        User receiver = dao.findById(receiverId);
        User sender = dao.findByUserName(senderEmail);


        Message mess = new Message();
        mess.setEmetteur(sender);
        mess.setRecepteur(receiver);
        mess.setMessage(message);
        mess.setDateMsg(new Date());
        mess.setEtat(true);

        MessageDaoImpl messageDao = new MessageDaoImpl();
        messageDao.insert(mess);

        return "sendSuccess";
    }


    @RequestMapping(value = "/mymessage", method = RequestMethod.GET)
    public String mymessage(HttpServletRequest req, ModelMap model) throws ParseException {

        int id = Integer.parseInt(req.getParameter("id"));
        int otherid=0;

        if (req.getParameter("otherid")!=null)
            Integer.parseInt(req.getParameter("otherid"));


        MessageDaoImpl messageDao = new MessageDaoImpl();
        List<Message> list = messageDao.getMessage(id);

        Set<Integer> set = new HashSet<>();
        int x;
        for (Message m : list) {
            x = (int)m.getEmetteur().getId();
            if (x != id)
                set.add(x);
            x =(int)m.getRecepteur().getId();
            if (x != id)
                set.add(x);

        }


        UserDaoImpl userDao = new UserDaoImpl();
        User user = null;

        List<Contacts> contacts = new ArrayList<>();
        for (Integer i: set) {
            user = userDao.findById(i);
            contacts.add(new Contacts(user.getId(), (user.getPrenom() + " " + user.getNom())));
        }


        if(otherid != 0){
            list = messageDao.getConv(id,otherid);
        }else{
            list = messageDao.getConv(id,(int)contacts.get(0).getId());
        }


        req.getSession().setAttribute("messages", list);
        req.getSession().setAttribute("contacts", contacts);
        req.getSession().setAttribute("id", id);

        return "mymessages";
    }


}
