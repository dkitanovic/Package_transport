/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication4;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import static jdk.internal.util.StaticProperty.userName;
import rs.etf.sab.operations.CourierRequestOperation;

/**
 *
 * @author dkitanovic
 */
public class kd170016_CourierRequestOperations implements CourierRequestOperation{

    Connection conn = DB.getInstance().getConnection();
    
    @Override
    public boolean insertCourierRequest(String korisnickoIme, String registracioniBroj) {
        String upit1="select * from Korisnik where KorisnickoIme=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setString(1, korisnickoIme);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
               return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
    
        String upit2="select * from Vozilo where RegistracioniBroj=?";
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setString(1, registracioniBroj);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
               return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
      
        String upit3="select * from Kurir where RegistracioniBroj=?";
        try (PreparedStatement ps = conn.prepareStatement(upit3);){
            ps.setString(1, registracioniBroj);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
               return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        String upit4="insert into ZahtevVozilo values(?,?)";
        try (PreparedStatement ps = conn.prepareStatement(upit4);){
            ps.setString(1, registracioniBroj);
            ps.setString(2, korisnickoIme);
            int rs = ps.executeUpdate();
            if (rs>0){
               return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
        
    }

    @Override
    public boolean deleteCourierRequest(String korisnickoIme) {
        String upit="delete from ZahtevVozilo where KorisnickoIme=?";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setString(1, korisnickoIme);
            int rs = ps.executeUpdate();
            if (rs>0){
               return true;
            }
            else{
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean changeVehicleInCourierRequest(String korisnickoIme, String registracioniBroj) {
        String upit1="select * from Korisnik where RegistracioniBroj=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setString(1, korisnickoIme);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
               return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        String upit2="update VoziloZahtev set RegistracioniBroj=? where KorisnickoIme=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setString(1, registracioniBroj);
            ps.setString(2, korisnickoIme);
            int rs = ps.executeUpdate();
            if (rs>0){
               return true;
            }
            else return false;
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public List<String> getAllCourierRequests() {
        List<String> result = new ArrayList<String>();
        String upit ="select KorisnickoIme from ZahtevVozilo";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
            result.add(rs.getString(1));
        }
        }catch (SQLException ex) {
          
            Logger.getLogger(kd170016_CourierRequestOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return result;
    }

    @Override
    public boolean grantRequest(String korisnickoIme) {
        String query="{ call dbo.spZahtevVozilo (?,?) }"; 
        try (CallableStatement cs= conn.prepareCall(query)){
            cs.setString(1,korisnickoIme);
            cs.registerOutParameter(2, java.sql.Types.INTEGER);
            cs.execute();
            if(cs.getInt(2)!=1)return false;
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, ex);
        }
        return false; 
    }
}
