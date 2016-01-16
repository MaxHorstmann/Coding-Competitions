using System;
using System.IO;
using System.Linq;

namespace standing
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var input = File.OpenText("A-large.in"))
            {
                using (var output = File.CreateText("output.txt"))
                {
                    var T = int.Parse(input.ReadLine());
                    Console.WriteLine("T = {0}", T);

                    for (var t = 1; t <= T; t++)
                    {
                        var nums = input.ReadLine().Split(' ');
                        var counts = nums[1].ToCharArray().Select(m => int.Parse(m.ToString())).ToArray();
                        var answer = Solve(counts);
                        var outputStr = string.Format("Case #{0}: {1}", t, answer);
                        Console.WriteLine(outputStr);
                        output.WriteLine(outputStr);
                    }
                }
            }
            Console.WriteLine("Done");
        }

        static int Solve(int[] counts)
        {
            var friends = 0;
            var audience = 0;
            for (var i = 0; i < counts.Length; i++)
            {
                var missingFriends = i - audience;
                if (missingFriends > 0)
                {
                    friends += missingFriends;
                    audience += missingFriends;
                }
                audience += counts[i];
            }
            return friends;
        }


    }
}
