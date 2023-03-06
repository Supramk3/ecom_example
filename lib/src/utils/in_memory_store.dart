import 'dart:ffi';

import 'package:rxdart/subjects.dart';

// An in-memory store backed by Behavior Subject that can be used to store the data for all the
//fake repositories in the app

class InMemoryStore<T> {
  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);

  // the behavior subject that holds the data
  final BehaviorSubject<T> _subject;

  // the output stream that can be used to listen to the data

  Stream<T> get stream => _subject.stream;

  // a synch getter for the current value
  T get value => _subject.value;
  set value(T value) => _subject.add(value);

  ///close the stream
  void close() => _subject.close();
}
