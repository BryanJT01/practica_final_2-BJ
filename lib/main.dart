import 'package:flutter/material.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:practica_final_2/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState()); //Appstate sera le primer widget creado al inicio de la app 

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider( //Gestiona los proveedores de datos de la clase movies_provider
      providers: [
        ChangeNotifierProvider(
          create: ( _ ) => MoviesProvider(), 
          lazy: false,) //lazzy false obliga a que se cree un movie provider a la vez que se defina el changenotifier
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(), //Muestra el cardSwiper y el MovieSlider
        'details': (BuildContext context) => DetailsScreen(), //Cuando se pulsa una peli se va a esta ventana
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: AppBarTheme(color: Colors.cyan)),
    );
  }
}
