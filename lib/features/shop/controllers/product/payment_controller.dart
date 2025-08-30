// import 'package:get/get.dart';
// import 'package:nishant_store/utils/popups/loaders.dart';
// import 'package:upi_india/upi_india.dart';
//
// class UPIPaymentController extends GetxController{
//   static UPIPaymentController get instance => Get.find();
//
//   // create variable to store upi response
//   Future<UpiResponse>? transaction;
//
//   // create object of UpiIndia class
//   final UpiIndia upiIndia = UpiIndia();
//
//   // all upi apps list like google pay, paytm etc.
//   List<UpiApp> apps = [];
//
//   void onInit(){
//     // add all payment apps
//     upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) => apps.add(value as UpiApp))
//         .catchError((e) {
//       apps = [];
//     });
//     super.onInit();
//   }
//
//   Future<UpiResponse> initiateTransaction(UpiApp app, double totalAmount) async {
//     try{
//       final response = await upiIndia.startTransaction(
//         app: app,
//         receiverUpiId: "nishantbalajigund987@oksbi",
//         receiverName: 'Nishant Gund',
//         transactionRefId: 'TestingUpiIndiaPlugin',
//         transactionNote: 'Not actual. Just an example.',
//         amount: 10.00,
//       );
//       return response;
//     }
//     on UpiIndiaAppNotInstalledException{
//       throw Loaders.errorSnackBar(title: "Oh Snap", message: "Requested app not installed on device");
//     }
//     on UpiIndiaUserCancelledException{
//       throw Loaders.errorSnackBar(title: "Oh Snap", message: "You cancelled the transaction");
//     }
//     on UpiIndiaInvalidParametersException{
//       throw Loaders.errorSnackBar(title: "Oh Snap", message: "Invalid parameters sent to the UPI app");
//     }
//     on UpiIndiaNullResponseException{
//       throw Loaders.errorSnackBar(title: "Oh Snap", message: "No response received from the app");
//     }
//     catch(e){
//       throw Loaders.errorSnackBar(title: "Oh Snap", message: e.toString());
//     }
//   }
//
// }