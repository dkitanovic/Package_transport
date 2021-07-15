/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.GeneralOperations;

/**
 *
 * @author dkitanovic
 */
public class kd170016_GeneralOperations implements GeneralOperations {

    Connection conn = DB.getInstance().getConnection();
    
    @Override
    public void eraseAll() {
        
        String upit1 = "delete from Sadrzi";
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        String upit2 = "delete from Voznja";
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        String upit3 = "delete from OdobrenaPonuda";
        try (PreparedStatement ps = conn.prepareStatement(upit3);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit4 = "delete from Ponuda";
        try (PreparedStatement ps = conn.prepareStatement(upit4);){
            
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit5 = "delete from ZahtevPrevoz";
        try (PreparedStatement ps = conn.prepareStatement(upit5);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        String upit6 = "delete from Paket";
        try (PreparedStatement ps = conn.prepareStatement(upit6);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit7 = "delete from Opstina";
        try (PreparedStatement ps = conn.prepareStatement(upit7);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit8 = "delete from Grad";
        try (PreparedStatement ps = conn.prepareStatement(upit8);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        String upit9 = "delete from ZahtevVozilo";
        try (PreparedStatement ps = conn.prepareStatement(upit9);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit10 = "delete from Kurir";
        try (PreparedStatement ps = conn.prepareStatement(upit10);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        String upit11 = "delete from Vozilo";
        try (PreparedStatement ps = conn.prepareStatement(upit11);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit12 = "delete from Korisnik";
        try (PreparedStatement ps = conn.prepareStatement(upit12);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit13 = "delete from Administrator";
        try (PreparedStatement ps = conn.prepareStatement(upit13);){
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
}
