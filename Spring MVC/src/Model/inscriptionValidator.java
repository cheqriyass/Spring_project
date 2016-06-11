package Model;

import Model.forms.UserForm;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class inscriptionValidator implements Validator {

    EmailValidator emailValidator = new EmailValidator();

    public boolean supports(Class clazz) {
        return UserForm.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        UserForm userForm = (UserForm) target;
        if (userForm.getStep().equals("1")){
            if (StringUtils.isBlank(userForm.getEmail()))
                errors.rejectValue("email", "email.required","Email is required");
            else {
                if (!emailValidator.validate(userForm.getEmail()))
                errors.rejectValue("email", "email.required", "Not a valid email");
            }


            if (StringUtils.isBlank(userForm.getPass()))
                errors.rejectValue("pass", "password.required","Password is required");
            else if (userForm.getPass().trim().length() < 6)
                errors.rejectValue("pass", "password.size","Password should be at least 6 characters");
            else {
                if (StringUtils.isBlank(userForm.getPassc()))
                    errors.rejectValue("passc", "email.required","Please confirm your password");
                else if (!userForm.getPassc().equals(userForm.getPass()))
                    errors.rejectValue("passc", "email.required","Password confirmation error");

            }

        }

        else if (userForm.getStep().equals("2")){
            if (StringUtils.isBlank(userForm.getFname()))
                errors.rejectValue("fname", "email.required","First name is required");
        }

    }

}