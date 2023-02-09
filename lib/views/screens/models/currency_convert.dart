class Curency {
  final String from;
  final double rate;
  final String to;
  final dynamic result;

  Curency({
    required this.from,
    required this.rate,
    required this.to,
    required this.result,
  });

  factory Curency.fromMap({required Map data,}) {
    return Curency(
      from: data['query']['from'],
      to: data['query']['to'],
      rate: data['info']['rate'],
      result: data['result'],
    );
  }

}

