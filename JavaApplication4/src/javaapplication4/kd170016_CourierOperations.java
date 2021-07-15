
package javaapplication4;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.CourierOperations;

public class kd170016_CourierOperations implements CourierOperations{

    Connection conn = DB.getInstance().getConnection();
    
    @Override
    public boolean insertCourier(String korisnickoIme, String regBroj) {
        String upit = "if ? not in (select korisnickoIme from Kurir) and ? in (\n" +
        "	select KorisnickoIme\n" +
        "	from Korisnik\n" +
        ") and  ? in (\n" +
        "	select RegistracioniBroj\n" +   
        "	from Vozilo\n" +
        ") and ? not in (select RegistracioniBroj from Kurir where status=1)\n" +
        "insert into Kurir\n" +
        "values (?,?,0,0,0)";
        
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setString(1, korisnickoIme);
            ps.setString(2, korisnickoIme);
            ps.setString(3, regBroj);
            ps.setString(4, regBroj);
            ps.setString(5, korisnickoIme);
            ps.setString(6, regBroj);
          
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
    public boolean deleteCourier(String korisnickoIme) {
        String upit = "delete from Kurir where KorisnickoIme=?";
        
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setString(1, korisnickoIme);
          
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
    public List<String> getCouriersWithStatus(int status) {
        if (status!=0 && status !=1) return null;
        String upit = "select KorisnickoIme from Kurir where Status=?";
        List<String> result = new ArrayList<String>();
        
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1, status);
          
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                result.add(rs.getString(1));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return result;
    }

    @Override
    public List<String> getAllCouriers() {
        List<String> result = new ArrayList<String>();
        String upit ="select * \n" +
        "from Kurir\n" +
        "order by Profit desc";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                result.add(rs.getString(1));
            }
        }catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return result;
    }

    @Override
    public BigDecimal getAverageCourierProfit(int minBrojPaketa) {
        String upit ="select avg(profit) \n" +
        "from Kurir\n" +
        "where BrojIsporucenihPaketa>=?";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1, minBrojPaketa);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                return rs.getBigDecimal(1); 
            }
        }catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
    }
    
}
