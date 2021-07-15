/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication4;

import static java.lang.Math.sqrt;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.PackageOperations;

/**
 *
 * @author dkitanovic
 */
public class kd170016_PackageOperations implements PackageOperations{

    Connection conn = DB.getInstance().getConnection();
    
    public BigDecimal izracunajCenu(int IdPaket, int IdOpstinaOd, int IdOpstinaDo){
        double cena=10;
        double tezina=0;
        int tip=0;
        int cenaPoKg=0;

        String upit1="select Tezina,Tip from Paket where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setInt(1, IdPaket);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                tezina = rs.getBigDecimal(1).doubleValue();
                tip = rs.getInt(2);
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if (tip==1) {
            cena = 25;
            cenaPoKg=100;
        }
        else if (tip==2){
            cena = 75;
            cenaPoKg = 300;
        }
        
        cena+=tip*tezina*cenaPoKg;
        
        double x1=0,y1=0,x2=0,y2=0;
        
        String upit2="select X,Y from Opstina where IdOpstina=?";
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setInt(1, IdOpstinaOd);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                x1=rs.getDouble(1);
                y1=rs.getDouble(2);
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setInt(1, IdOpstinaDo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                x2=rs.getDouble(1);
                y2=rs.getDouble(2);
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        double distanca = sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
        
        cena*=distanca;
        
        
        return new BigDecimal(cena);
    }
    
    public double nadjiDistancu(int IdOpstinaOd, int IdOpstinaDo){
        double x1=0,y1=0,x2=0,y2=0;
        
        String upit1="select X,Y from Opstina where IdOpstina=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1)){
            ps.setInt(1, IdOpstinaOd);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                x1=rs.getDouble(1);
                y1=rs.getDouble(2);
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try (PreparedStatement ps = conn.prepareStatement(upit1)){
            ps.setInt(1, IdOpstinaDo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                x2=rs.getDouble(1);
                y2=rs.getDouble(2);
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
    }
    
    public void kurirJeGotov(String korisnickoIme){
        String upit1 ="select s.Profit from Sadrzi s,Voznja v,Kurir k where s.IdVoznja=v.IdVoznja and v.korisnickoIme=k.korisnickoIme and v.korisnickoIme=?";
        double profit = 0;
        try (PreparedStatement ps = conn.prepareStatement(upit1)){
            ps.setString(1, korisnickoIme);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                profit += rs.getBigDecimal(1).doubleValue();
            }
                    
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit2 ="update Kurir set Profit=?,Status=0 where KorisnickoIme=?";
        try (PreparedStatement ps = conn.prepareStatement(upit2)){
            ps.setBigDecimal(1, new BigDecimal(profit));
            ps.setString(2, korisnickoIme);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    @Override
    public int insertPackage(int IdOpstinaOd, int IdOpstinaDo, String korisnickoIme, int tip, BigDecimal tezina) {
        
        int ret = -1;
        String upit1 ="select * from Korisnik\n" +
                    "where KorisnickoIme=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1)){
            ps.setString(1, korisnickoIme);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
                return -1;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit2 ="select * from Opstina\n" +
                "where IdOpstina=?";
        try (PreparedStatement ps = conn.prepareStatement(upit2)){
            ps.setInt(1, IdOpstinaOd);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
                return -1;
            }  
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit3 ="select * from Opstina\n" +
                "where IdOpstina=?";
        try (PreparedStatement ps = conn.prepareStatement(upit3)){
            ps.setInt(1, IdOpstinaDo);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
                return -1;
            }  
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
         
        String upit4 ="insert into Paket\n" +
                    "values (0,null,null,?,?,null)";
        try (PreparedStatement ps = conn.prepareStatement(upit4, PreparedStatement.RETURN_GENERATED_KEYS);){
            ps.setInt(1, tip);
            ps.setBigDecimal(2, tezina);
            int broj = ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (!rs.next()){}
            ret = rs.getInt(1);
            
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit5 ="insert into ZahtevPrevoz\n" +
                    "values (?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(upit5);){
            ps.setString(1, korisnickoIme);
            ps.setInt(2, ret);
            ps.setInt(3, IdOpstinaOd);
            ps.setInt(4, IdOpstinaDo);
            ps.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    @Override
    public int insertTransportOffer(String kurir, int paket, BigDecimal procenat) {
        
        String upit1 ="select KorisnickoIme\n" +
                    "from Kurir where KorisnickoIme=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setString(1, kurir);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit2 ="select KorisnickoIme\n" +
                    "from ZahtevPrevoz where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setInt(1, paket);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String korisnickoIme="";
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setInt(1, paket);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
                return -1;
            }else{
                korisnickoIme = rs.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit3 ="insert into Ponuda\n" +
                    "values(?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(upit3, PreparedStatement.RETURN_GENERATED_KEYS);){
            ps.setBigDecimal(1, procenat);
            ps.setString(2, kurir);
            ps.setString(3, korisnickoIme);
            ps.setInt(4, paket);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (!rs.next()){}
            return rs.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return -1;
    }

    @Override
    public boolean acceptAnOffer(int idPonuda) {
       
        String upit1 ="select p.IdPaket,p.Kurir,z.IdOpstinaOd,z.IdOpstinaDo,p.Procenat from Ponuda p,ZahtevPrevoz z where p.KorisnickoIme=z.KorisnickoIme and p.IdPaket=z.IdPaket and\n" +
                    "p.IdPonuda=?";
        int IdPaket = -1;
        String kurir ="";
        int IdOpstinaOd = -1;
        int IdOpstinaDo = -1;
        double Procenat = 0;
        try (PreparedStatement ps = conn.prepareStatement(upit1)){
            ps.setInt(1, idPonuda);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                IdPaket = rs.getInt(1);
                kurir = rs.getString(2);
                IdOpstinaOd = rs.getInt(3);
                IdOpstinaDo = rs.getInt(4);
                Procenat = rs.getBigDecimal(5).doubleValue();
                
            }else{
                return false;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit2 ="insert into OdobrenaPonuda values(?)";
        try (PreparedStatement ps = conn.prepareStatement(upit2)){
            ps.setInt(1, idPonuda);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        BigDecimal cena = izracunajCenu(IdPaket,IdOpstinaOd,IdOpstinaDo).multiply((new BigDecimal(Procenat).divide(new BigDecimal(100))).add(new BigDecimal(1)));
        double cenna=cena.doubleValue();
        
        
        boolean ret=false;
        
        String upit3 ="update Paket set KorisnickoIme=?,Status=1,VremePrihvatanja=getdate(),Cena=? where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit3)){
            ps.setString(1, kurir);
            ps.setBigDecimal(2,cena);
            ps.setInt(3, IdPaket);
            ps.executeUpdate();
            ret = true;
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        return ret;
        
    }

    @Override
    public List<Integer> getAllOffers() {
       
        List<Integer> ret = new ArrayList<Integer>();
        String upit ="select IdPonuda from Ponuda\n" +
                    "where IdPonuda not in (select IdPonuda from OdobrenaPonuda)";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                ret.add(rs.getInt(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    @Override
    public List<Pair<Integer, BigDecimal>> getAllOffersForPackage(int IdPaket) {
       
        List<Pair<Integer, BigDecimal>> ret = new ArrayList<PackageOperations.Pair<Integer,BigDecimal>>();
        String upit ="select IdPonuda,Procenat from Ponuda\n" +
                    "where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1, IdPaket);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                kd170016_PackageOperationsPair<Integer,BigDecimal> par = new kd170016_PackageOperationsPair<Integer,BigDecimal>(); 
                par.setFirstParam(rs.getInt(1));
                par.setSecondParam(rs.getBigDecimal(2));
                ret.add(par);
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    @Override
    public boolean deletePackage(int IdPaket) {
        String upit = "delete from Paket where IdPaket=?";
        
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1, IdPaket);
            int rs = ps.executeUpdate();
            if (rs>0){
                return true;
            }else return false;
           
        } catch (SQLException ex) {
          
            Logger.getLogger(kd170016_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }

    @Override
    public boolean changeWeight(int idPaket, BigDecimal tezina) {
       
        String upit1 ="select * from Paket\n" +
                    "where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setInt(1, idPaket);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit2 ="update Paket\n" +
                    "set Tezina=? where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setBigDecimal(1, tezina);
            ps.setInt(2,idPaket);
            int rs = ps.executeUpdate();
            if (rs > 0){
                return true;
            }else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean changeType(int idPaket, int tip) {
       
        String upit1 ="select * from Paket\n" +
                    "where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit1);){
            ps.setInt(1, idPaket);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()){
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String upit2 ="update Paket\n" +
                    "set Tip=? where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit2);){
            ps.setInt(1, tip);
            ps.setInt(2, idPaket);
            int rs = ps.executeUpdate();
            if (rs > 0){
                return true;
            }else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public Integer getDeliveryStatus(int IdPaket) {
       
        String upit ="select Status from Paket\n" +
                    "where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1,IdPaket);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                return rs.getInt(1);
            }else {
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public BigDecimal getPriceOfDelivery(int IdPaket) {
       
        String upit ="select Cena from Paket\n" +
                    "where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1,IdPaket);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                return rs.getBigDecimal(1);
            }else {
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public Date getAcceptanceTime(int idPaket) {
      
        String upit ="select VremePrihvatanja from Paket\n" +
                    "where IdPaket=?";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1,idPaket);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                return rs.getDate(1);
            }else {
                return null;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public List<Integer> getAllPackagesWithSpecificType(int tip) {
       
        List<Integer> ret = new ArrayList<Integer>();
        String upit ="select IdPaket from Paket\n" +
                    "where Tip=?";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
            ps.setInt(1, tip);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                ret.add(rs.getInt(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    @Override
    public List<Integer> getAllPackages() {
     
        List<Integer> ret = new ArrayList<Integer>();
        String upit ="select IdPaket from Paket";
        try (PreparedStatement ps = conn.prepareStatement(upit);){
           
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                ret.add(rs.getInt(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    @Override
    public List<Integer> getDrive(String string) {
        List<Integer> paketi = new ArrayList<Integer>();
        try (PreparedStatement ps = conn.prepareStatement("select IdPaket from Paket where KorisnickoIme=? and Status=2");) {
            ps.setString(2, string);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                paketi.add(rs.getInt(1));
            }
            return paketi;
        } catch (SQLException ex) {
            
        }
        return paketi;
    }

    @Override
    public int driveNextPackage(String korisnickoIme) {
        
        String upit1 ="select Status,RegistracioniBroj from Kurir where KorisnickoIme=?";
        int statusKurira = 0;
        String registracioniBroj = "";
        
        try (PreparedStatement ps = conn.prepareStatement(upit1)){
            ps.setString(1, korisnickoIme);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                statusKurira = rs.getInt(1);
                registracioniBroj = rs.getString(2);
            }else{
                return -2;
            }
        } catch (SQLException ex) {
            Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        if (statusKurira==0){
             
            String upit2 ="select top 1 IdPaket,Cena from Paket where KorisnickoIme=? and Status=1 order by VremePrihvatanja";
            int IdPaket = -1;
            int IdOpstinaOd = -1;
            int IdOpstinaDo = -1;
            double cena = 0;
            int IdVoznja = -1;
            try (PreparedStatement ps = conn.prepareStatement(upit2)){
                ps.setString(1, korisnickoIme);
                ResultSet rs = ps.executeQuery();
                if (rs.next()){
                    IdPaket = rs.getInt(1);
                    cena = rs.getBigDecimal(2).doubleValue();
                }else{
                    return -1;
                }
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            String upit3 ="update Paket set Status=3 where IdPaket=?";
            try (PreparedStatement ps = conn.prepareStatement(upit3)){
                ps.setInt(1, IdPaket);
                ps.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            String upit4 ="update Paket set Status=2 where KorisnickoIme=? and Status=1";
            try (PreparedStatement ps = conn.prepareStatement(upit4)){
                ps.setString(1, korisnickoIme);
                int rs = ps.executeUpdate();
                if (rs<=0){
                    kurirJeGotov(korisnickoIme);
                }
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            
            String upit5 ="select IdOpstinaOd,IdOpstinaDo from ZahtevPrevoz where IdPaket=?";
            try (PreparedStatement ps = conn.prepareStatement(upit5)){
                ps.setInt(1, IdPaket);
                ResultSet rs = ps.executeQuery();
                if (rs.next()){
                    IdOpstinaOd = rs.getInt(1);
                    IdOpstinaDo = rs.getInt(2);
                }
                    
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            String upit6 ="insert into Voznja values(?,?)";
            try (PreparedStatement ps = conn.prepareStatement(upit6, PreparedStatement.RETURN_GENERATED_KEYS)){
                ps.setString(1, korisnickoIme);
                ps.setInt(2, IdOpstinaDo);
                ps.executeUpdate();
                
                ResultSet rs = ps.getGeneratedKeys();
                if (!rs.next()){}
                IdVoznja = rs.getInt(1);
                    
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            double distanca = nadjiDistancu(IdOpstinaOd,IdOpstinaDo);
            
            double potrosnja = 0;
            int tipGoriva = 0;
            
            String upit7 ="select Potrosnja,TipGoriva from Vozilo where RegistracioniBroj=?";
            try (PreparedStatement ps = conn.prepareStatement(upit7);){
                ps.setString(1, registracioniBroj);
                ResultSet rs = ps.executeQuery();
                if (rs.next()){
                    potrosnja = rs.getBigDecimal(1).doubleValue();
                    tipGoriva = rs.getInt(2);
                }
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            int gorivo = 15;
            if (tipGoriva==1){
                gorivo = 36;
            }else if (tipGoriva==2){
                gorivo = 32;
            }
            
            
            
            double profit=(cena-distanca*potrosnja*gorivo);
           
            
            String upit8 ="insert into sadrzi values (?,?,?)";
            try (PreparedStatement ps = conn.prepareStatement(upit8);){
                ps.setInt(1, IdVoznja);
                ps.setInt(2, IdPaket);
                ps.setBigDecimal(3, new BigDecimal(profit));
                
                int rs = ps.executeUpdate();   
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            String upit9 ="update Kurir set Status=1,BrojIsporucenihPaketa=BrojIsporucenihPaketa+1 where KorisnickoIme=?";
            try (PreparedStatement ps = conn.prepareStatement(upit9);){
                ps.setString(1, korisnickoIme);
                int rs = ps.executeUpdate();   
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            return IdPaket;
        }else{
            
        
            String upit2 ="select IdPaket,Cena from Paket where KorisnickoIme=? and Status=2 and VremePrihvatanja=(select MIN(VremePrihvatanja) from Paket where KorisnickoIme=? and Status=2)";
            int IdPaket = -1;
            int IdOpstinaOd = -1;
            int IdOpstinaDo = -1;
            int voznjaOpstina = -1;
            double cena = 0;
            int IdVoznja = -1;
            try (PreparedStatement ps = conn.prepareStatement(upit2)){
                ps.setString(1, korisnickoIme);
                ps.setString(2, korisnickoIme);
                ResultSet rs = ps.executeQuery();
                if (rs.next()){
                    IdPaket = rs.getInt(1);
                    cena = rs.getBigDecimal(2).doubleValue();
                }else{
                    return -1;
                }
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            String upit3 ="update Paket set Status=3 where IdPaket=?";
            try (PreparedStatement ps = conn.prepareStatement(upit3)){
                ps.setInt(1, IdPaket);
                ps.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            
           
            
            
            String upit5 ="select IdOpstinaOd,IdOpstinaDo from ZahtevPrevoz where IdPaket=?";
            try (PreparedStatement ps = conn.prepareStatement(upit5)){
                ps.setInt(1, IdPaket);
                ResultSet rs = ps.executeQuery();
                if (rs.next()){
                    IdOpstinaOd = rs.getInt(1);
                    IdOpstinaDo = rs.getInt(2);
                }
                    
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
         
            String upit6 ="select IdVoznja,IdOpstina from Voznja where KorisnickoIme=?";
            try (PreparedStatement ps = conn.prepareStatement(upit6)){
                ps.setString(1, korisnickoIme);
                ResultSet rs = ps.executeQuery();
                if (rs.next()){
                    IdVoznja = rs.getInt(1);
                    voznjaOpstina = rs.getInt(2);
                }
                    
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            double distanca = nadjiDistancu(voznjaOpstina, IdOpstinaOd) + nadjiDistancu(IdOpstinaOd, IdOpstinaDo);
           
            double potrosnja = 0;
            int tipGoriva = 0;
            String upit7 ="select Potrosnja,TipGoriva from Vozilo where RegistracioniBroj=?";
            try (PreparedStatement ps = conn.prepareStatement(upit7);){
                ps.setString(1, registracioniBroj);
                ResultSet rs = ps.executeQuery();
                if (!rs.next()){}
                potrosnja = rs.getBigDecimal(1).doubleValue();
                tipGoriva = rs.getInt(2);
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            int gorivo = 15;
            if (tipGoriva==1){
                gorivo = 36;
            }else if (tipGoriva==2){
                gorivo = 32;
            }
            double profit=(cena-distanca*potrosnja*gorivo);
           
            
            String upit8 ="insert into sadrzi values (?,?,?)";
            try (PreparedStatement ps = conn.prepareStatement(upit8);){
                ps.setInt(1, IdVoznja);
                ps.setInt(2, IdPaket);
                ps.setBigDecimal(3, new BigDecimal(profit));
                
                int rs = ps.executeUpdate();   
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            String upit9 ="update Kurir set Status=1,BrojIsporucenihPaketa=BrojIsporucenihPaketa+1 where KorisnickoIme=?";
            try (PreparedStatement ps = conn.prepareStatement(upit9);){
                ps.setString(1, korisnickoIme);
                int rs = ps.executeUpdate();   
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            String upit10 ="update Voznja set IdOpstina=?";
            try (PreparedStatement ps = conn.prepareStatement(upit10);){
                ps.setInt(1, IdOpstinaDo);
                int rs = ps.executeUpdate();   
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            String upit4 ="select * from Paket where KorisnickoIme=? and Status=2";
            try (PreparedStatement ps = conn.prepareStatement(upit4)){
                ps.setString(1, korisnickoIme);
                ResultSet rs = ps.executeQuery();
                if (!rs.next()){
                    kurirJeGotov(korisnickoIme);
                }
            } catch (SQLException ex) {
                Logger.getLogger(kd170016_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
            }
            return IdPaket;
        }
        
        //return -2;
    }
    
}
