package Model.Entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Sam on 29/04/2016.
 */
@Entity
public class Annonce implements Serializable{

    @Id
    @GeneratedValue( strategy = GenerationType.AUTO )
    private long id;
    private String categorie, lieuDepartInitial, lieuArriveeFinal, description;
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateDepart, datePublication;
    private int retardAccepte, totalPlaces, placesRestantes, duree;

    private double prix;

    @OneToMany(cascade = CascadeType.PERSIST, mappedBy = "annonce")
    private List<Voyage> voyageList = new ArrayList<>();

    @ManyToOne
    private User annonceur;

    private String taillePaquet;


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public String getLieuDepartInitial() {
        return lieuDepartInitial;
    }

    public void setLieuDepartInitial(String lieuDepartInitial) {
        this.lieuDepartInitial = lieuDepartInitial;
    }

    public String getLieuArriveeFinal() {
        return lieuArriveeFinal;
    }

    public void setLieuArriveeFinal(String lieuArriveeFinal) {
        this.lieuArriveeFinal = lieuArriveeFinal;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(Date dateDepart) {
        this.dateDepart = dateDepart;
    }

    public Date getDatePublication() {
        return datePublication;
    }

    public void setDatePublication(Date datePublication) {
        this.datePublication = datePublication;
    }

    public int getRetardAccepte() {
        return retardAccepte;
    }

    public void setRetardAccepte(int retardAccepte) {
        this.retardAccepte = retardAccepte;
    }

    public int getTotalPlaces() {
        return totalPlaces;
    }

    public void setTotalPlaces(int totalPlaces) {
        this.totalPlaces = totalPlaces;
    }

    public int getPlacesRestantes() {
        return placesRestantes;
    }

    public void setPlacesRestantes(int placesRestantes) {
        this.placesRestantes = placesRestantes;
    }

    public int getDuree() {
        return duree;
    }

    public void setDuree(int duree) {
        this.duree = duree;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public List<Voyage> getVoyageList() {
        return voyageList;
    }

    public void setVoyageList(List<Voyage> voyageList) {
        this.voyageList = voyageList;
    }

    public User getAnnonceur() {
        return annonceur;
    }

    public void setAnnonceur(User annonceur) {
        this.annonceur = annonceur;
    }

    public String getTaillePaquet() {
        return taillePaquet;
    }

    public void setTaillePaquet(String taillePaquet) {
        this.taillePaquet = taillePaquet;
    }



}
