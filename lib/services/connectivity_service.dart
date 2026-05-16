/// AGROKSHA AI — Connectivity Service



/// Monitors internet status, exposes stream for app-wide use



library;







import 'dart:async';



import 'package:connectivity_plus/connectivity_plus.dart';







class ConnectivityService {



  ConnectivityService._();



  static final ConnectivityService instance = ConnectivityService._();







  final _connectivity = Connectivity();



  final _controller = StreamController<bool>.broadcast();







  bool _isOnline = true;



  bool get isOnline => _isOnline;



  Stream<bool> get onStatusChange => _controller.stream;







  Future<void> init() async {



    final result = await _connectivity.checkConnectivity();



    _isOnline = _toOnline(result);



    _connectivity.onConnectivityChanged.listen((result) {



      final online = _toOnline(result);



      if (online != _isOnline) {



        _isOnline = online;



        _controller.add(online);



      }



    });



  }







  bool _toOnline(List<ConnectivityResult> results) =>



      results.any((r) => r != ConnectivityResult.none);







  void dispose() => _controller.close();



}



