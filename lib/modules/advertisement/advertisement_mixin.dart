import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

import '../../common/constants.dart';
import 'index.dart';

mixin AdvertisementMixin<T extends StatefulWidget> on State<T> {
  final _listAdView = <AdvertisementView>[];

  AdvertisementConfig? get advertisement;

  static final _adsProviders = {
    AdvertisementProvider.facebook: FacebookAdvertisement(),
    AdvertisementProvider.google: GoogleAdvertisement(),
  };

  AdvertisementBase? getAdsProvider(AdvertisementProvider? adsProvider) =>
      _adsProviders[adsProvider!];

  bool get enableAd => !kIsWeb && (advertisement?.enable ?? false);

  final _adsWidget = <Widget>[];

  @override
  void initState() {
    super.initState();
    if (!enableAd) return;
    final ads = advertisement!.ads;
    for (final ad in ads) {
      final id = ad.id;
      if (id.isEmpty) continue;
      final adView = AdvertisementView(
        data: ad,
      );
      _listAdView.add(adView);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildListBannerAd() {
    if (!enableAd) return const SizedBox();
    return ImplicitlyAnimatedList<Widget>(
      items: List.unmodifiable(_adsWidget),
      shrinkWrap: true,
      insertDuration: const Duration(seconds: 1),
      removeDuration: const Duration(milliseconds: 250),
      updateDuration: const Duration(),
      physics: const NeverScrollableScrollPhysics(),
      areItemsTheSame: (a, b) => a.key == b.key,
      itemBuilder: (context, animation, item, index) {
        return _slideIt(item, animation);
      },
      removeItemBuilder: (context, animation, oldItem) {
        return _slideIt(oldItem, animation);
      },
    );
  }

  Widget _slideIt(Widget item, animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOut,
        ),
      ),
      child: item,
    );
  }

  void handleAd(String? screenName) {
    for (final adView in _listAdView) {
      final ad = adView.data!;
      final adsProvider = getAdsProvider(ad.provider);
      // Handle show ads
      if (ad.showOnScreens.isEmpty) continue;

      if (ad.showOnScreens.contains(screenName)) {
        if (!adView.active) {
          adView.active = true;
          final ad = adView.data!;
          switch (ad.type) {
            case AdvertisementType.banner:
              _addAdsWidget(widget: adsProvider!.createAdWidget(adItem: ad));
              break;
            case AdvertisementType.reward:
            case AdvertisementType.native:
            case AdvertisementType.interstitial:
              adsProvider!.showAd(adItem: ad);
              break;
          }
        }
      }

      // Handle hide ads
      if (ad.hideOnScreens.contains(screenName) ||
          (ad.showOnScreens.isNotEmpty &&
              !ad.showOnScreens.contains(screenName))) {
        EasyDebounce.cancel(ad.id);
        if (adView.active) {
          adView.active = false;
          switch (ad.type) {
            case AdvertisementType.banner:
              _removeAdsWidget(ad.id);
              break;
            default:
              adsProvider!.hideAd(ad.id);
              break;
          }
        }
      }
    }
  }

  void _addAdsWidget({required Widget widget}) {
    final index = _adsWidget.length;
    _adsWidget.insert(index, widget);
  }

  void _removeAdsWidget(String key) {
    _adsWidget.removeWhere((element) => element.key == ValueKey(key));
  }
}
