import 'package:flutter/material.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context); //Pilla la instancia creada en Main 
    //print(moviesProvider.popularMovie);
   // print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cartelera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            
            children: [

              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovies), //Muestra la lista de imagenes principal con las peliculas en cartelerar
              
              // Slider de pel·licules
              MovieSlider(movies: moviesProvider.popularMovie), //Muestra mas abajo otra lista de peliculas con las peliculas famosas
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),

            ],
          ),
        )
      )
    );
  }
}
