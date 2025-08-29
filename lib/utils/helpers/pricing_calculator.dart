

class TPricingCalculator{

  static double calculateTotalPrice(int subtotal, String location){
    double taxAmount = double.parse(calculateTax(subtotal, location));

    int shippingCost = getShippingCost(location);

    double totalAmount = subtotal + taxAmount + shippingCost.toDouble();
    return totalAmount;

  }


  static String calculateShippingCost(int subtotal, String location){
    int shippingCost = getShippingCost(location);
    return shippingCost.toString();
  }

  static int getShippingCost(String location){
    // Lockup the shipping cost for given location using a shipping rate API
    // Calculate the shipping cost with various factors like distance & weight
    return 20;
  }

  static String calculateTax(int subtotal, String location){
    int taxRate = getTaxRateForLocation(location);
    double taxAmount = (subtotal * taxRate) / 100;
    return taxAmount.toStringAsFixed(1);
  }

  static int getTaxRateForLocation(String location){
    int _GST = 28;
    return _GST;
  }

}