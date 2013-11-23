import 'dart:io';
import "dart:collection";

void main() {
  
  var inputFileName = "tennison.txt";
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

    var inputs = inputLines.current.split(' ');
    inputLines.moveNext();
    var K = int.parse(inputs[0]);
    var ps = double.parse(inputs[1]);
    var pr = double.parse(inputs[2]);
    var pi = double.parse(inputs[3]);
    var pu = double.parse(inputs[4]);
    var pw = double.parse(inputs[5]);
    var pd = double.parse(inputs[6]);
    var pl = double.parse(inputs[7]);

    var simulator = new Simulator(K,ps,pr,pu,pw,pd,pl);
    
    var startTime = new DateTime.now();
    var solution = simulator.computeSolution(pi);
    var endTime = new DateTime.now();
    
    var output = 'Case $i: '+ solution.toStringAsFixed(6) +'\n';
    print (endTime.difference(startTime));
    print (output);
    outputFile.writeAsStringSync(output, mode: FileMode.APPEND);
    
  };

}

class Simulator
{

  int K;
  double ps;
  double pr;
  double pu;
  double pw;
  double pd;
  double pl;
  
  HashMap <String, double> cache = new HashMap<String, double>();  
  
  Simulator(this.K, this.ps, this.pr, this.pu, this.pw, this.pd, this.pl);
  
  
  double computeSolution(double pi, [ int wins=0, int losses=0 ])
  {
    if (wins>=K) return 1.0;
    if (losses>=K) return 0.0;
    
    if (pi<0) pi=0.0;
    if (pi>1) pi=1.0;
    
    var key = "$wins-$losses-" + pi.toStringAsFixed(7); // It is guaranteed that the output is unaffected by deviations as large as 10^-8.
    
    if (cache[key] != null)
    {
      return cache[key];
    }
    
    var p = 
        pi*( 
            ps*   pw            *computeSolution(pi+pu,wins+1,losses)
            +  ps*(1-pw)        *computeSolution(pi,wins+1,losses)
            +  (1-ps)*pl        *computeSolution(pi-pd,wins,losses+1)
            +  (1-ps)*(1-pl)    *computeSolution(pi,wins,losses+1))
            
            + (1-pi)*(
                pr*pw           *computeSolution(pi+pu,wins+1,losses)
                +  pr*(1-pw)    *computeSolution(pi,wins+1,losses)
                +  (1-pr)*pl    *computeSolution(pi-pd,wins,losses+1)
                +  (1-pr)*(1-pl)*computeSolution(pi,wins,losses+1)
            );
    
    cache[key]=p;
    
    return p;
  }
}



















