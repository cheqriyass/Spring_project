package Model.DAO;

import Model.Entities.User;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

/**
 * Created by Sam on 03/05/2016.
 */
public class UserDaoImpl {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("ensam");
    private EntityManager em = emf.createEntityManager();


    public void insert(User user){
        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();
    }


    public User findById(int id){

        User User = null;
        try {
            String sql = "select u from User u where u.id=:id";
            TypedQuery<User> query = em.createQuery(sql, User.class);
            query.setParameter("id", id);

            User = query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return User;
    }

    public User findByCredentials(String userName, String passwd) {

        User User = null;
        try {
            String sql = "select u from User u where u.email=:email and u.password =:pass";
            TypedQuery<User> query = em.createQuery(sql, User.class);
            query.setParameter("email", userName);
            query.setParameter("pass", passwd);
            User = query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return User;
    }

    public User findByUserName(String userName) {

        User User = null;
        try {
            String sql = "select u from User u where u.email =:us";
            TypedQuery<User>  query = em.createQuery(sql, User.class);
            query.setParameter("us",userName);

            User = query.getSingleResult();
        }catch (Exception e)
        {
            e.printStackTrace();
        }
        return User;
    }
}
