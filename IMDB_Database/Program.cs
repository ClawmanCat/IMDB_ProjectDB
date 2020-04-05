using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMDB_Database {
    public class IMDB_Database {
        public const string QUERY_OUTPUT_FOLDER = "./QueryResults/";
        private static Dictionary<string, string> args = new Dictionary<string, string>();

        public static void Main(string[] args) {
            foreach (string arg in args) {
                var kv = arg.Split('=');
                IMDB_Database.args.Add(kv[0], kv.Length > 1 ? kv[1] : "");
            }


            // Run scripts provided by console args.
            if (HasArgument("sql") && HasArgument("connstr")) {
                SqlConnection connection = DBUtils.GetConnection(GetArgument("connstr"));

                foreach (string s in GetArgument("sql").Split(',')) {
                    var result = DBUtils.RunSQLFile(connection, s);

                    var outfile = Path.GetFileNameWithoutExtension(s) + ".txt";  
                    var outstream = HasArgument("outdir")
                        ? StringUtils.FileStream(
                            Path.IsPathRooted(GetArgument("outdir")) 
                                ? Path.Combine(GetArgument("outdir"), outfile) 
                                : Path.Combine(QUERY_OUTPUT_FOLDER, GetArgument("outdir"), outfile))
                        : StringUtils.ConsoleStream;

                    DBUtils.PrintResults(result, outstream);
                }
            }

        }


        public static bool HasArgument(string arg) {
            return args.ContainsKey(arg);
        }

        public static string GetArgument(string arg, string default_value = "") {
            return HasArgument(arg) ? args[arg] : default_value;
        }
    }
}
