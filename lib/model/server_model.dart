class Server {
  String? name;
  String? host;
  int? port;
  bool? sslPinning;
  String? proxyIp;
  int? proxyPort;
  bool? https;

  Server({this.https, this.name, this.host, this.port, this.sslPinning, this.proxyIp, this.proxyPort});

  Server.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    host = json['host'];
    port = json['port'];
    sslPinning = json['sslPinning'];
    proxyIp = json['proxyIp'];
    proxyPort = json['proxyPort'];
    https = json['https'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['host'] = host;
    data['port'] = port;
    data['sslPinning'] = sslPinning;
    data['proxyIp'] = proxyIp;
    data['proxyPort'] = proxyPort;
    data['https'] = https;
    return data;
  }

  @override
  String toString() =>
      'Server(name: $name, host: $host, port: $port, sslPinning: $sslPinning, proxyIp: $proxyIp, proxyPort: $proxyPort, https: $https)';

  String toAddress() =>
      port != null ? 'http${https == true ? 's' : ''}://$host:$port' : 'http${https == true ? 's' : ''}://$host';
  // bool isEmpty() => name == null || name!.isEmpty;

  @override
  bool operator ==(Object other) => other is Server && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
