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
import rs.etf.sab.operations.VehicleOperations;

public class kd170016_VehicleOperations implements VehicleOperations{

    Connection conn = DB.getInstance().getConnection();
    
    @Override
    public boolean insertVehicle(String regBroj, int tipGoriva, BigDecimal potrosnja) {
        if (tipGoriva < 0 || tipGoriva> 2) return false;
        
        String upit = "if ? not in (\n" +
                    "	select RegistracioniBroj\n" +
                    "	from Vozilo\n" +
                    ") \n" +
                    "insert into Vozilo\n" +
                    "values (?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setString(1, regBroj);
            ps.setString(2, regBroj);
            ps.setInt(3, tipGoriva);
            ps.setBigDecimal(4, potrosnja);
           
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
    public int deleteVehicles(String... regBrojevi) {
        int counter = 0;
        String upit = "delete from Vozilo where RegistracioniBroj=?";
        
        for (String regBroj:regBrojevi){
            try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setString(1, regBroj);
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
    public List<String> getAllVehichles() {
        List<String> result = new ArrayList<String>();
        String upit ="select RegistracioniBroj from Vozilo";
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

    @Override
    public boolean changeFuelType(String regBroj, int tip) {
        
        if (tip < 0 && tip > 2) return false;
        
        String upit ="update Vozilo set TipGoriva=? where RegistracioniBroj=?";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1, tip);
            ps.setString(2, regBroj);
            int rs = ps.executeUpdate();
            if (rs > 0){
                return true;
            }
            }catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }

    @Override
    public boolean changeConsumption(String regBroj, BigDecimal potrosnja) {
        String upit ="update Vozilo set Potrosnja=? where RegistracioniBroj=?";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setBigDecimal(1, potrosnja);
            ps.setString(2, regBroj);
            int rs = ps.executeUpdate();
            if (rs > 0){
                return true;
            }
            }catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
}
