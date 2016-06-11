package Model.DAO;

import Model.Entities.Annonce;
import Model.Entities.Message;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import java.util.List;

public class MessageDaoImpl {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("ensam");
    private EntityManager em = emf.createEntityManager();


    public void insert(Message message) {
        em.getTransaction().begin();
        em.persist(message);
        em.getTransaction().commit();
    }

    public List<Message> getMessage(int id) {
        List<Message> messages = null;
        try {
            String sql = "select m from Message m where m.recepteur.id=:id1 or m.emetteur.id=:id2";
            TypedQuery<Message> query = em.createQuery(sql, Message.class);
            query.setParameter("id1", id);
            query.setParameter("id2", id);
            messages = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return messages;


    }



    public List<Message> getConv(int id, int idSender) {
        List<Message> messages = null;
        try {
            String sql = "select m from Message m where (m.recepteur.id=:id1 and m.emetteur.id=:id2) or (m.recepteur.id=:id2 and m.emetteur.id=:id1) order by m.dateMsg asc";
            TypedQuery<Message> query = em.createQuery(sql, Message.class);
            query.setParameter("id1", id);
            query.setParameter("id2", idSender);
            messages = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return messages;


    }


//    public List<Annonce> findAll() {
//        List<Annonce> annonceList = null;
//        try {
//            String sql = "select a from Annonce a";
//            TypedQuery<Annonce> query = em.createQuery(sql, Annonce.class);
//            annonceList = query.getResultList();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return annonceList;
//    }

}
