import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'api.dart';
import 'detail.dart';
import 'main.dart';
import 'movie.dart';
class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState()=>_HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>{
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;
  late List<String> myString= [];


  var nameController=TextEditingController();
  // Save the list of strings to SharedPreferences


  // Retrieve the list of strings from SharedPreferences

  @override
  void initState() {
    super.initState();
   trendingMovies=Api().getTrendingMovies() ;
    topRatedMovies=Api().getTopRatedMovies() ;
    upcomingMovies=Api().getupcomingMovies() ;

loadData();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Image.asset('lib/netflixlogo.jpg',
        fit: BoxFit.cover,
          height: 100,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,

      ),
body: SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text('Trending Movies',style: GoogleFonts.aBeeZee(fontSize: 25,),),
       SizedBox(
         height: 20,
       ),

       SizedBox(
         child:FutureBuilder(
           future: trendingMovies,
           builder:(context,snapshot){
             if(snapshot.hasError){
               return Center(
                 child:Text(snapshot.error.toString()),
               );
             }
             else if(snapshot.hasData){
               return  CarouselSlider.builder(
                 itemCount: snapshot.data?.length,
             itemBuilder: (context, itemIndex, pageViewIndex){
             return GestureDetector(
               onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailsScreen(
                     movie:snapshot.data![itemIndex]
                 ),
                 ));
               },
               child: ClipRRect(
               borderRadius:BorderRadius.circular(12),
                 child: SizedBox(
                   height:300,
                   width:200,
                   child: Stack(

                     fit: StackFit.expand,
                     children: [Image.network('https://image.tmdb.org/t/p/w500${snapshot.data?[itemIndex].posterPath}',
                       filterQuality: FilterQuality.high,
                       fit: BoxFit.cover,),
                       Positioned(
                         top: 0,
                         left: 0,
                         child:Container(
                           height: 50,
                           width: 50,
                           margin: EdgeInsets.only(top:0,left:0),
                           decoration:BoxDecoration(
                             color:Colours.scaffoldByColor,
                             borderRadius: BorderRadius.circular(8),
                           ),
                           child:IconButton(onPressed:(){

                             Future<void> saveData() async {
                               var name=snapshot.data?[itemIndex].posterPath;
                               final prefs = await SharedPreferences.getInstance();
                               final key = 'myStringsKey';

                               myString.add(name!);
                               final value = myString.join(';'); // Convert list to a single string
                               await prefs.setString(key, value);
                               print('List of strings saved');
                             }

                             saveData();
                             loadData();
                           } ,icon:Icon(Icons.watch_later)),
                         ),
                       ),
                     ], ),


                 ),
               ),
             );
             } ,
             options: CarouselOptions(
             height:300,
             autoPlay: true,
             viewportFraction: 0.55,
             enlargeCenterPage: true,
             autoPlayCurve: Curves.fastOutSlowIn,
             autoPlayAnimationDuration: Duration(seconds:1),
             ),


             );
             }
             else{
               return Center(child:CircularProgressIndicator());
             }
           },
         ),
         width: double.infinity,

       ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Top rated Movies',
          style:GoogleFonts.aBeeZee(fontSize: 25,)
        ),
        SizedBox(height: 30,),
        SizedBox(
          child:FutureBuilder(
            future: topRatedMovies,
            builder:(context,snapshot){
              if(snapshot.hasError){
                return Center(
                  child:Text(snapshot.error.toString()),
                );
              }
              else if(snapshot.hasData){
                return
                  SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailsScreen(
                              movie:snapshot.data![index],
                            ),
                            ));


                          },
                          child: ClipRRect(

                            borderRadius: BorderRadius.circular(8) ,
                            child: SizedBox(
                              height:300,
                              width:200,
                                child: Stack(

fit: StackFit.expand,
                                  children: [Image.network('https://image.tmdb.org/t/p/w500${snapshot.data?[index].posterPath}',
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child:Container(
                                        height: 50,
                                        width: 50,
                                        margin: EdgeInsets.only(top:0,left:0),
                                        decoration:BoxDecoration(
                                          color:Colours.scaffoldByColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child:IconButton(onPressed:(){
                                          Future<void> saveData() async {
                                            var name=snapshot.data?[index].posterPath;
                                            final prefs = await SharedPreferences.getInstance();
                                            final key = 'myStringsKey';

                                            myString.add(name!);
                                            final value = myString.join(';'); // Convert list to a single string
                                            await prefs.setString(key, value);
                                            print('List of strings saved');
                                          }

                                          saveData();
                                          loadData();
                                        } ,icon:Icon(Icons.watch_later)),
                                      ),
                                    ),
                               ], ),


                            ),
                          ),
                        ),
                      );
                    },),
                );
              }
              else{
                return Center(child:CircularProgressIndicator());
              }
            },
          ),
          width: double.infinity,

        ),

        SizedBox(
          height: 30,
        ),
        Text(
            'Upcoming Movies',
            style:GoogleFonts.aBeeZee(fontSize: 25,)
        ),
        SizedBox(height: 30,),
        SizedBox(
          child:FutureBuilder(

            future: upcomingMovies,

            builder:(context,snapshot){
              if(snapshot.hasError){
                return Center(
                  child:Text(snapshot.error.toString()),
                );
              }
              else if(snapshot.hasData){
                return    SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailsScreen(
                                movie:snapshot.data![index],
                            ),
                            ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8) ,
                            child: SizedBox(
                              height:300,
                              width:200,
                              child: Stack(

                                fit: StackFit.expand,
                                children: [Image.network('https://image.tmdb.org/t/p/w500${snapshot.data?[index].posterPath}',
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child:Container(
                                      height: 50,
                                      width: 50,
                                      margin: EdgeInsets.only(top:0,left:0),
                                      decoration:BoxDecoration(
                                        color:Colours.scaffoldByColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child:IconButton(onPressed:(){
                                        Future<void> saveData() async {
                                          var name=snapshot.data?[index].posterPath;
                                          final prefs = await SharedPreferences.getInstance();
                                          final key = 'myStringsKey';

                                          myString.add(name!);
                                          final value = myString.join(';'); // Convert list to a single string
                                          await prefs.setString(key, value);
                                          print('List of strings saved');
                                        }

                                        saveData();
                                        loadData();
                                      } ,icon:Icon(Icons.watch_later)),
                                    ),
                                  ),
                                ], ),


                            ),
                          ),
                        ),
                      );
                    },),
                );
              }
              else{
                return Center(child:CircularProgressIndicator());
              }
            },
          ),
          width: double.infinity,

        ),

        SizedBox(
          height: 30,
        ),
        Text(
            'WatchList Movies',
            style:GoogleFonts.aBeeZee(fontSize: 25,)
        ),
        SizedBox(height: 30,),
        SizedBox(
          height: 250,
width: double.infinity,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: myString.length,
            itemBuilder: (context, index) {
              final currentString = myString[index];
              if(currentString.isNotEmpty){
              return Padding(
                padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8) ,
                child: SizedBox(
                  height:300,
                  width:200,

                  child: Image.network('https://image.tmdb.org/t/p/w500${myString[index]}',
                                                    filterQuality: FilterQuality.high,
                                                    fit: BoxFit.cover,),
                ),
              ),
                                            );}
              else {
                // Handle empty strings here or return a placeholder widget
                return SizedBox.shrink(); // To hide empty strings
              }

            },
          ),
        ),



      ],
    ),
  ),
),
    );
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'myStringsKey';

    final value = prefs.getString(key) ?? ''; // Retrieve the stored string
    final list = value.split(';'); // Convert the stored string back to a list
    setState(() {
      myString = list;
    });
    print('List of strings loaded');

  }
  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('All data cleared from SharedPreferences');
  }

}



