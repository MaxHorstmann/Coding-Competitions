using System;
using System.CodeDom;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace ConsoleApplication1
{
    class Program
    {
        private static SortedSet<int> primes = new SortedSet<int>();
        private static Dictionary<int, int> primacities = new Dictionary<int, int>();

        static void Main(string[] args)
        {
            const string inputFile = "input.txt";

            // populate primes
            for (var i = 2; i < 3163; i++) // sqrt(10MM) sufficient
            {
                var isPrime = true;
                foreach (var p in primes)
                {
                    if ((i%p) == 0)
                    {
                        isPrime = false;
                        break;
                    }
                }
                if (isPrime) primes.Add(i);
            }

            // pre-compute primacities
            for (var i = 2; i <= 10000000; i++)
            {
                primacities[i] = GetPrimacity(i);
                if ((i % 1000000) == 0) Console.WriteLine(i);
            }

            Console.WriteLine("ok, now download input...");
            Console.ReadKey();

            using (var streamReader = File.OpenText(inputFile))
            {
                using (var streamWriter = File.CreateText("output.txt"))
                {
                    var T = int.Parse(streamReader.ReadLine());

                    for (var t = 1; t <= T; t++)
                    {
                        var ABK = streamReader.ReadLine().Split(' ');
                        var A = int.Parse(ABK[0]);
                        var B = int.Parse(ABK[1]);
                        var K = int.Parse(ABK[2]);

                        var solution = GetSolution(A, B, K);
                        var output = string.Format("Case #{0}: {1}", t, solution);
                        Console.WriteLine(output);
                        streamWriter.WriteLine(output);
                    }

                    streamWriter.Close();
                }
                streamReader.Close();
            }
        }

        static int GetSolution(int A, int B, int K)
        {
            var count = 0;
            for (var i = A; i <= B; i++)
            {
                count += HasPrimacity(i, K) ? 1 : 0;
            }
            return count;
        }

        static bool HasPrimacity(int N, int K)
        {
            if (K >= N) return false;
            return primacities[N] == K;
        }

        static int GetPrimacity(int N)
        {
            if (primes.Contains(N))
                return 1;

            foreach (var p in primes)
            {
                if ((N%p) == 0)
                {
                    while ((N%p) == 0)
                    {
                        N = N/p;
                    }
                    return 1 + GetPrimacity(N);
                }
            }
            
            return 0; // won't happen


        }
     

    }
}
