
package javaapplication4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.DistrictOperations;

public class kd170016_DistrictOperations implements DistrictOperations{

    Connection conn = DB.getInstance().getConnection();
    
    @Override
    public int insertDistrict(String Naziv, int IdGrad, int X, int Y) {
       
        String upit1 = "if ? in (select IdGrad from Grad) and ? not in (select Naziv from Opstina where IdGrad=?) insert into Opstina values (?,?,?,?)";
        
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setInt(1, IdGrad);
            ps.setString(2, Naziv);
            ps.setInt(3, IdGrad);
            ps.setString(4, Naziv);
            ps.setInt(5, X);
            ps.setInt(6, Y);
            ps.setInt(7, IdGrad);
            
            int rs = ps.executeUpdate();
            if (rs <= 0){
                return -1;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit2="select IdOpstina from Opstina where Naziv=? and IdGrad=?";
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setString(1, Naziv);
            ps.setInt(2, IdGrad);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                return rs.getInt(1);
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    @Override
    public int deleteDistricts(String... imena) {
        int counter = 0;
        String upit = "delete from Opstina where Naziv=?";
        
        for (String ime:imena){
            try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setString(1, ime);
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
    public boolean deleteDistrict(int id) {
        String upit="delete from Opstina where IdOpstina=?";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1, id);
            int rs = ps.executeUpdate();
            if (rs>0){
                return true;
            }
        }catch (SQLException e){
            
        }
        return false;
    }

    @Override
    public int deleteAllDistrictsFromCity(String naziv) {
        int idGrad=0;
        String upit1="select IdGrad from Grad where Naziv=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setString(1, naziv);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                idGrad=rs.getInt(1);
            }
        }catch (SQLException e){
            
        }
      
        String upit2="delete from Opstina where IdGrad=?";
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setInt(1, idGrad);
            int rs = ps.executeUpdate();
            if (rs>0){
                return rs;
            }
        }catch (SQLException e){
            
        }
        return 0;
    }

    @Override
    public List<Integer> getAllDistrictsFromCity(int idGrad) {
        System.out.println("javaapplication4.kd170016_DistrictOperations.getAllDistrictsFromCity() " + idGrad);
        String upit = "select IdOpstina from Opstina where IdGrad=?";
        List<Integer> result = new ArrayList<Integer>();
        
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1, idGrad);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                result.add(rs.getInt(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return result;
    }

    @Override
    public List<Integer> getAllDistricts() {
        System.out.println("javaapplication4.kd170016_DistrictOperations.getAllDistricts()");
        String upit = "select IdOpstina from Opstina";
        List<Integer> result = new ArrayList<Integer>();
        
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                result.add(rs.getInt(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return result;
    }
    
}
