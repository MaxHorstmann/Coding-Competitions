using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace _01_boomerang
{
    class Program
    {
        static void Main(string[] args)
        {
            const string inputFile = "boomerang_constellations.txt";
            const string outputFile = "output.txt";

            using (StreamReader streamReader = File.OpenText(inputFile))
            {
                using (StreamWriter streamWriter = File.CreateText(outputFile))
                {
                    var T = int.Parse(streamReader.ReadLine());

                    for (var t = 1; t <= T; t++)
                    {
                        var N = int.Parse(streamReader.ReadLine());
                        var X = new int[N];
                        var Y = new int[N];
                        for (var i = 0; i < N; i++)
                        {
                            var XY = streamReader.ReadLine().Split(' ').Select(int.Parse).ToArray();
                            X[i] = XY[0];
                            Y[i] = XY[1];
                        }

                        var solution = ComputeSolution(N, X, Y);
                        var output = string.Format("Case #{0}: {1}", t, solution);
                        Console.WriteLine(output);
                        streamWriter.WriteLine(output);

                    }
                    streamWriter.Close();
                }
                streamReader.Close();
            }

        }

        static long ComputeSolution(int N, int[] X, int[] Y)
        {
            long count = 0;
            var cache = new Dictionary<string, int>();
            for (var i = 0; i < N-1; i++)
            {
                for (var j = i+1; j < N; j++)
                {
                    var sqDistance = (Y[j] - Y[i])*(Y[j] - Y[i]) + (X[j] - X[i])*(X[j] - X[i]);
                    var key1 = string.Format("{0}--{1}--{2}", sqDistance, X[i], Y[i]);
                    if (cache.ContainsKey(key1))
                    {
                        count += cache[key1];
                        cache[key1]++;
                    }
                    else
                        cache[key1] = 1;

                    var key2 = string.Format("{0}--{1}--{2}", sqDistance, X[j], Y[j]);
                    if (cache.ContainsKey(key2))
                    {
                        count += cache[key2];
                        cache[key2]++;
                    }
                    else
                        cache[key2] = 1;

                }
            }
            return count;
        }

    }
}
