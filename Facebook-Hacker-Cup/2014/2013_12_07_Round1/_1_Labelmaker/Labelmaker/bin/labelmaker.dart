import 'dart:io';


void main() {
  
  var inputFileName = "labelmaker.txt";
  var outputFileName = "output.txt";
  
  var inputLines = new File(inputFileName).readAsLinesSync().iterator;
  inputLines.moveNext();
  
  var T = int.parse(inputLines.current);
  inputLines.moveNext();
  print ('T = $T');
  
  var outputFile = new File(outputFileName);
  if (outputFile.existsSync()) {
    outputFile.delete();
  }
  
  for (var i=1;i<=T;i++) {
    print('\ni=$i');
    
    var LN = inputLines.current.split(' ');
    var L = LN[0];
    var N = int.parse(LN[1]);

    inputLines.moveNext();
    
    print('L=$L');
    print('N=$N');
    
    var solution = computeSolution(L, N);
    var output = 'Case $i: $solution\n';
    print (output);
    outputFile.writeAsStringSync(output, mode: FileMode.APPEND);
    
  };
  print('-- DONE! -- ');

}


String computeSolution(String L, int N)
{
  
  var c=L.length;
  while (N>c)
  {
    N-=c;
    c*=L.length;  
  }
  
  var sb = new StringBuffer();
  N--;
  
  do {
    c = c ~/ L.length;
    var v = N ~/ c;
    N = N % c;
    sb.write(L[v]);    
  } while (c>1);
  
  
  
  return sb.toString();
  
  
}



