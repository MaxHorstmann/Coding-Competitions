using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace _2_laundromatt

{
    class Program
    {
        static void Main(string[] args)
        {
            const string inputFile = "laundro_matt_example_input.txt";
            const string outputFile = "output.txt";

            using (StreamReader streamReader = File.OpenText(inputFile))
            {
                using (StreamWriter streamWriter = File.CreateText(outputFile))
                {
                    var T = int.Parse(streamReader.ReadLine());

                    for (var t = 1; t <= T; t++)
                    {
                        var LNMD = streamReader.ReadLine().Split(' ').Select(long.Parse).ToArray();
                        var L = LNMD[0];
                        var N = LNMD[1];
                        var M = LNMD[2];
                        var D = LNMD[3];
                        var W = streamReader.ReadLine().Split(' ').Select(long.Parse).ToArray();
                        var solution = ComputeSolution(L, N, M, D, W);
                        var output = string.Format("Case #{0}: {1}", t, solution);
                        Console.WriteLine(output);
                        streamWriter.WriteLine(output);

                    }
                    streamWriter.Close();
                }
                streamReader.Close();
            }

        }

        static long ComputeSolution(long L, long N, long M, long D, long[] W)
        {
            if (N != W.Length) return -1; // invalid

            Array.Sort(W);
            var w_sum = W.Sum();
            var Q = W.Select(w => L - ((L * w)/w_sum)).ToArray();

            Console.WriteLine(Q);


            return 0;
        }

    }
}
