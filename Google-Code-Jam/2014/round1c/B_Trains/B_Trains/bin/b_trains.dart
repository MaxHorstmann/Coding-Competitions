import 'dart:io';
import 'dart:collection';


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
      linesIterator.moveNext(); // ignore N
      linesIterator.moveNext();
      var inputLine = linesIterator.current;
      var sets = inputLine.split(" ");
      
      var cache = new HashMap<String, int>();
      var solution = computeSolution(sets, cache, 0);
      out.writeln("Case #$t: $solution");
      print("Case #$t: $solution");
      
      
    }    
    
    out.close().then((_) => print("done"));
    
  });  

}

int computeSolution(List<String> sets, Map<String, int> cache, int depth) {

  //sets.sort();
  var key = sets.join('-');
  
    
  if (cache.containsKey(key)) {
    var n = cache[key];
    if (n==1) {
      print("($depth) computeSolution $key  --> cache hit, $n");
    }
    return cache[key];
  }
  
  //print("($depth) computeSolution $key");
  
  
  if (sets.length == 1) {
    if (testSolution(sets[0])) {
      cache[key] = 1;
      return 1;
    } else {
      cache[key] = 0;
      return 0;
    }
    
  }
 
//  var letterCounts = new HashMap<String, int>();
//  for (var i=0; i<sets.length; i++) {
//    if (sets[i].length>2) {
//      // TODO check for isolated letters
//    }
//    sets[i] = sets[i][0] + sets[i][sets[i].length-1];
//    var firstLetter = letterCounts[sets[i][0]];
//    var lastLetter = letterCounts[sets[i][1]];
//    if (letterCounts.containsKey(firstLetter)) {
//      letterCounts[firstLetter]++;
//    } else {
//      letterCounts[firstLetter]=1;
//    }
//      
//    if (letterCounts.containsKey(lastLetter)) {
//      letterCounts[lastLetter]++;
//    } else {
//      letterCounts[lastLetter]=1;
//    }
//    
//  }
    
  
  // try first set with every other
  var first = sets[0];
  var solutions = 0;
  
  for (var i=1; i<sets.length; i++) {
    var curr = sets[i];
    
      var newSets = new List<String>();
      newSets.add(first + curr);
      for (var j=1; j<sets.length; j++) {
        if (i!=j) newSets.add(sets[j]);
      }
      solutions += computeSolution(newSets, cache, depth+1) % 1000000007;
    
//      newSets = new List<String>();
//      newSets.add(curr + first);
//      for (var j=1; j<sets.length; j++) {
//        if (i!=j) newSets.add(sets[j]);
//      }
//      solutions += computeSolution(newSets, cache, depth+1) % 1000000007;
    
  }
  
  //cache[key] = solutions;  
  return solutions;

}


bool testSolution(String s) {
  var letters = new HashSet<String>();
  var prev = ' ';
  for (var i=0; i<s.length; i++) {
    if (s[i] != prev) {
      if (letters.contains(s[i])) return false;
      prev = s[i];
      letters.add(s[i]);
    }
  }
  print (" -- solution found: $s");
  return true;
}













