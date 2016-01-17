using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace _1_competition

{
    class Program
    {
        static void Main(string[] args)
        {
            const string inputFile = "coding_contest_creation.txt";
            const string outputFile = "output.txt";

            using (StreamReader streamReader = File.OpenText(inputFile))
            {
                using (StreamWriter streamWriter = File.CreateText(outputFile))
                {
                    var T = int.Parse(streamReader.ReadLine());

                    for (var t = 1; t <= T; t++)
                    {
                        var N = int.Parse(streamReader.ReadLine());
                        var D = streamReader.ReadLine().Split(' ').Select(int.Parse).ToArray();
                        var solution = ComputeSolution(D);
                        var output = string.Format("Case #{0}: {1}", t, solution);
                        Console.WriteLine(output);
                        streamWriter.WriteLine(output);

                    }
                    streamWriter.Close();
                }
                streamReader.Close();
            }

        }

        static int ComputeSolution(int[] D)
        {
            if (D.Length == 0) return 0;
            if (D.Length == 1) return 3;
            
            // split if not strictly increasing or gap > 30

            for (var i = 1; i < D.Length; i++)
            {
                if ((D[i - 1] >= D[i]) || (D[i] - D[i-1] > 30))
                {
                    var left = ComputeSolution(D.Take(i).ToArray());
                    var right = ComputeSolution(D.Skip(i).ToArray());
                    return left + right;
                }
            }

            
            var gaps = 0;
            for (var i = 1; i < D.Length; i++)
            {
                gaps += (D[i] - D[i - 1] - 1)/10;
            }

            var mod = (D.Length + gaps)%4;
            if (mod == 0) return gaps;
            return gaps + 4 - mod;
        }

    }
}
