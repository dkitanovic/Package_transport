package javaapplication4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import rs.etf.sab.operations.UserOperations;


public class kd170016_UserOperations implements UserOperations{

    Connection conn = DB.getInstance().getConnection();
    
    boolean isValidPassword(String password)
    {
  
        // Regex to check valid password.
        String regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";
  
        // Compile the ReGex
        Pattern p = Pattern.compile(regex);
  
        // If the password is empty
        // return false
        if (password == null) {
            return false;
        }
  
        // Pattern class contains matcher() method
        // to find matching between given password
        // and regular expression.
        Matcher m = p.matcher(password);
  
        // Return if the password
        // matched the ReGex
        return m.matches();
    }
    
    @Override
    public boolean insertUser(String korisnickoIme, String ime, String prezime, String sifra){
       
        if (ime.equals("") || prezime.equals("") || ime==null || prezime==null){
            return false;
        }
        if (!Character.isUpperCase(ime.charAt(0))){
            return false;
        }
        
        if (!Character.isUpperCase(prezime.charAt(0))){
            return false;
        }
        
        if (!isValidPassword(sifra)){
            
            return false;
        }
        String upit = "if ? not in (\n" +
                    "	select KorisnickoIme\n" +
                    "	from Korisnik\n" +
                    ") \n" +
                    "insert into Korisnik\n" +
                    "values (?,?,?,?,0)";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setString(1, korisnickoIme);
            ps.setString(2, korisnickoIme);
            ps.setString(3, ime);
            ps.setString(4, prezime);
            ps.setString(5, sifra);
            
           
           
            int rs = ps.executeUpdate();
            if (rs > 0){
               
                return true;
            }
            else return false;
            
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }

    @Override
    public int declareAdmin(String korisnickoIme){
        String upit1 = "select * from Administrator where KorisnickoIme=?";
        
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setString(1, korisnickoIme);
            ResultSet rs = ps.executeQuery();
   
            if (rs.next()){
                
                return 1;
            }
           
        } catch (SQLException ex) {
          
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit2 = "select * from Korisnik where KorisnickoIme=?";
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setString(1, korisnickoIme);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
                
                return 2;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit3 = "insert into Administrator values(?)";
        try (PreparedStatement ps = conn.prepareStatement(upit3);){
            ps.setString(1, korisnickoIme);
            int rs = ps.executeUpdate();
           
            return 0;
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
   
        return 2;
    }

    @Override
    public Integer getSentPackages(String... usernames) {
        System.out.println("javaapplication4.kd170016_UserOperations.getSentPackages()");
        if (usernames.length == 0) return null;
        int counter = 0;
        
        
        
        for (String username:usernames){
            String upit0="select * from Korisnik where korisnickoIme=?";
            try (PreparedStatement ps = conn.prepareStatement(upit0);){
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                if (!rs.next()){
                    return null;
                }
           
            }catch (SQLException ex) {
          
                 Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            String upit="select count(*)\n" +
            "from ZahtevPrevoz z join Paket p on z.IdPaket=p.IdPaket\n" +
            "where z.KorisnickoIme=? and p.Status=3 ";
            try (PreparedStatement ps = conn.prepareStatement(upit);){
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                if (rs.next()){
                    counter+=rs.getInt(1);
                }
           
            }catch (SQLException ex) {
          
                 Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        System.out.println(counter);
        return counter; 
    }

    @Override
    public int deleteUsers(String... usernames) {
       
        int counter = 0;
        String upit = "delete from Korisnik where KorisnickoIme=?";
        
        for (String username:usernames){
            try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setString(1, username);
            int rs = ps.executeUpdate();
            if (rs>0){
                counter+=rs;
             
            }
           
        } catch (SQLException ex) {
          
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        }
        
        return counter;
    }

    @Override
    public List<String> getAllUsers() {
        List<String> result = new ArrayList<String>();
        String upit ="select KorisnickoIme from Korisnik";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
            result.add(rs.getString(1));
        }
        }catch (SQLException ex) {
          
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return result;
    }
}
