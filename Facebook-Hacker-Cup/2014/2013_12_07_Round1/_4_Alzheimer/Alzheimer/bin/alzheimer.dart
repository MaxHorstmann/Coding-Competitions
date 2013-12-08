import 'dart:io';
import 'dart:math';


// source http://www.geeksforgeeks.org/print-all-prime-factors-of-a-given-number/
Set<int> primeFactors(int n) {

  var pf = new Set<int>();

    // Print the number of 2s that divide n
    while (n%2 == 0)
    {
      pf.add(2);
      n = n~/2;
    }
 
    // n must be odd at this point.  So we can skip one element (Note i = i +2)
    for (int i = 3; i <= sqrt(n); i = i+2)
    {
        // While i divides n, print i and divide n
        while (n%i == 0)
        {
            pf.add(i);
            n = n~/i;
        }
    }
 
    // This condition is to handle the case whien n is a prime number
    // greater than 2
    if (n > 2)
        pf.add(n);
    
    return pf;
}

void main() {
  
 
  var inputFileName = "preventing_alzheimers_example_input.txt";
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
    
    var NK = inputLines.current.split(' ');
    var N = int.parse(NK[0]);
    var K = int.parse(NK[1]);

    inputLines.moveNext();
    
    print('N=$N');
    print('K=$K');
    
    var Astr = inputLines.current.split(' ');
    var A = new List<int>();
    for (int i=0;i<N;i++) {
      A.add(int.parse(Astr[i]));
    }
    A.sort();
    print(A);
    inputLines.moveNext();
    
    var solution = computeSolution(N, K, A);
    var output = 'Case $i: $solution\n';
    print (output);
    outputFile.writeAsStringSync(output, mode: FileMode.APPEND);
    
  };
  print('-- DONE! -- ');

}


bool dividesByAny(int n, List<int> factors)
{
  if (factors.length == 0)
    return false;
  
  for (int i=0; i<factors.length; i++) {
    if ((n % factors[i])==0)
      return true;
  }
  return false;
}




int computeSolution(int N, int K, List<int> A, [ List<int> factors = null])
{
  if (A.length==0) {
    return 0;
  }
  
  if (factors == null) {
    factors = new List<int>();
  }

  var a = A[0];
  var max = 100;
  
  var best = 0;
  var found = false;
  
  for (var a2=a;a2<max;a2++) {
    if (dividesByAny(a2, factors))
      continue;
    
    var Anew = new List<int>.from(A);
    Anew.removeAt(0);
    
    var factorsNew = new List<int>.from(factors);
    factorsNew.addAll(primeFactors(a2));    
    
    var cost = (a2-a) + computeSolution(N, K, Anew, factorsNew);
    if ((!found) || (cost<best))
    {
      found=true;
      best=cost;
    }
  
  }
  
  return best;
}




