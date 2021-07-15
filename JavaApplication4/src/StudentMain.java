
import java.math.BigDecimal;
import java.util.List;
import javaapplication4.kd170016_CityOperations;
import javaapplication4.kd170016_CourierOperations;
import javaapplication4.kd170016_CourierRequestOperations;
import javaapplication4.kd170016_DistrictOperations;
import javaapplication4.kd170016_GeneralOperations;
import javaapplication4.kd170016_PackageOperations;
import javaapplication4.kd170016_UserOperations;
import javaapplication4.kd170016_VehicleOperations;
import rs.etf.sab.operations.CityOperations;
import rs.etf.sab.operations.CourierOperations;
import rs.etf.sab.operations.CourierRequestOperation;
import rs.etf.sab.operations.DistrictOperations;
import rs.etf.sab.operations.GeneralOperations;
import rs.etf.sab.operations.PackageOperations;
import rs.etf.sab.operations.UserOperations;
import rs.etf.sab.operations.VehicleOperations;
import rs.etf.sab.tests.TestHandler;
import rs.etf.sab.tests.TestRunner;

public class StudentMain {

    public static void main(String[] args) {
        CityOperations cityOperations = new kd170016_CityOperations(); 
        DistrictOperations districtOperations = new kd170016_DistrictOperations(); 
        CourierOperations courierOperations = new kd170016_CourierOperations();
        CourierRequestOperation courierRequestOperation = new kd170016_CourierRequestOperations();
        GeneralOperations generalOperations = new kd170016_GeneralOperations();
        UserOperations userOperations = new kd170016_UserOperations();
        VehicleOperations vehicleOperations = new kd170016_VehicleOperations();
        PackageOperations packageOperations = new kd170016_PackageOperations();

        TestHandler.createInstance(
                cityOperations,
                courierOperations,
                courierRequestOperation,
                districtOperations,
                generalOperations,
                userOperations,
                vehicleOperations,
                packageOperations);

        TestRunner.runTests();
    }
}
