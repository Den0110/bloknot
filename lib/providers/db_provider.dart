import 'package:bloknot/db/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbProvider = Provider((ref) => AppDatabase());
