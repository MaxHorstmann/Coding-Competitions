import 'dart:io';

class Player extends Comparable
{
  String name;
  int shot_percentage;
  int height;
  int totalTimePlayed;
  bool isPlaying = false;
  
  int compareTo(Player p)
  {
    return shot_percentage != p.shot_percentage ?
        p.shot_percentage.compareTo(shot_percentage)
        : p.height.compareTo(height);
  }
  
}


void main() {
  
  var inputFileName = "basketball_game.txt";
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

    var NMP = inputLines.current.split(' ');
    inputLines.moveNext();
    var N = int.parse(NMP[0]);
    var M = int.parse(NMP[1]);
    var P = int.parse(NMP[2]);
    
    print('N=$N, M=$M, P=$P');
    
    var players = new List<Player>();
    
    for (var n=0;n<N;n++) {
      var playerLineElements = inputLines.current.split(' ');
      inputLines.moveNext();
      var player = new Player()
        ..name = playerLineElements[0]
        ..shot_percentage = int.parse(playerLineElements[1])
        ..height = int.parse(playerLineElements[2])
        ..totalTimePlayed = 0
        ..isPlaying = false;
      players.add(player);
    }
    
    var solution = computeSolution(players, M, P);
    var output = 'Case $i: $solution\n';
    print (output);
    outputFile.writeAsStringSync(output, mode: FileMode.APPEND);
    
  };

}


String computeSolution(List<Player> players, int M, int P)
{  
  players.sort();
  
  var teams = new List<List<Player>>();
  teams.add(new List<Player>());
  teams.add(new List<Player>());
  var nextPick = 0;
  
  players.forEach((Player p) {
    teams[nextPick].add(p);
    nextPick = 1-nextPick;
  });
  
  // play game
  teams.forEach((List<Player> team) {
    for (int i=0; i<P;i++) {
      team[i].isPlaying = true;
    }
  });
  
  for (int m=0;m<M;m++) {
    teams.forEach((List<Player> team) {
      if (team.length > P) {
        // find player on field with highest number of minutes played 
        // Tie breaker: highest draft number leaves
        Player playerIn = null;
        Player playerOut = null;
        team.forEach((Player p) {
          if (p.isPlaying) {
            p.totalTimePlayed++;
            if ((playerOut == null) || (p.totalTimePlayed >= playerOut.totalTimePlayed)) {
              playerOut = p;
            }
          }
          else
          {
            if ((playerIn == null) || (p.totalTimePlayed < playerIn.totalTimePlayed)) {
              playerIn = p;
            }
          }
        });
        playerIn.isPlaying=true;
        playerOut.isPlaying=false;
      }
    });
  }
  
  
  var finalPlayerNames = new List<String>();
  teams.forEach((List<Player> team) => team.forEach((Player p) {
    if (p.isPlaying) finalPlayerNames.add(p.name);
  }));
  
  finalPlayerNames.sort();
  return finalPlayerNames.join(' ');
  
}



