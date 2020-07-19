import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';

class MockAuth extends Mock implements AuthBase {}

class MockDatabase extends Mock implements Database {}

class MockNavigatorObsserver extends Mock implements NavigatorObserver {}
