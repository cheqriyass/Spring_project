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
public class User implements Serializable {
    @Id
    @GeneratedValue( strategy = GenerationType.AUTO )
    private long id;
    private String password;
    private String prenom, nom, email, sexe, telephone, adresse, description;

    @Temporal(TemporalType.DATE)
    private Date dateNaissance, dateInscription;
    @Embedded
    private Vehicule vehicule;

    @OneToMany(mappedBy = "annonceur")
    private List<Annonce> annonces = new ArrayList<>();

    private int likes, dislikes, nbrAvis, nbrAnnonces;
    private boolean valide, suspendu, locked;
    private double cashIn, cashOut;
    private String wallet;
    private String accountId;


    public String getWallet() {
        return wallet;
    }

    public void setWallet(String wallet) {
        this.wallet = wallet;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public User() {
    }

    public User(String password, String prenom, String nom, String email, String sexe, String telephone, String adresse, String description, Date dateNaissance, Vehicule vehicule) {
        this.password = password;
        this.prenom = prenom;
        this.nom = nom;
        this.email = email;
        this.sexe = sexe;
        this.telephone = telephone;
        this.adresse = adresse;
        this.description = description;
        this.dateNaissance = dateNaissance;
        this.vehicule = vehicule;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(Date dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public Date getDateInscription() {
        return dateInscription;
    }

    public void setDateInscription(Date dateInscription) {
        this.dateInscription = dateInscription;
    }

    public Vehicule getVehicule() {
        return vehicule;
    }

    public void setVehicule(Vehicule vehicule) {
        this.vehicule = vehicule;
    }

    public List<Annonce> getAnnonces() {
        return annonces;
    }

    public void setAnnonces(List<Annonce> annonces) {
        this.annonces = annonces;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getDislikes() {
        return dislikes;
    }

    public void setDislikes(int dislikes) {
        this.dislikes = dislikes;
    }

    public int getNbrAvis() {
        return nbrAvis;
    }

    public void setNbrAvis(int nbrAvis) {
        this.nbrAvis = nbrAvis;
    }

    public int getNbrAnnonces() {
        return nbrAnnonces;
    }

    public void setNbrAnnonces(int nbrAnnonces) {
        this.nbrAnnonces = nbrAnnonces;
    }

    public boolean isValide() {
        return valide;
    }

    public void setValide(boolean valide) {
        this.valide = valide;
    }

    public boolean isSuspendu() {
        return suspendu;
    }

    public void setSuspendu(boolean suspendu) {
        this.suspendu = suspendu;
    }

    public boolean isLocked() {
        return locked;
    }

    public void setLocked(boolean locked) {
        this.locked = locked;
    }

    public double getCashIn() {
        return cashIn;
    }

    public void setCashIn(double cashIn) {
        this.cashIn = cashIn;
    }

    public double getCashOut() {
        return cashOut;
    }

    public void setCashOut(double cashOut) {
        this.cashOut = cashOut;
    }
}
