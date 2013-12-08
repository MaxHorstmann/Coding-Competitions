import 'dart:io';
import 'dart:collection';

void main() {
  
  var inputFileName = "aaaaaa.txt";
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

   
    var NM = inputLines.current.split(' ');
    var N = int.parse(NM[0]);
    var M = int.parse(NM[1]);
    
    inputLines.moveNext();
    
    print('N=$N');
    print('M=$M');
    
    var grid = new List<String>();
    for (int n=0;n<N;n++) {
      grid.add(inputLines.current);
      inputLines.moveNext();
    }
    
    var solution = computeSolution(N,M,grid) + 1;
    var output = 'Case $i: $solution\n';
    print (output);
    outputFile.writeAsStringSync(output, mode: FileMode.APPEND);
    
  };

}


int computeSolution(int N, int M, List<String> grid, [ int row = 0, int col = 0, String prevStep = 'r', bool joker = true, HashMap<String, int> cache = null ])
{
  
    //print("$row $col $prevStep"); 
  
    var key='$row-$col-$prevStep-$joker';
    if (cache == null)
    {
      cache = new HashMap<String, int>();
    }
    else
    {
      if (cache.containsKey(key))
      {
        return cache[key];
      }
    }
    
  
    var max = 0;
    
    if ((row<N-1) && (grid[row+1][col]!='#') && (prevStep!='u'))
    {
      var newMax = 1 + computeSolution(N,M,grid,row+1,col,'d',joker, cache);
      if (newMax>max) max=newMax;
    }
    
    if ((col<M-1) && (grid[row][col+1]!='#') && (prevStep!='l'))
    {
      var newMax = 1 + computeSolution(N,M,grid,row,col+1,'r',joker, cache);
      if (newMax>max) max=newMax;
    }
    
    if ((joker)||(prevStep=='u'))
    {
      if ((row>0) && (grid[row-1][col]!='#') && (prevStep!='d'))
      {
        var newMax = 1 + computeSolution(N,M,grid,row-1,col,'u',false, cache);
        if (newMax>max) max=newMax;
      }
    }
    
    if ((joker)||(prevStep=='l'))
    {
      if ((col>0) && (grid[row][col-1]!='#') && (prevStep!='r'))
      {
        var newMax = 1 + computeSolution(N,M,grid,row,col-1,'l',false, cache);
        if (newMax>max) max=newMax;
      }
    }
    
    cache[key] = max;
    return max; 
  
  
}



