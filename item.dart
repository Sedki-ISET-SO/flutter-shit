class Item {
  final int? id; // Make id nullable
  final int code;
  final String label;
  final double quantity;
  final String category;
  final String availability;
  final String salesType;

  Item(
      {this.id,
      required this.code,
      required this.label,
      required this.quantity,
      required this.category,
      required this.availability,
      required this.salesType});

  Map<String, dynamic> toMap() {
    return {
      // Only include id in the map if it is not null
      if (id != null) 'id': id,
      'code': code,
      'label': label,
      'quantity': quantity,
      'category': category,
      'availability': availability,
      'salesType': salesType,
    };
  }
}
