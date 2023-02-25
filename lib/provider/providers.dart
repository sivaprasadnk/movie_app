import 'package:movie_app/provider/app.provider.dart';
import 'package:movie_app/provider/auth.provider.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<MoviesProvider>(
    create: (_) => MoviesProvider(),
  ),
  ChangeNotifierProvider<AppProvider>(
    create: (_) => AppProvider(),
  ),
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => AuthProvider(),
  ),
];
