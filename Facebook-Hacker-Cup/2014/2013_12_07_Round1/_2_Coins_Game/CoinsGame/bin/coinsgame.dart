import 'dart:io';


void main() {
  
  var inputFileName = "coins_game.txt";
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

    
    
    var NKC = inputLines.current.split(' ');
    var N = int.parse(NKC[0]);
    var K = int.parse(NKC[1]);
    var C = int.parse(NKC[2]);
    
    inputLines.moveNext();
    
    print('N=$N');
    print('K=$K');
    print('C=$C');
    
    
    var solution = computeSolution(N,K,C);
    var output = 'Case $i: $solution\n';
    print (output);
    outputFile.writeAsStringSync(output, mode: FileMode.APPEND);
    
  };

}


int computeSolution(int N, int K, int C)
{
  if (K%N == 0)
    return C;

  if (N>K)
  {
    return N-K+C;
  }
  else  
  {
    
    for (var i=1; i<=K; i++) {
     if ((K%i) > 0) continue;
     if ((K~/i)<=N) {
       return N-(K~/i)+C;
     }
    }
    
    return 0; // won't happen
  }


}



