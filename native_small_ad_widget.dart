import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({Key? key}) : super(key: key);

  @override
  _NativeAdWidgetState createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 100, // Set your desired height
          width: MediaQuery.of(context).size.width,
        ),
        if (_nativeAdIsLoaded && _nativeAd != null)
          SizedBox(
            height: 100, // Set your desired height
            width: MediaQuery.of(context).size.width,
            child: AdWidget(ad: _nativeAd!),
          ),
      ],
    );
  }

  /// Loads a small-sized native ad.
  void _loadAd() {
    setState(() {
      _nativeAdIsLoaded = false;
    });

    _nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          print('Small NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Small NativeAd failedToLoad: $error');
          ad.dispose();
        },
        // Add other ad listener callbacks as needed
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small, // Use small template
        // Customize other template styles as needed
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
}