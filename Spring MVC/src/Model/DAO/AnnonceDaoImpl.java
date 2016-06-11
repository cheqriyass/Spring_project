package Model.DAO;

import Model.Entities.Annonce;
import Model.Entities.User;
import Model.Entities.Voyage;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import java.util.Date;
import java.util.List;

public class AnnonceDaoImpl {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("ensam");
    private EntityManager em = emf.createEntityManager();


    public void insert(Annonce annonce) {
        em.getTransaction().begin();
        em.persist(annonce);
        em.getTransaction().commit();
    }

    public int reserverVoyage(long voyageId, User user)
    {
        try {

            em.getTransaction().begin();
            Voyage voyage = em.find(Voyage.class, voyageId);

            List<User> u = voyage.getReserveurs();
            u.add(user);
            voyage.setReserveurs(u);
            em.getTransaction().commit();

        }catch(Exception e)
        {e.printStackTrace();}
        return 1;
    }


    public List<Annonce> findAll() {
        List<Annonce> annonceList = null;
        try {
            String sql = "select a from Annonce a";
            TypedQuery<Annonce> query = em.createQuery(sql, Annonce.class);
            annonceList = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return annonceList;
    }

    public List<Annonce> findByInfo(String depart, String arrive, Date ddepart, String cat, double prixmin, double prixmax) {
        List<Annonce> annonceList = null;

        System.out.println("depart = [" + depart + "], arrive = [" + arrive + "], ddepart = [" + ddepart + "], cat = [" + cat + "], prixmin = [" + prixmin + "], prixmax = [" + prixmax + "]");
        try {
            String sql = "select a from Annonce a where a.id IN (select v.annonce.id from Voyage v join Voyage v2 on v.id = v2.id where v.lieuDepart=:dep and v2.lieuArrivee=:arr and v.annonce.id=v2.annonce.id) and a.categorie=:cat and a.dateDepart>=:ddep and a.prix>=:prixmin and a.prix<=:prixmax";
            TypedQuery<Annonce> query = em.createQuery(sql, Annonce.class);
            query.setParameter("dep", depart);
            query.setParameter("arr", arrive);
            query.setParameter("cat", cat);
            query.setParameter("ddep", ddepart);
            query.setParameter("prixmin", prixmin);
            query.setParameter("prixmax", prixmax);
            annonceList = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return annonceList;
    }

    public List<Annonce> findByAnnonceurId(int id) {
        List<Annonce> annonceList = null;
        try {
            String sql = "select a from Annonce a where a.annonceur.id=:id";
            TypedQuery<Annonce> query = em.createQuery(sql, Annonce.class);
            query.setParameter("id",id);
            annonceList = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return annonceList;
    }

    public Annonce findById(long id) {
        Annonce annonce = null;
        try {
            String sql = "select a from Annonce a where a.id=:id";
            TypedQuery<Annonce> query = em.createQuery(sql, Annonce.class);
            query.setParameter("id",id);
            annonce = query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return annonce;
    }

    public List<Annonce> findByVilles(String depart, String arrive) {
        List<Annonce> annonceList = null;
        try {
            String sql = "select a from Annonce a where a.id IN (select v.annonce.id from Voyage v join Voyage v2 on v.id = v2.id where v.lieuDepart=:dep and v2.lieuArrivee=:arr and v.annonce.id=v2.annonce.id)";
            TypedQuery<Annonce> query = em.createQuery(sql, Annonce.class);
            query.setParameter("dep",depart);
            query.setParameter("arr",arrive);
            annonceList = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return annonceList;
    }
}