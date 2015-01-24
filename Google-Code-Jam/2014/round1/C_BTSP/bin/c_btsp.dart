import 'dart:io';
//import 'dart:math';


void main() {

  const String inputFileName = "input.txt";
  const String outputFileName = "output.txt";
  
  var inputFile = new File(inputFileName);
  var outputFile = new File(outputFileName);
  inputFile.readAsLines().then((List<String> lines) {
    
    var linesIterator = lines.iterator;
    linesIterator.moveNext();
    
    var T = int.parse(linesIterator.current);
    print("T = $T");
    
    var out = outputFile.openWrite();
    
    for (var t=1; t<=T; t++) {
      
      linesIterator.moveNext();
      var NM = linesIterator.current.split(' ');
      var N = int.parse(NM[0]);
      var M = int.parse(NM[1]);

      //print("N=$N");

      var zips = new List<int>();
      for (int n=0; n<N; n++) {
        linesIterator.moveNext();
        zips.add(int.parse(linesIterator.current));
      }
      
      var flights = new List<String>();
      for (int m=0; m<M; m++) {
        linesIterator.moveNext();
        flights.add(linesIterator.current);
      }

      var solution = solve(zips, flights);          
      
      out.writeln("Case #$t: $solution");
      print("Case #$t: $solution");
      
    }    
    
    out.close().then((_) => print("done"));
    
  });  

}

class city
{
  int zip;
  int index;
  List<int> flights;
}


String solve(List<int> zips, List<String> flights) {


  var cities = new List<city>();
  for (var i=0; i<zips.length; i++) {
    var c = new city()
      ..zip = zips[i]
      ..index = i+1
      ..flights = new List<int>();
    cities.add(c);
  }
  
  for (var i=0; i<flights.length; i++) {
   var ft = flights[i].split(' ');
   var from = int.parse(ft[0]);
   var to = int.parse(ft[1]);
   cities[from-1].flights.add(to);
   cities[to-1].flights.add(from);
  } 


  cities.sort((city c1, city c2) => c1.zip.compareTo(c2.zip));
  
  for (var city in cities) {
    var path = new List<int>();
    path.add(city.index);
    var sol = solve_rec(path, cities);
    if (sol != null)
      return sol;
  }
  
  return null;
  

}

String solve_rec(List<int> path, List<city> cities)
{
  
  var currentCityIndex = path[path.length - 1];
  var currentCity = cities.where((city c) => c.index == currentCityIndex).first;
  
  if (tripComplete(path, cities)) {
    var sb = new StringBuffer();
    var printed = new List<int>();
    for (var i=0; i<path.length; i++) {
      if (!printed.contains(path[i])) {
        printed.add(path[i]);
        var city = cities.where((c) => c.index == path[i]).first;
        sb.write(city.zip);
      }
    }
    
    path.add(cities.where((city c) => !path.contains(c.index)).first.index);
    return solve_rec(path, cities);
  }
  
}

bool tripComplete(List<int> path, List<city> cities) {
  return path.length == cities.length; // TODO
}





















