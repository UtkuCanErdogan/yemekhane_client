class Transaction {
  int? id;
  String? type;
  String? creationDate;
  int? cardId;

  Transaction({
    required this.id,
    required this.type,
    required this.creationDate,
    required this.cardId});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    creationDate = json['creationDate'];
    cardId = json['cardId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['creationDate'] = this.creationDate;
    data['cardId'] = this.cardId;
    return data;
  }
}