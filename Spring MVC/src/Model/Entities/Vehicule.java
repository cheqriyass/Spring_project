package Model.Entities;

import javax.persistence.Embeddable;

/**
 * Created by Sam on 29/04/2016.
 */
@Embeddable
public class Vehicule {

    private String marque, model, couleur;

    public Vehicule() {
    }

    public Vehicule(String marque, String model, String couleur) {
        this.marque = marque;
        this.model = model;
        this.couleur = couleur;
    }

    public String getMarque() {
        return marque;
    }

    public void setMarque(String marque) {
        this.marque = marque;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getCouleur() {
        return couleur;
    }

    public void setCouleur(String couleur) {
        this.couleur = couleur;
    }


}
