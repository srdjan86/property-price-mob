import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Widget child;
  final Function(T) onModelReady;
  // final Function(T, BuildContext) navigation;
  final T viewModel;
  final bool enableLoading;

  BaseWidget({
    Key key,
    this.builder,
    this.child,
    this.onModelReady,
    // this.navigation,
    this.viewModel,
    this.enableLoading = true,
  }) : super(key: key);

  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {
  T viewModel;
  // VoidCallback _navigationListener;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      viewModel.init();
      if (widget.onModelReady != null) {
        widget.onModelReady(viewModel);
      }
    });

    // if (widget.navigation != null) {
    //   _navigationListener = () => widget.navigation(viewModel, context);
    //   viewModel.addListener(_navigationListener);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: viewModel,
      child: Consumer<T>(
        builder: (BuildContext context, T viewModel, Widget child) {
          return Stack(
            children: <Widget>[
              widget.builder(context, viewModel, child),
              if (widget.enableLoading)
                viewModel.busy ? CircularProgressIndicator() : SizedBox(),
            ],
          );
        },
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    // viewModel.removeListener(_navigationListener);
    super.dispose();
  }
}
