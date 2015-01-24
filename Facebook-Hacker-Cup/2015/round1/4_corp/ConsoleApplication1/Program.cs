using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            const int maxStackSize = 1000000000;
            var thread = new Thread(Impl, maxStackSize); // hack, not a good practice
            thread.Start();
            thread.Join();
        }

        static void Impl()
        {

            const string inputFile = "corporate_gifting.txt";

            using (var streamReader = File.OpenText(inputFile))
            {
                using (var streamWriter = File.CreateText("output.txt"))
                {
                    var T = int.Parse(streamReader.ReadLine());

                    for (var t = 1; t <= T; t++)
                    {
                        streamReader.ReadLine();
                        var ids = streamReader.ReadLine().Split(' ').Select(m => int.Parse(m)).ToArray();
                        var solution = GetSolution(ids);
                        var output = string.Format("Case #{0}: {1}", t, solution);
                        Console.WriteLine(output);
                        streamWriter.WriteLine(output);
                    }

                    streamWriter.Close();
                }
                streamReader.Close();
            }
        }

        class Employee
        {
            public int id { get; set; }
            public Employee manager { get; set; }
            public List<Employee> reports { get; set; } 
            public int firstPref { get; set; }
            public int firstPrefResult { get; set; }
            public int secondPrefResult { get; set; }

            public int GetResult(int parentVal)
            {
                return parentVal == firstPref ? secondPrefResult : firstPrefResult;
            }
        }

        static int GetSolution(int[] ids)
        {
            var employees = new Dictionary<int, Employee>();
            for (var i = 0; i < ids.Length; i++)
            {
                var employeeId = i + 1;
                var newEmployee = new Employee()
                {
                    id = employeeId,
                    reports = new List<Employee>()
                };
                employees[employeeId] = newEmployee;
            }

            for (var i=0; i<ids.Length; i++)
            {
                var employeeId = i + 1;
                var managerId = ids[i];
                var manager = managerId == 0 ? null : employees[managerId];
                var newEmployee = employees[employeeId];
                newEmployee.manager = manager;
                if (newEmployee.manager != null)
                    newEmployee.manager.reports.Add(newEmployee);
            }

            var ceo = employees[1];
            Calc(ceo);
            return ceo.firstPrefResult;

        }

        static void Calc(Employee e)
        {
            if (!e.reports.Any())
            {
                e.firstPref = 1;
                e.firstPrefResult = 1;
                e.secondPrefResult = 2;
                return;
            }

            var firstPrefs = new HashSet<int>();
            foreach (var r in e.reports)
            {
                Calc(r);
                firstPrefs.Add(r.firstPref);
            }

            e.firstPrefResult = int.MaxValue;
            e.secondPrefResult = int.MaxValue;

            var candidates = new HashSet<int>();
            for (var c = 1;; c++)
            {
                candidates.Add(c);
                if (!firstPrefs.Contains(c) && candidates.Count>=2)
                {
                    break;
                }
            }

            foreach (var c in candidates)
            {
                var total = e.reports.Sum(m => m.GetResult(c)) + c;
                if (total < e.secondPrefResult)
                {
                    if (total < e.firstPrefResult)
                    {
                        e.secondPrefResult = e.firstPrefResult;
                        e.firstPref = c;
                        e.firstPrefResult = total;
                    }
                    else
                    {
                        e.secondPrefResult = total;
                    }
                }
            }

        }

    }
}
