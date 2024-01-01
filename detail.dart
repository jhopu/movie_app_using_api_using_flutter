import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'movie.dart';
class DetailsScreen extends StatelessWidget{
  DetailsScreen({super.key,required this.movie,});
  final Movie movie;

  @override
  Widget build(BuildContext context){
    return Scaffold(

      body:CustomScrollView(slivers:[SliverAppBar.large(
        leading: Container(
          height: 70,
          width: 70,
          margin: EdgeInsets.only(top:16,left:16),
          decoration:BoxDecoration(
            color:Colours.scaffoldByColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child:IconButton(onPressed:(){
            Navigator.pop(context);
          } ,icon:Icon(Icons.arrow_back_rounded)),
        ),

        backgroundColor:Colours.scaffoldByColor ,
        expandedHeight: 500,
        pinned:true,
        floating:true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(movie.title,
          style:GoogleFonts.belleza(
            fontSize: 17,fontWeight: FontWeight.bold,
          ),),
          background: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: Image.network('https://image.tmdb.org/t/p/w500${movie.backDropPath}',
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
         padding: EdgeInsets.all(12),
         child: Column(
           children: [
             Text('Overview',
           style:GoogleFonts.belleza(
             fontSize: 30,fontWeight: FontWeight.bold,),),
SizedBox(
  height: 60,
),
         Text(movie.overview,style:GoogleFonts.roboto(
           fontSize: 20,fontWeight: FontWeight.w400,),
           textAlign: TextAlign.justify,
         ),
             SizedBox(
               height: 16,
             ),
             SizedBox(

               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Container(
                     padding: EdgeInsets.all(8),
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey),
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Row(
                       children: [
                         Text('Release date:',style:GoogleFonts.roboto(
                           fontSize: 15,fontWeight: FontWeight.bold,),),
                         Text(movie.releaseDate,
                           style:GoogleFonts.roboto(
                             fontSize: 15,fontWeight: FontWeight.bold,),),
                       ],
                     ),
                   ),
                   Container(
                     padding: EdgeInsets.all(8),
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey),
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Row(
                       children: [
                         Text('Rating:',style:GoogleFonts.roboto(
                           fontSize: 15,fontWeight: FontWeight.bold,),),
                         Icon(Icons.star,
                         color: Colors.amber,),
                         Text('${movie.voteAverage.toStringAsFixed(1)}/10',style:GoogleFonts.roboto(
                           fontSize: 15,fontWeight: FontWeight.bold,),)
                       ],
                     ),
                   ),
                 ],
               ),
             ),

           ],
         ),
        ),
      ),
      ]),

    );
  }
}









