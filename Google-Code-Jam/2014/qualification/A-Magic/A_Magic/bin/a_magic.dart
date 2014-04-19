import 'dart:io';


void main() {


  const String inputFileName = "A-small-attempt0.in";
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
      var first = int.parse(linesIterator.current);
      print("first=$first");
      
      var firstElements = new Set<String>();
      var secondElements = new Set<String>();
      
      for (int i=1;i<=4;i++) {
        linesIterator.moveNext();
        if (i == first) {
          firstElements.addAll(linesIterator.current.split(" "));
        }
      }
      
      linesIterator.moveNext();
      var second = int.parse(linesIterator.current);
      print("second=$second");
      
      for (int i=1;i<=4;i++) {
        linesIterator.moveNext();
        if (i == second) {
          secondElements.addAll(linesIterator.current.split(" "));
        }
      }
      
      var intersect = firstElements.intersection(secondElements);
      
      String solution;
      switch (intersect.length) {
        case 0: solution = "Volunteer cheated!"; break;
        case 1: solution = intersect.first; break;
        default: solution = "Bad magician!";        
      }
           
      
      out.writeln("Case #$t: $solution");
      print("Case #$t: $solution");
      
    }    
    
    out.close().then((_) => print("done"));
    
  });  

}

