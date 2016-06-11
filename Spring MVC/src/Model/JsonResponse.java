package Model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class JsonResponse implements Serializable{

    private String status = "";
    private List<String> errors = new ArrayList<>();

    public JsonResponse() {
    }

    public JsonResponse(String status, List<String> errorMessage) {
        this.status = status;
        this.errors = errorMessage;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public List<String> getErrors() {
        return errors;
    }

    public void setErrors(List<String> errors) {
        this.errors = errors;
    }
}
