package javaapplication4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.CityOperations;

public class kd170016_CityOperations implements CityOperations{

    Connection conn = DB.getInstance().getConnection();
    
    @Override
    public int insertCity(String naziv, String postanskiBroj) {
       
        String upit1 = "select IdGrad from Grad where Naziv=? or PostanskiBroj=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setString(1, naziv);
            ps.setString(2, postanskiBroj);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return -1;
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit2 = "insert into Grad values (?,?)";
         
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setString(1, naziv);
            ps.setString(2, postanskiBroj);
            
            int rs = ps.executeUpdate();
            if (rs <= 0) return -1;
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setString(1, naziv);
            ps.setString(2, postanskiBroj);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
      
        return -1;
    }

    @Override
    public int deleteCity(String... imena) {
        int counter = 0;
        String upit = "delete from Grad where Naziv=?";
        
        for (String ime:imena){
            try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setString(1, ime);
            int rs = ps.executeUpdate();
            if (rs>0){
                counter+=rs;
            }
           
        } catch (SQLException ex) {
          
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        }
      
        return counter;
    }

    @Override
    public boolean deleteCity(int id) {
        String upit = "delete from Grad where IdGrad=?";
        
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1, id);
            int rs = ps.executeUpdate();
            if (rs>0){
                
                return true;
            }  
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        return false;
    }

    @Override
    public List<Integer> getAllCities() {
        List<Integer> result = new ArrayList<Integer>();
        String upit ="select IdGrad from Grad";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                result.add(rs.getInt(1));
            }
        }catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        return result;
    }
    
}
