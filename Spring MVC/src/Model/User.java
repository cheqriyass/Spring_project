package Model;

//import org.hibernate.validator.constraints.NotEmpty;
//import javax.validation.constraints.Pattern;
//import javax.validation.constraints.Size;

import java.util.Date;

public class User {
//    @NotEmpty(message="{username.required}")
    private String username;
//    @NotEmpty(message="{password.required}")
//    @Size(min = 6,message="{password.size}")
    private String password;
//    @NotEmpty(message = "{email.required}")
//    @Pattern(regexp=".+@.+\\.[a-z]+", message = "{email.invalid}")
    private String email;
    private String birthDate;
    private String profession;



    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }
}
