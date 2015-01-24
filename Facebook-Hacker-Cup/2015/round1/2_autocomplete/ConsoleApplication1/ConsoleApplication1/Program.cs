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
            const string inputFile = "autocomplete.txt";

            using (var streamReader = File.OpenText(inputFile))
            {
                using (var streamWriter = File.CreateText("output.txt"))
                {
                    var T = int.Parse(streamReader.ReadLine());

                    for (var t = 1; t <= T; t++)
                    {
                        var N = int.Parse(streamReader.ReadLine());
                        var words = new string[N];
                        for (var n = 0; n < N; n++)
                        {
                            words[n] = streamReader.ReadLine();
                        }
                        var wc = GetWordCount(words);
                        var output = string.Format("Case #{0}: {1}", t, wc);
                        Console.WriteLine(output);
                        streamWriter.WriteLine(output);
                    }

                    streamWriter.Close();
                }
                streamReader.Close();
            }
        }

        static int GetWordCount(string[] words)
        {
            var hs = new HashSet<string>();
            var count = 0;

            foreach (var word in words)
            {
                var foundUnique = false;
                for (var i = 1; i <= word.Length; i++)
                {
                    var prefix = word.Substring(0, i);
                    if (!foundUnique)
                    {
                        if (hs.Contains(prefix))
                        {
                            continue;
                        }
                        foundUnique = true;
                        count += i;
                    }
                    hs.Add(prefix);
                }
                if (!foundUnique)
                    count += word.Length;
            }

            hs = null;

            return count;
        }

     

    }
}
