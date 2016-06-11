package Model.Entities;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Entity
public class Voyage {

    @Id
    @GeneratedValue( strategy = GenerationType.AUTO )
    private long id;

    private String lieuDepart, lieuArrivee;

    private double prix, dureeEstimee;

    @OneToMany
    private List<User> reserveurs = new ArrayList<>();

    @Temporal(TemporalType.DATE)
    private Date dateReservation;

    private double distance;

    @ManyToOne
    private Annonce annonce;

    public Annonce getAnnonce() {
        return annonce;
    }

    public void setAnnonce(Annonce annonce) {
        this.annonce = annonce;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getLieuDepart() {
        return lieuDepart;
    }

    public void setLieuDepart(String lieuDepart) {
        this.lieuDepart = lieuDepart;
    }

    public String getLieuArrivee() {
        return lieuArrivee;
    }

    public void setLieuArrivee(String lieuArrivee) {
        this.lieuArrivee = lieuArrivee;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public double getDureeEstimee() {
        return dureeEstimee;
    }

    public void setDureeEstimee(double dureeEstimee) {
        this.dureeEstimee = dureeEstimee;
    }

    public List<User> getReserveurs() {
        return reserveurs;
    }

    public void setReserveurs(List<User> reserveurs) {
        this.reserveurs = reserveurs;
    }

    public double getDistance() {
        return distance;
    }

    public void setDistance(double distance) {
        this.distance = distance;
    }

    public Date getDateReservation() {
        return dateReservation;
    }

    public void setDateReservation(Date dateReservation) {
        this.dateReservation = dateReservation;
    }
}
