package Controller;

import Model.JsonResponse;
import Model.forms.UserForm;
import Model.inscriptionValidator;
import Model.DAO.UserDaoImpl;
import Model.Entities.User;
import Model.Entities.Vehicule;
import com.mangopay.MangoPayApi;
import com.mangopay.core.Address;
import com.mangopay.core.enumerations.CountryIso;
import com.mangopay.core.enumerations.CurrencyIso;
import com.mangopay.core.enumerations.PersonType;
import com.mangopay.entities.UserNatural;
import com.mangopay.entities.Wallet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static junit.framework.Assert.assertTrue;

@Controller
public class SignUpController {


    @Autowired
    inscriptionValidator validator;

    @RequestMapping(value="/inscription", method = RequestMethod.GET)
    public String viewRegistration(ModelMap model) {

        if (!model.containsKey("userForm")) {
            UserForm userForm = new UserForm();
            model.put("userForm", userForm);
        }

        return "SignUpForm";
    }



    @RequestMapping(value = "/ajaxinscription", method = RequestMethod.POST)
    public @ResponseBody
    JsonResponse validateForm(@RequestBody UserForm userForm, BindingResult result) {

        validator.validate(userForm,result);

        JsonResponse response = new JsonResponse();

        List<String> errors = response.getErrors();

        if(result.hasErrors() ) {
            for (Object object : result.getAllErrors()) {
                if (object instanceof FieldError) {
                    FieldError fieldError = (FieldError) object;
                    String message = fieldError.getDefaultMessage();
                    String st = fieldError.getField() + "#" + message;
                    errors.add(st);
                }
            }
            response.setStatus("Fail");
            response.setErrors(errors);

        }
        else
            response.setStatus("Success");


        return response;
    }


    @RequestMapping(value="/sinscrir", method = RequestMethod.POST)
    public String sinscrir(@ModelAttribute("userForm") UserForm userForm, ModelMap model) {

        Vehicule vehicule = new Vehicule(userForm.getMarque(), userForm.getModel(), userForm.getCouleur());
        Date Bdate = null;
        SimpleDateFormat sdf= new SimpleDateFormat("dd-MM-yyyy");
        try {
             Bdate = sdf.parse( userForm.getBdate() );
        } catch (ParseException e) {
            e.printStackTrace();
        }

        User user = new User(userForm.getPass(), userForm.getFname(),userForm.getLname(), userForm.getEmail(), userForm.getSex(),
                userForm.getPhone(), userForm.getAddress(), userForm.getDescription(), Bdate, vehicule);

        user.setDateInscription(new Date());

        System.out.println("user = " + user.getDateNaissance());
        System.out.println("user = " + user.getDateInscription());

        List<String> list = null;
        try {
            list = createUser(user.getNom(), user.getPrenom(), userForm.getEmail());
        } catch (Exception e) {
            e.printStackTrace();
        }

        user.setWallet(list.get(1));
        user.setAccountId(list.get(0));

        UserDaoImpl dao = new UserDaoImpl();
        dao.insert(user);

        return "RegistrationSuccess";
    }



    public List<String> createUser(String nom, String prenom, String email) throws Exception {
        MangoPayApi api = new MangoPayApi();
        api.Config.ClientId = "0102";
        api.Config.ClientPassword = "VVqf7iApr1WqAx8wU7zyMnzKNSJyVmva0vHOk0uiSknKTY0ujd";
        List<String> list = new ArrayList<>();
        Calendar c = Calendar.getInstance();
        c.set(1975, 13, 21, 0, 0, 0);

        UserNatural user = new UserNatural();
        user.FirstName = prenom;
        user.LastName =  nom;
        user.Email = email;
        Address result = new Address();
        //adresse
        result.AddressLine1 = "Address line 1";
        result.AddressLine2 = "Address line 2";
        result.City = "City";
        result.Country = CountryIso.PL;
        result.PostalCode = "11222";
        result.Region = "Region";

        user.Address = result;
        user.Birthday = c.getTimeInMillis() / 1000;
        user.Nationality = CountryIso.FR;
        user.CountryOfResidence = CountryIso.FR;
        user.Occupation = "programmer";
        user.IncomeRange = 3;

        UserNatural john = (UserNatural)api.Users.create(user);

        assertTrue(john.Id.length() > 0);
        assertTrue(john.PersonType.equals(PersonType.NATURAL));

        //createWallet
        Wallet wallet = new Wallet();
        wallet.Owners = new ArrayList<>();
        wallet.Owners.add(john.Id);

        wallet.Currency = CurrencyIso.EUR;
        wallet.Description = "WALLET IN EUR";

        Wallet wallett=api.Wallets.create(wallet);
        assertTrue(wallett.Id.length() > 0);
        assertTrue(wallett.Owners.contains(john.Id));

        list.add(john.Id);
        list.add(wallett.Id);
        //john=user;


        return list;
    }
}