using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var sw = File.CreateText("input.txt"))
            {
                sw.WriteLine("2");

                sw.WriteLine("1");
                for (var i = 0; i < 200000; i++)
                {
                    if (i > 0) sw.Write(" ");
                    sw.Write("{0}", i);
                }
                sw.WriteLine();

                
                sw.WriteLine("1");
                for (var i = 0; i < 200000; i++)
                {
                    if (i>0) sw.Write(" ");
                    sw.Write("{0}", i == 0 ? i : (i / 5) + 1);
                }
                sw.WriteLine();
                
                sw.Close();
            }
        }
    }
}
