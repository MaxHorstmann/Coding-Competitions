using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dijkstra
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var input = File.OpenText("input.txt"))
            {
                using (var output = File.CreateText("output.txt"))
                {
                    var T = int.Parse(input.ReadLine());
                    Console.WriteLine("T = {0}", T);

                    for (var t = 1; t <= T; t++)
                    {
                        var X = int.Parse(input.ReadLine().Split(' ')[1]);
                        var str = input.ReadLine();
                        var possible = Solve(str, X);
                        var outputStr = string.Format("Case #{0}: {1}", t, possible ? "YES" : "NO");
                        Console.WriteLine(outputStr);
                        output.WriteLine(outputStr);
                    }
                }
            }
            Console.WriteLine("Done");
        }

        static bool Solve(string str, int X)
        {
            var possible = false;
            
            var baseArray = str.ToCharArray().Select(m =>
            {
                switch (m)
                {
                    case 'i': return i;
                    case 'j': return j;
                    case 'k': return k;
                }
                throw new ArgumentException();
            }).ToArray();

            return Solve_internal(baseArray, X);
        }

        static bool Solve_internal(int[] vals, int X)
        {
            var pos = 0;
            var v = vals[0];
            var find = i;
            while (true)
            {
                pos++;
                if (pos >= vals.Length)
                {
                    pos = 0;
                    X--;
                    if (X == 0) return false;
                }
                v = Multiply(v, vals[pos]);
            }
            return true;


        }

        //static int reduce(int[] vals)
        //{
        //    var asQueue = new Queue<int>(vals);
        //    while (asQueue.Count > 1)
        //    {
        //        var a = asQueue.Dequeue();
        //        var b = asQueue.Dequeue();
        //        var p = Multiply(a, b);
        //        asQueue.Enqueue(p);
        //    }
        //    return asQueue.Dequeue();
        //}

        const int i = 2;
        const int j = 3;
        const int k = 4;

        private static readonly int[,] matrix = 
        {
            { 0, 0, 0, 0, 0 },
            { 0, 1, i, j, k },
            { 0, i, -1, k, -j },
            { 0, j, -k, -1, i },
            { 0, k, j, -i, -1 }
        };

        static int Multiply(int a, int b)
        {
            var sign = Math.Sign(a)*Math.Sign(b);
            a = Math.Abs(a);
            b = Math.Abs(b);
            var p = matrix[a, b];
            sign = sign*Math.Sign(p);
            p = Math.Abs(p);
            return sign*p;
        }
        

    }
}
