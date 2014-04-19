import 'dart:io';


void main() {


  const String inputFileName = "B-large.in";
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
      var inputLine = linesIterator.current;
      var CFX = inputLine.split(" ");
      var C = double.parse(CFX[0]);
      var F = double.parse(CFX[1]);
      var X = double.parse(CFX[2]);
      
      print("C=$C, F=$F, X=$X");
      
      var solution = computeSolution(C,F,X);
      out.writeln("Case #$t: $solution");
      print("Case #$t: $solution");
      
      
    }    
    
    out.close().then((_) => print("done"));
    
  });  

}

double computeSolution(double C, double F, double X) {
  
  double best = double.MAX_FINITE;
  
  var numberOfFactories = -1;
  while (true) {
    numberOfFactories++;
    
    var rate = 2.0;
    var time = 0.0;
    for (var i=0; i<numberOfFactories;i++) {
      time += C / rate;
      rate += F;      
    }
    
    time += X/rate;
    
    if (time >= best) return best;
    
    best = time;
    
  }

}













