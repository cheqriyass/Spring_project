package Controller;

import Model.User;
import Model.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/register")
public class RegisterController {


    @Autowired
    UserValidator validator;

    @RequestMapping(method = RequestMethod.GET)
    public String viewRegistration(ModelMap model) {

        if (!model.containsKey("userForm")) {
            User userForm = new User();
            model.put("userForm", userForm);
        }

        model.put("professionList", loadProfessionList());

        return "Registration";
    }


    @RequestMapping(method = RequestMethod.POST)
    public String processRegistration(@ModelAttribute("userForm") User userForm, BindingResult result, ModelMap model) {

        validator.validate(userForm,result);

        if (result.hasErrors()) {
            model.put("professionList", loadProfessionList());
            return "Registration";
        }

        return "RegistrationSuccess";
    }



    private List<String> loadProfessionList(){
        List<String> professionList = new ArrayList<>();
        professionList.add("Developer");
        professionList.add("Developer");
        professionList.add("Designer");
        professionList.add("IT Manager");
        return professionList;
    }
}