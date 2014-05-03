import 'dart:io';
//import 'dart:math';

void main() {

  const String inputFileName = "A-large.in";
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
      var N = int.parse(linesIterator.current);
      
      //print("N=$N");

      var strings = new List<String>();
      for (int n=0; n<N; n++) {
        linesIterator.moveNext();
        strings.add(linesIterator.current);
      }
      

      var solution = solve(strings);          
      
      out.writeln("Case #$t: $solution");
      print("Case #$t: $solution");
      
    }    
    
    out.close().then((_) => print("done"));
    
  });  

}

String solve(List<String> strings) {
  var unr = unrepeated(strings[0]);
  for (var i=1; i<strings.length; i++) {
    if (unrepeated(strings[i]) != unr)
      return "Fegla Won";
  }
  
  var totalDistance = 0;
  for (var i=0; i<unr.length; i++) {

    var counts = new List<int>();
    for (var j=0; j<strings.length;j++) {
      var count = 0;
      while ((count<strings[j].length) && (strings[j][count]==unr[i])) count++;
      strings[j] = strings[j].substring(count);
      counts.add(count);
    }
      
    counts.sort();
    var min = counts[0];
    var max = counts[counts.length - 1];
    var bestDistance = -1;
    for (var q = min; q<= max; q++) {
      var d = 0;
      for (var m=0; m<counts.length;m++) {
        d += (counts[m]-q).abs(); 
      }
      if ((bestDistance==-1) || (d < bestDistance))
        bestDistance = d;
    }
    
    totalDistance += bestDistance;
    
  }  
  
  return totalDistance.toString();
  
}

String unrepeated(String s) {
  var sb = new StringBuffer();
  String last = null;
  if (s.length>0) {
    for (var i=0; i<s.length; i++) {
      var c = s[i];
      if ((last==null) || (last!=c)) {
        last = c;
        sb.write(c);
      }
    }
  }
  return sb.toString();
}

int editDistance(String a, String b, String unr) {
  if (a == b) return 0;
  var d=0;

  for (var i=0; i<unr.length; i++) {
    var countA = 0;
    var countB = 0;
    while ((countA<a.length) && (a[countA]==unr[i])) countA++;
    while ((countB<b.length) && (b[countB]==unr[i])) countB++;
    var dd = countA - countB;
    if (dd<0) dd=-dd;
    d+=dd;
    
    a = a.substring(countA);
    b = b.substring(countB);
    
  }
  
  return d;
}






















