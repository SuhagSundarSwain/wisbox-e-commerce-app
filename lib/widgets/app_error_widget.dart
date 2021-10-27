import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nexmat/app_configs/app_assets.dart';

class AppErrorWidget extends StatelessWidget {
  final String? title, subtitle, buttonText, assetPath;
  final VoidCallback? onRetry;
  final Color? textColor;
  final double size;

  const AppErrorWidget(
      {this.title,
      this.subtitle,
      this.buttonText,
      this.assetPath,
      this.size = 140,
      this.onRetry,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // SvgPicture.asset(
        //   assetPath ?? AppAssets.error,
        //   height: size,
        // ),
        const SizedBox(height: 32),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(title ?? 'Error',
                style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
        ),
        if (onRetry != null)
          MaterialButton(
            onPressed: onRetry,
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            child: Text(buttonText ?? 'Retry'),
          )
      ],
    );
  }
}

class AppEmptyWidget extends StatelessWidget {
  final String? title, subtitle, buttonText, assetPath;
  final VoidCallback? onReload;
  final Color? textColor;

  const AppEmptyWidget(
      {this.title,
      this.subtitle,
      this.buttonText,
      this.assetPath,
      this.onReload,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // SvgPicture.asset(
        //   assetPath ?? AppAssets.noData,
        //   height: 140,
        // ),
        const SizedBox(height: 32),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(title ?? 'Empty',
                style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
        ),
        if (onReload != null)
          MaterialButton(
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: onReload,
            child: Text(buttonText ?? 'Reload'),
          )
      ],
    );
  }
}

class AppNoInternetWidget extends StatelessWidget {
  final String? title, subtitle, buttonText, assetPath;
  final Color? textColor;
  final VoidCallback? onRetry;

  const AppNoInternetWidget(
      {this.title,
      this.subtitle,
      this.textColor,
      this.buttonText,
      this.assetPath,
      this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // SvgPicture.asset(
        //   assetPath ?? AppAssets.noInternet,
        //   height: 140,
        // ),
        const SizedBox(height: 32),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Text(title ?? 'Connection lost',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
          child: Text(subtitle ?? 'No internet connection',
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor, fontSize: 16)),
        ),
        if (onRetry != null)
          MaterialButton(
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: onRetry,
            child: Text(buttonText ?? 'Retry'),
          )
      ],
    );
  }
}
