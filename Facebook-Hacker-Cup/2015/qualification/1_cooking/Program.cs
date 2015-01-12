using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            const string inputFile = "cooking_the_books.txt";

            using (var streamReader = File.OpenText(inputFile))
            {
                var T = int.Parse(streamReader.ReadLine());
                
                for (var t = 1; t <= T; t++)
                {
                    var N = int.Parse(streamReader.ReadLine());
                    var min = FindMin(N);
                    var max = FindMax(N);
                    var output = string.Format("Case #{0}: {1} {2}", t, min, max);
                    Console.WriteLine(output);
                }

                streamReader.Close();
            }
        }

        static int FindMax(int N)
        {
            if (N == 0) return 0;

            var dA = N.ToString().ToCharArray().Select(m => int.Parse(m.ToString())).ToArray();
            var highestDigit = dA.Max();

            for (var i = dA.Length-1; i > 0; i--)
            {
                var d = dA[i];
                if (d == highestDigit)
                {
                    dA[i] = dA[0];
                    dA[0] = d;
                    var ca = dA.Select(m => m.ToString().ToCharArray()[0]).ToArray();
                    return int.Parse(new string(ca));
                }
            }

            return N;
        }

        static int FindMin(int N)
        {
            if (N == 0) return 0;

            var dA = N.ToString().ToCharArray().Select(m => int.Parse(m.ToString())).ToArray();
            var lowestDigit = dA.Where(m => m!=0).Min();

            for (var i = dA.Length - 1; i > 0; i--)
            {
                var d = dA[i];
                if (d == lowestDigit)
                {
                    dA[i] = dA[0];
                    dA[0] = d;
                    var ca = dA.Select(m => m.ToString().ToCharArray()[0]).ToArray();
                    return int.Parse(new string(ca));
                }
            }

            return N;
        }


    }
}
