package Model;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

@Component
public class UserValidator implements Validator {

    public boolean supports(Class clazz) {
        return User.class.isAssignableFrom(clazz);
    }

    public void validate(Object target, Errors errors) {
        User userForm = (User) target;
        if (StringUtils.isBlank(userForm.getUsername()))
            errors.rejectValue("username", "username.required");

        if (StringUtils.isBlank(userForm.getPassword()))
            errors.rejectValue("password", "password.required");
        else if (userForm.getPassword().trim().length() < 6)
            errors.rejectValue("password", "password.size");

        if (StringUtils.isBlank(userForm.getEmail()))
            errors.rejectValue("email", "email.required");
        else if (!Pattern.matches("[a-zA-Z0-9].*@.*", userForm.getEmail()))
            errors.rejectValue("email", "email.invalid");

        if (StringUtils.isBlank(userForm.getBirthDate()))
            errors.rejectValue("birthDate", "birthDate.required");
        else {
            DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
            try {
                df.parse(userForm.getBirthDate());
            } catch (Exception ex) {
                errors.rejectValue("birthDate", "birthDate.invalid");
            }
        }
    }

}