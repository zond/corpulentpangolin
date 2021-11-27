import 'package:dcache/dcache.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final webCache =
    LruCache<Uri, ValueNotifier<String?>>(storage: InMemoryStorage(64))
      ..loader = (Uri key, ValueNotifier<String?>? old) {
        final result = ValueNotifier<String?>(null);
        http.get(key).then((resp) {
          result.value = resp.body;
        });
        return result;
      };
