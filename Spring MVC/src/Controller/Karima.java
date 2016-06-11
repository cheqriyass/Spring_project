package Controller;

import Model.DAO.UserDaoImpl;
import Model.Entities.Annonce;
import Model.Entities.User;
import Model.DAO.AnnonceDaoImpl;
import com.mangopay.MangoPayApi;
import com.mangopay.core.Money;
import com.mangopay.core.enumerations.*;
import com.mangopay.entities.CardPreAuthorization;
import com.mangopay.entities.PayIn;
import com.mangopay.entities.Transfer;
import com.mangopay.entities.Wallet;
import com.mangopay.entities.subentities.*;
import junit.framework.Assert;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

import static junit.framework.Assert.assertEquals;
import static junit.framework.Assert.assertNotNull;
import static junit.framework.Assert.assertTrue;

/**
 * Created by Sam on 15/05/2016.
 */
@Controller
@RequestMapping(value = "/Annonce")
public class Karima {
    HttpServletRequest res;
    @RequestMapping(value = "/getAnnonceId")
    public String getAnnonceId(@RequestParam("id") int id,HttpServletRequest req, ModelMap model)
    {
        AnnonceDaoImpl dao = new AnnonceDaoImpl();
        Annonce annonce = dao.findById(id);

        List<String> destinations=new ArrayList<>();
        for(int i=0;i<annonce.getVoyageList().size();i++)
        {
            if(!destinations.contains(annonce.getVoyageList().get(i).getLieuDepart()) && !annonce.getVoyageList().get(i).getLieuDepart().equals(annonce.getLieuDepartInitial())
                    && !annonce.getVoyageList().get(i).getLieuDepart().equals(annonce.getLieuArriveeFinal()))
            {
                destinations.add(annonce.getVoyageList().get(i).getLieuDepart());
            }
        }

        model.addAttribute("destination",destinations);
        model.addAttribute("annonce",annonce);
        req.getSession().setAttribute("annonce",annonce);
        return "detailsAnnonce";
    }


//
//    @RequestMapping(value = "/AllAnnonces")
//    public String getAllAnnonces(ModelMap model)
//    {
//        AnnonceDaoImpl dao = new AnnonceDaoImpl();
//        List<Annonce> annonces = dao.selectAllAnnonces();
//
//        model.addAttribute("AllAnnonces",annonces);
//
//        return "AllAnnonces";
//    }


    @RequestMapping(value = "/reserver")
    public String reserverTrajer(@RequestParam("id") int id, HttpServletRequest req, ModelMap model)
    {

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (int i=0; i<cookies.length ; i++) {
                if (cookies[i].getName().equals("email")) {

                    UserDaoImpl dao = new UserDaoImpl();
                    User user = dao.findByUserName(cookies[i].getValue());
                    req.getSession().setAttribute("user", user);
                    break;
                }
            }
        }


        Annonce annonce=((Annonce)(req.getSession().getAttribute("annonce")));
        model.addAttribute("voyage",annonce.getVoyageList().get(id));
        model.addAttribute("annonce",annonce);
        model.addAttribute("id",id);
        return "reserver";
    }

    public int reserver(long idVoyage, User reserveur)
    {
        AnnonceDaoImpl dd=new AnnonceDaoImpl();

        return dd.reserverVoyage(idVoyage,reserveur);

    }

    @RequestMapping(value="/payer")
    public String payerTrajer(HttpServletRequest req, ModelMap model)
    {
        int res=reserver(Long.parseLong(req.getParameter("voyageid")),((Annonce)req.getSession().getAttribute("annonce")).getAnnonceur());
//        System.out.println((long)req.getSession().getAttribute("id"));
//        System.out.println(((Annonce)req.getSession().getAttribute("annonce")).getAnnonceur().getNom());
        if(res!=1)
            return "/reserver";
        System.out.println("+++++++++0"+ req.getParameter("prix"));

        AnnonceDaoImpl dao = new AnnonceDaoImpl();
        Annonce annonce = dao.findById(((Annonce)req.getSession().getAttribute("annonce")).getId());
        req.getSession().setAttribute("annonce",annonce);
        int price=0;
        try {
            price = (int)(Double.parseDouble(req.getParameter("prix")));
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("+++++++++1");
        User user = (User)req.getSession().getAttribute("user");
        MangoPayApi api = new MangoPayApi();
        api.Config.ClientId = "0102";
        api.Config.ClientPassword = "VVqf7iApr1WqAx8wU7zyMnzKNSJyVmva0vHOk0uiSknKTY0ujd";
        try {
            com.mangopay.entities.User john = api.Users.get(user.getAccountId());
            System.out.println("+++++++++2");

            Wallet wallet =api.Wallets.get(user.getWallet());
            //john.Tag = " - CHANGED";
            PayIn payIn = new PayIn();
            payIn.CreditedWalletId = wallet.Id;
            payIn.AuthorId = john.Id;
            payIn.DebitedFunds = new Money();
            payIn.DebitedFunds.Amount = price;
            payIn.DebitedFunds.Currency = CurrencyIso.EUR;
            payIn.Fees = new Money();
            payIn.Fees.Amount = 1;
            payIn.Fees.Currency = CurrencyIso.EUR;
            System.out.println("+++++++++" + wallet.Id + " " + john.Id + " " + price);

            payIn.PaymentDetails = new PayInPaymentDetailsDirectDebit();
            ((PayInPaymentDetailsDirectDebit)payIn.PaymentDetails).DirectDebitType = DirectDebitType.GIROPAY;
            payIn.ExecutionDetails = new PayInExecutionDetailsWeb();
            ((PayInExecutionDetailsWeb)payIn.ExecutionDetails).ReturnURL = "http://localhost:8080/cotransport/home";
            ((PayInExecutionDetailsWeb)payIn.ExecutionDetails).Culture = CultureCode.FR;
            ((PayInExecutionDetailsWeb)payIn.ExecutionDetails).TemplateURLOptions = new PayInTemplateURLOptions();
            //((PayInExecutionDetailsWeb)payIn.ExecutionDetails).TemplateURLOptions.PAYLINE = "http://localhost:8090/reserver.jsp";

            PayIn createPayIn = api.PayIns.create(payIn);

            assertNotNull(createPayIn.Id);
            assertEquals(wallet.Id, createPayIn.CreditedWalletId);
            assertTrue(createPayIn.PaymentType == PayInPaymentType.DIRECT_DEBIT);
            assertTrue(createPayIn.PaymentDetails instanceof PayInPaymentDetailsDirectDebit);
            assertTrue(((PayInPaymentDetailsDirectDebit)createPayIn.PaymentDetails).DirectDebitType == DirectDebitType.GIROPAY);
            assertTrue(createPayIn.ExecutionType == PayInExecutionType.WEB);
            assertTrue(createPayIn.ExecutionDetails instanceof PayInExecutionDetailsWeb);
            assertTrue(((PayInExecutionDetailsWeb)createPayIn.ExecutionDetails).Culture == CultureCode.FR);
            assertEquals(john.Id, createPayIn.AuthorId);
            assertTrue(createPayIn.Status == TransactionStatus.CREATED);
            assertTrue(createPayIn.Type == TransactionType.PAYIN);
            assertTrue(createPayIn.DebitedFunds instanceof Money);
            assertTrue(price == createPayIn.DebitedFunds.Amount);
            assertTrue(createPayIn.DebitedFunds.Currency == CurrencyIso.EUR);
            assertTrue(createPayIn.CreditedFunds instanceof Money);
            assertTrue((price - 1) == createPayIn.CreditedFunds.Amount);
            assertTrue(createPayIn.CreditedFunds.Currency == CurrencyIso.EUR);
            assertTrue(createPayIn.Fees instanceof Money);
            assertTrue(1 == createPayIn.Fees.Amount);
            assertTrue(createPayIn.Fees.Currency == CurrencyIso.EUR);
            assertNotNull(((PayInExecutionDetailsWeb)createPayIn.ExecutionDetails).ReturnURL);
            assertNotNull(((PayInExecutionDetailsWeb)createPayIn.ExecutionDetails).RedirectURL);
            assertNotNull(((PayInExecutionDetailsWeb)createPayIn.ExecutionDetails).TemplateURL);


        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
        System.out.println("+++++++++3");

        User trans = (User)req.getSession().getAttribute("transporteur");
        req.getSession().setAttribute("author",user.getAccountId());
        req.getSession().setAttribute("debId",user.getWallet());
        req.getSession().setAttribute("credId",trans.getWallet());
        req.getSession().setAttribute("dest",trans.getAccountId());
        req.getSession().setAttribute("money",price);

        System.out.println("+++++++++4");

        return "redirect:/Annonce/transfert";
    }

    @RequestMapping(value="/transfert")
    public String Transfer(HttpServletRequest req) throws Exception {
        HttpSession sess=req.getSession();
        System.out.println("+++++++++5");

        System.out.println("******debId = " + sess.getAttribute("debId"));
        System.out.println("******money = " + sess.getAttribute("money"));

        MangoPayApi api = new MangoPayApi();
        api.Config.ClientId = "0102";
        api.Config.ClientPassword = "VVqf7iApr1WqAx8wU7zyMnzKNSJyVmva0vHOk0uiSknKTY0ujd";
        System.out.println((String)sess.getAttribute("debId"));
        try {
            com.mangopay.entities.User john = api.Users.get((String)sess.getAttribute("author"));
            Wallet wallet = api.Wallets.get((String)sess.getAttribute("debId"));
            Transfer transfer = new Transfer();
            transfer.Tag = "DefaultTag";
            transfer.AuthorId = john.Id;
            transfer.CreditedUserId = (String)sess.getAttribute("dest");
            transfer.DebitedFunds = new Money();
            transfer.DebitedFunds.Currency = CurrencyIso.EUR;
            transfer.DebitedFunds.Amount = (Integer) sess.getAttribute("money");
            transfer.Fees = new Money();
            transfer.Fees.Currency = CurrencyIso.EUR;
            transfer.Fees.Amount = 0;

            transfer.CreditedWalletId = (String)sess.getAttribute("credId");
            transfer.DebitedWalletId = wallet.Id;


            Transfer transferr = api.Transfers.create(transfer);
            ;
            Wallet creditedWallet = api.Wallets.get(transferr.CreditedWalletId);

            assertTrue(transferr.Id.length() > 0);
            assertEquals(transferr.AuthorId, john.Id);
            assertEquals(transferr.CreditedUserId, john.Id);
            //assertTrue(creditedWallet.Balance.Amount == 100);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return "detailsAnnonce";
    }

}
