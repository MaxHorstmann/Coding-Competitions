using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace standing
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var input = File.OpenText("B-small-attempt5.in"))
            {
                using (var output = File.CreateText("output.txt"))
                {
                    var T = int.Parse(input.ReadLine());
                    Console.WriteLine("T = {0}", T);

                    for (var t = 1; t <= T; t++)
                    {
                        input.ReadLine();
                        var pancakes = input.ReadLine().Split(' ').Select(m => int.Parse(m)).ToList();
                        var answer = Solve(pancakes);
                        var outputStr = string.Format("Case #{0}: {1}", t, answer);
                        Console.WriteLine(outputStr);
                        output.WriteLine(outputStr);
                    }
                }
            }
            Console.WriteLine("Done");
        }

        static int Solve(List<int> pancakes)
        {
            //var str = pancakes.Select(m => m.ToString()).ToArray();
            //Console.WriteLine(string.Join(",", str));

            pancakes = pancakes.Where(m => m > 0).ToList();
            if (pancakes.Count == 0) return 0;

            var reduced = pancakes.Select(m => m - 1).ToList();
            
            var chopped = pancakes.OrderByDescending(m => m).ToList();
            var largest = chopped[0];

            var left = largest/2;
            var right = largest - left;
            if (left > 0 && right > 0)
            {
                chopped.RemoveAt(0);
                chopped.Add(left);
                chopped.Add(right);
                chopped = chopped.OrderByDescending(m => m).ToList();

                var reducedSolved = Solve(reduced);
                var choppedSolved = Solve(chopped);
                if (reducedSolved < choppedSolved)
                {
                    return 1 + reducedSolved;
                }
                else
                {
                    return 1 + choppedSolved;
                }
            }
            return 1 + Solve(reduced);

        }

        
    }
}
