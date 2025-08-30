class TransactionModel{
  String transactionId;
  String responseCode;
  String transactionRefId;
  String status;
  String approvalRef;

  TransactionModel({
    required this.transactionId,
    required this.responseCode,
    required this.transactionRefId,
    required this.status,
    required this.approvalRef
  });

  static TransactionModel empty() => TransactionModel(transactionId: "", responseCode: "", transactionRefId: "", status: "", approvalRef: "");

  Map<String, dynamic> toJSON(){
    return{
      "transactionId" : transactionId,
      "responseCode" : responseCode,
      "transactionRefId" : transactionRefId,
      "status" : status,
      "approvalRef" : approvalRef
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json){
    return TransactionModel(
        transactionId: json['transactionId'] ?? "" ,
        responseCode: json['responseCode'] ?? "" ,
        transactionRefId: json['transactionRefId'] ?? "" ,
        status: json['status'] ?? "" ,
        approvalRef: json['approvalRef'] ?? "" ,
    );
  }
}