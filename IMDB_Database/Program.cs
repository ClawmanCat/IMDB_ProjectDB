using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMDB_Database {
    public class IMDB_Database {
        public const string QUERY_OUTPUT_FOLDER = "../../../QueryResults/";
        private static Dictionary<string, string> args = new Dictionary<string, string>();

        public static void Main(string[] args) {
            // Example args, make sure to use your actual connection string.
            args = args.Append(@"--sql=project_question_5a.sql,project_question_5b.sql,project_question_5c.sql").ToArray();
            args = args.Append(@"--outmode=file").ToArray();
            //args = args.Append(@"--direct").ToArray();


            foreach (string arg in args) {
                var kv = arg.Split('=');
                IMDB_Database.args.Add(kv[0].Dedash(), kv.Length > 1 ? kv[1].Dequote() : "");
            }


            if (!HasArgument("connstr")) IMDB_Database.args.Add("connstr", @"(LocalDb)\IMDB_Project");
            SqlConnection connection = DBUtils.GetConnection(GetArgument("connstr"));


            if (HasArgument("direct")) {
                string input;

                Console.WriteLine("Direct mode is enabled. You may now write SQL queries.");
                do {
                    input = Console.ReadLine();

                    var result = DBUtils.RunSQL(connection, input);
                    if (result == null) continue;

                    DBUtils.PrintResults(result, StringUtils.ConsoleStream);
                } while (input.ToLower() != "exit");

            } else if (HasArgument("sql")) {
                foreach (string s in GetArgument("sql").Split(',')) {
                    var result = DBUtils.RunSQLFile(connection, s);
                    if (result == null) continue;

                    var outfile = Path.GetFileNameWithoutExtension(s) + ".txt";
                    var outpath = HasArgument("outdir") 
                        ? Path.IsPathRooted(GetArgument("outdir"))
                            ? GetArgument("outdir") + outfile
                            : "../../../" + GetArgument("outdir") + outfile
                        : QUERY_OUTPUT_FOLDER + outfile;

                    var outstream = (HasArgument("outmode") && GetArgument("outmode") == "file")
                        ? StringUtils.FileStream(outpath)
                        : StringUtils.ConsoleStream;

                    DBUtils.PrintResults(result, outstream);
                }
            }


            Console.WriteLine("Everything done! Press any key to exit...");
            Console.ReadKey();
        }


        public static bool HasArgument(string arg) {
            return args.ContainsKey(arg);
        }

        public static string GetArgument(string arg, string default_value = "") {
            return HasArgument(arg) ? args[arg] : default_value;
        }
    }
}
