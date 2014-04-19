import 'dart:io';


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
      var inputLine = linesIterator.current;
      var RCM = inputLine.split(" ");
      var R = int.parse(RCM[0]);
      var C = int.parse(RCM[1]);
      var M = int.parse(RCM[2]);
      
      print("R=$R, C=$C, M=$M");
      
      out.writeln("Case #$t:");
      print("Case #$t:");
      
      var solution = computeSolution(R,C,M);
      out.writeln(solution);
      print(solution);
      
    }    
    
    out.close().then((_) => print("done"));
    
  });  

}

String computeSolution(int R, int C, int M) {
  
  var grid = new int[R][C];
  
  
  
  
  return "Impossible";
}













