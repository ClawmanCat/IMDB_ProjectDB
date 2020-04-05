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
            args = args.Append(@"--connstr=""np:\\.\pipe\LOCALDB#B4BF025E\tsql\query""").ToArray();
            args = args.Append(@"--sql=setup_db.sql").ToArray();
            args = args.Append(@"--outmode=file").ToArray();


            foreach (string arg in args) {
                var kv = arg.Split('=');
                IMDB_Database.args.Add(kv[0].Dedash(), kv.Length > 1 ? kv[1].Dequote() : "");
            }


            // Run scripts provided by console args.
            if (HasArgument("sql") && HasArgument("connstr")) {
                SqlConnection connection = DBUtils.GetConnection(GetArgument("connstr"));

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
