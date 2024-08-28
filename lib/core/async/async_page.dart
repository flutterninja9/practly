import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'async_value.dart';

class AsyncPage<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T data) dataBuilder;
  final Widget Function()? loadingBuilder;
  final Widget Function()? errorBuilder;
  final VoidCallback? onRetry;

  const AsyncPage({
    super.key,
    required this.asyncValue,
    required this.dataBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      loading: () =>
          loadingBuilder?.call() ??
          const Center(child: CircularProgressIndicator()),
      data: (data) => dataBuilder(data),
      empty: () => const Text("No results found!"),
      error: (error) =>
          errorBuilder?.call() ??
          _ErrorWidget(
            error: error,
            onRetry: onRetry,
          ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const _ErrorWidget({
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Oops! something went wrong',
            style: TextStyle(color: Colors.red),
          ),
          if (onRetry != null)
            ShadButton.destructive(
              onPressed: onRetry,
              child: const Text('Retry'),
            )
        ],
      ),
    );
  }
}
