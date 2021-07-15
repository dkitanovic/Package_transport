/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication4;

import rs.etf.sab.operations.PackageOperations;

/**
 *
 * @author dkitanovic
 */
public class kd170016_PackageOperationsPair<Integer,BigDecimal> implements PackageOperations.Pair{

    Integer first;
    BigDecimal second;
    
    @Override
    public Object getFirstParam() {
        return first;
    }

    @Override
    public Object getSecondParam() {
        return second;
    }
    
    public void setFirstParam(Integer i) {
        first = i;
    }

    public void setSecondParam(BigDecimal i) {
        second = i;
    }
 
}
