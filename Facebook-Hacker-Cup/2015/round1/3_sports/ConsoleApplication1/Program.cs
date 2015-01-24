using System;
using System.Collections.Generic;
using System.Data.Odbc;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.IO;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            const string inputFile = "winning_at_sports.txt";

            using (var streamReader = File.OpenText(inputFile))
            {
                using (var streamWriter = File.CreateText("output.txt"))
                {
                    var T = int.Parse(streamReader.ReadLine());

                    for (var t = 1; t <= T; t++)
                    {
                        var scores = streamReader.ReadLine().Split('-');
                        var my = int.Parse(scores[0]);
                        var their = int.Parse(scores[1]);

                        var solution = GetSolution(my, their);
                        var output = string.Format("Case #{0}: {1}", t, solution);
                        Console.WriteLine(output);
                        streamWriter.WriteLine(output);
                    }

                    streamWriter.Close();
                }
                streamReader.Close();
            }
        }

        static string GetSolution(int my, int their)
        {

            var stressfree = GetStressfree(my, their);
            var stressful = GetStressful(my, their);

            return string.Format("{0} {1}", stressfree, stressful);

        }

        static Dictionary<string,int> stressFreeCache = new Dictionary<string, int>(); 
        static int GetStressfree(int my, int their)
        {
            if ((my == 0) && (their == 0)) return 1;
            if (their >= my) return 0;

            var key = string.Format("{0}-{1}", my, their);
            if (stressFreeCache.ContainsKey(key))
                return stressFreeCache[key];

            var path1 = my == 0 ? 0 : GetStressfree(my - 1, their);
            var path2 = their == 0 ? 0 : GetStressfree(my, their -1);

            var total = (path1 + path2) % 1000000007;
            stressFreeCache[key] = total;
            return total;
        }

        static Dictionary<string, int> stressfulCache = new Dictionary<string, int>();
        static int GetStressful(int my, int their)
        {
            if ((my == 0) && (their == 0)) return 1;

            var key = string.Format("{0}-{1}", my, their);
            if (stressfulCache.ContainsKey(key))
                return stressfulCache[key];


            if (my >= their)
                return GetStressful(my - 1, their);

            var path1 = my == 0 ? 0 : GetStressful(my - 1, their);
            var path2 = their == 0 ? 0 : GetStressful(my, their - 1);

            var total = (path1 + path2) % 1000000007;
            stressfulCache[key] = total;
            return total;

        }


     

    }
}
