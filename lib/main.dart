import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const MyConsumerWidget(),
            // Consumerを使って受け取る
            Consumer(
              builder: (context, ref, child) {
                final data = ref.watch(provider);
                return Text(data);
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final asyncValue = ref.watch(futureProvider);

                return asyncValue.when(
                  data: (data) => Text(data),
                  error: (e, stackTrace) => const Text('error'),
                  loading: () => const CircularProgressIndicator(),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final asyncValue = ref.watch(streamProvider);

                return asyncValue.when(
                  data: (data) => Text(data.toString()),
                  error: (e, stackTrace) => const Text('error'),
                  loading: () => const CircularProgressIndicator(),
                );
              },
            ),
            StateProviderComsumer(),
            TodoConsumer(),
            OverrideConsumer(),
            CombineProviderWidget(),
            RefrashProviderWidget(),
          ],
        ),
      ),
    );
  }
}

// ConsumerWidgetを利用して受け取る
class MyConsumerWidget extends ConsumerWidget {
  const MyConsumerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(provider);
    return Text(data);
  }
}

class StateProviderComsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(ref.watch(stateProvider).toString()),
        ElevatedButton(
          onPressed: () {
            ref.read(stateProvider.notifier).state++;
          },
          child: const Text('Button'),
        ),
      ],
    );
  }
}

class TodoConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(ref.watch(todoNotifierProvider).toString()),
        ElevatedButton(
          onPressed: () {
            ref.read(todoNotifierProvider.notifier).addTodo();
          },
          child: const Text('Button'),
        ),
      ],
    );
  }
}

class OverrideConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textList = ['Hello', 'World'];
    return Column(
      children: [
        for (var value in textList)
          ProviderScope(
            overrides: [
              textProvider.overrideWithValue(value),
            ],
            child: TextWidget(),
          ),
      ],
    );
  }
}

class TextWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(textProvider);
    return Text(text);
  }
}

class CombineProviderWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider);

    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              ref.read(cityProvider.notifier).update((state) => "Newyork");
            },
            child: Text('push')),
        weather.when(
          data: (data) {
            return Text(data);
          },
          error: (err, stackTrace) {
            return Text(err.toString());
          },
          loading: () {
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}

class RefrashProviderWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    return Column(
      children: [
        Text(date.toString()),
        ElevatedButton(
            onPressed: () {
              ref.refresh(dateProvider);
            },
            child: Text('push'))
      ],
    );
  }
}
