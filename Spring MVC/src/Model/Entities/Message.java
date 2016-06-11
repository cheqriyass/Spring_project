package Model.Entities;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Sam on 29/04/2016.
 */
@Entity
public class Message {

    @Id
    @GeneratedValue( strategy = GenerationType.AUTO )
    private long id;


    @ManyToOne
    private User emetteur, recepteur;

    private String Message;

    @Temporal(TemporalType.DATE)
    private Date dateMsg;

    boolean etat;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public boolean isEtat() {
        return etat;
    }

    public void setEtat(boolean etat) {
        this.etat = etat;
    }

    public User getEmetteur() {
        return emetteur;
    }

    public void setEmetteur(User emetteur) {
        this.emetteur = emetteur;
    }

    public User getRecepteur() {
        return recepteur;
    }

    public void setRecepteur(User recepteur) {
        this.recepteur = recepteur;
    }

    public String getMessage() {
        return Message;
    }

    public void setMessage(String message) {
        Message = message;
    }

    public Date getDateMsg() {
        return dateMsg;
    }

    public void setDateMsg(Date dateMsg) {
        this.dateMsg = dateMsg;
    }
}
