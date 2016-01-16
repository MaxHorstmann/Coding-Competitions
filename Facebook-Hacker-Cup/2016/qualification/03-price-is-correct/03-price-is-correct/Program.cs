using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace _03_price_is_correct
{
    class Program
    {
        static void Main(string[] args)
        {
            const string inputFile = "the_price_is_correct.txt";
            const string outputFile = "output.txt";

            using (StreamReader streamReader = File.OpenText(inputFile))
            {
                using (StreamWriter streamWriter = File.CreateText(outputFile))
                {
                    var T = int.Parse(streamReader.ReadLine());

                    for (var t = 1; t <= T; t++)
                    {
                        var NP = streamReader.ReadLine().Split(' ').Select(long.Parse).ToArray();
                        var N = NP[0];
                        var P = NP[1];
                        var B = streamReader.ReadLine().Split(' ').Select(long.Parse).ToArray();
                        var solution = ComputeSolution(N, P, B);
                        var output = string.Format("Case #{0}: {1}", t, solution);
                        Console.WriteLine(output);
                        streamWriter.WriteLine(output);
                        
                    }
                    streamWriter.Close();
                }
                streamReader.Close();
            }

        }

        static long ComputeSolution(long N, long P, long[] B)
        {
            if (N != B.Length) return -1; // invalid

            long count = 0;
            for (var left = 0; left < N; left++)
            {
                long sum = 0;
                for (var right = left; right < N; right ++)
                {
                    sum += B[right];
                    if (sum > P) break;
                    count++;
                }
           }
           return count;
        }

    }
}
