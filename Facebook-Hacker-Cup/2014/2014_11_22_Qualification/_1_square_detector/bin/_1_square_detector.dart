import 'dart:io';


void main() {
  
  var inputFileName = "square_detector.txt";
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

    var N = int.parse(inputLines.current);
    inputLines.moveNext();
    
    print('N=$N');
    var grid = new List<String>();
    for (var row=0;row<N;row++) {
       grid.add(inputLines.current);
       inputLines.moveNext();
    }
    
    var solution = computeSolution(grid);
    var output = 'Case $i: $solution\n';
    print (output);
    outputFile.writeAsStringSync(output, mode: FileMode.APPEND);
    
  };

}


String computeSolution(List<String> grid)
{
  var N = grid.length;
  
  // find top left corner
  var topLeftX = -1;
  var topLeftY = -1;
  var topRightX = -1;
  
  for (int y=0;y<N;y++) {
    for (int x=0;x<N;x++) {
      var isBlack = grid[y][x] == '#';
      
      if (topLeftX == -1) {
        if (isBlack) {
          topLeftX = x;
          topLeftY = y;
        }
      }
      else
      {
        if (topRightX == -1) {
          if (!isBlack) {
            topRightX = x-1;
          }
          else if (x == (N-1)) {
            topRightX = x;
          }
        }
        else
        {
          // validating
          var squareSize = topRightX - topLeftX + 1;
          var expected = x>=topLeftX && x<=topRightX
              && y>=topLeftY && y<=topLeftY+squareSize-1;
          if (isBlack != expected) {
            return "NO";
          }  
        }
      }
    }
    
  }
  
  
  
  return "YES";
  
}



