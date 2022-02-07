import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    // TODO: Canviar després per una instància de Peli
    final peli = ModalRoute.of(context)?.settings.arguments as Movie; //requiere de un objeto movie del que recibe los datos
  

    return Scaffold( 
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(movie: peli,), //muetra el titulo de la pelicula y la imagen de fondo
            SliverList(
              delegate: SliverChildListDelegate([
                _PosterAndTitile(movie: peli), //muestra la imagen principal con los titulos y el ranking de la peli
                _Overview(movie: peli), //muestra la descripcion de la peli
                //_Overview(movie: peli),
                CastingCards(peli.id) // muestra a la lista de actores
              ])
            )
          ],
        )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: EdgeInsets.only(bottom: 10),
          child: Text( 
            movie.title, //titulo de la peli
            style: TextStyle(fontSize: 16)
            ,
          ),
        ),

        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath), //imagen de fondo
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitile({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container( 
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect( //recuadro donde se acomoda la imagen principal de la peli
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(movie.fullPosterPath),
              height: 150,
            ),
          ),
          SizedBox(width: 20,),
          ConstrainedBox( //se usa un constrained boz para ajustar el texto en un espacio y alinearlo a la izquierda
            constraints:  BoxConstraints(
              maxWidth: 200
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ //muestra el titulo y el titulo original
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Row( //muestra el raiting de la peli
                  children: [
                    Icon(Icons.star_outline,size: 15, color: Colors.grey),
                    SizedBox(width: 5,),
                    Text(movie.voteAverage.toString(), style: textTheme.caption),
          
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
   final Movie movie;

  const _Overview({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( //retirna un contenedor con la descripcion de la pelicula
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}