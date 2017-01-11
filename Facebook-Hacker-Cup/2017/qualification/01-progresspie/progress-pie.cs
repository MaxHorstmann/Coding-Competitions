using System;
using System.IO;

namespace _01_progresspie
{
    class ProgressPie
    {
        static void Main(string[] args)
        {
            const string inputFile = "input.txt";
            const string outputFile = "output.txt";

            using (StreamReader streamReader = File.OpenText(inputFile))
            {
                using (StreamWriter streamWriter = File.CreateText(outputFile))
                {
                    var T = int.Parse(streamReader.ReadLine());

                    for (var t = 1; t <= T; t++)
                    {
                        var split = streamReader.ReadLine().Split(' ');
                        var p = int.Parse(split[0]);
                        var x = int.Parse(split[1]);
                        var y = int.Parse(split[2]);
                        var solution = IsBlack(p, x, y) ? "black" : "white";
                        var output = string.Format("Case #{0}: {1}", t, solution);
                        Console.WriteLine(output);
                        streamWriter.WriteLine(output);
                    }
                    streamWriter.Close();
                }
                streamReader.Close();
            }
        }

        static bool IsBlack(int p, int x, int y)
        {
            if (p == 0) return false;
            if ((x==50) && (y==50)) return true;

            var distance = Math.Sqrt(Math.Pow(x-50, 2) + Math.Pow(y-50, 2));
            if (distance > 50) return false;

            return p >= GetProgress(x,y);
        }

        static double GetProgress(int x, int y)
        {
            var phi = Math.Acos(((y - 50) * 50) 
                / (Math.Sqrt(Math.Pow((x - 50), 2) + Math.Pow((y - 50), 2)) * 50));
            if (x < 50) phi = (2 * Math.PI) - phi;
            return 100 * phi / (2 * Math.PI);
        }
    }
}
