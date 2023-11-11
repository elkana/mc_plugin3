class Server {
  String? name;
  String? host;
  int? port;
  bool? sslPinning;
  String? proxyIp;
  int? proxyPort;

  Server({this.name, this.host, this.port, this.sslPinning, this.proxyIp, this.proxyPort});

  Server.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    host = json['host'];
    port = json['port'];
    sslPinning = json['sslPinning'];
    proxyIp = json['proxyIp'];
    proxyPort = json['proxyPort'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['host'] = host;
    data['port'] = port;
    data['sslPinning'] = sslPinning;
    data['proxyIp'] = proxyIp;
    data['proxyPort'] = proxyPort;
    return data;
  }

  @override
  String toString() =>
      'Server(name: $name, ip: $host, port: $port, sslPinning: $sslPinning, proxyIp: $proxyIp, proxyPort: $proxyPort)';

  // bool isEmpty() => name == null || name!.isEmpty;

  @override
  bool operator ==(Object other) => other is Server && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
