class TicketModel {
  final String id;
  final String busNumber;
  final String departureDate;
  final String departureTime;
  final String endPoint;
  final String priceTicket;
  final String startPoint;

  TicketModel({
    required this.id,
    required this.busNumber,
    required this.departureDate,
    required this.departureTime,
    required this.endPoint,
    required this.priceTicket,
    required this.startPoint,
  });

  @override
  String toString() {
    return 'TicketModel(id: $id, busNumber: $busNumber, departureDate: $departureDate, '
        'departureTime: $departureTime, endPoint: $endPoint, '
        'priceTicket: $priceTicket, startPoint: $startPoint)';
  }
}
