import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:secret_notes_v2/adi.dart';

late double scc = AdSize.banner.width.toDouble();

class Adpanner extends StatefulWidget {
  const Adpanner({super.key});

  @override
  State<Adpanner> createState() => _AdpannerState();
}

class _AdpannerState extends State<Adpanner> {
  late BannerAd bannerAd;
  bool _isAdReady = true;
  final AdSize _adSize = AdSize.banner;
  void _creatpannerAd() {
    bannerAd = BannerAd(
      size: _adSize,
      adUnitId: adi.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          _isAdReady = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        log('ad failed to load: ${error.message}');
      }),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _creatpannerAd();

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdReady) {
      return Container(
        // color: Colors.red,
        // width: 5,
        // height: 5,
        width: _adSize.width.toDouble(),
        height: _adSize.height.toDouble(),
        child: AdWidget(
          ad: bannerAd,
        ),
        alignment: Alignment.topCenter,
      );
    }
    return Container();
  }
}
