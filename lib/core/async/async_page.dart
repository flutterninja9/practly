import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practly/core/async/out_of_credits_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'async_value.dart';

class AsyncPage<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T data) dataBuilder;
  final Widget Function()? loadingBuilder;
  final Widget Function()? outOfCreditsBuilder;
  final Widget Function()? errorBuilder;
  final Function()? onRetry;

  const AsyncPage({
    super.key,
    required this.asyncValue,
    required this.dataBuilder,
    this.loadingBuilder,
    this.outOfCreditsBuilder,
    this.errorBuilder,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      loading: () => loadingBuilder?.call() ?? const _LoadingWidget(),
      data: (data) => dataBuilder(data),
      empty: () => const _EmptyWidget(),
      outOfCredits: () =>
          outOfCreditsBuilder?.call() ??
          OutOfCreditsWidget(
            onAdSeen: () async {
              await onRetry?.call();
            },
          ),
      error: (error) =>
          errorBuilder?.call() ??
          _ErrorWidget(
            error: error,
            onRetry: onRetry,
          ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ShadImage.square(size: 64, LucideIcons.inbox),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: ShadTheme.of(context).textTheme.h4,
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: ShadTheme.of(context).textTheme.small,
          ),
        ],
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
      child: ShadCard(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ShadImage.square(size: 64, LucideIcons.triangleAlert),
              const SizedBox(height: 24),
              Text(
                'Oops! Something went wrong',
                style: ShadTheme.of(context).textTheme.h4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                kDebugMode
                    ? error.toString()
                    : "Hang tight! We’ll get this sorted out quickly.",
                style: ShadTheme.of(context).textTheme.small,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (onRetry != null)
                ShadButton.destructive(
                  onPressed: onRetry,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShadImage.square(size: 20, LucideIcons.refreshCw),
                      SizedBox(width: 8),
                      Text('Retry'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
