using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMDB_Database {
    public static class StringUtils {
        public delegate void StringStream(string data);

        public static StringStream ConsoleStream = Console.Write;
        public static StringStream FileStream(string path) {
            File.WriteAllText(path, "");    // Clear file
            return (data) => { File.AppendAllText(path, data); };
        }


        public static string PadRightTo(this string str, int amount, char c = ' ') {
            while (str.Length < amount) str += c;
            return str;
        }


        public static string MakeFixedLength(this string str, int length, char extend_with = ' ', string indicate_overflow = "...") {
            if (str.Length > length) {
                str.Substring(0, length - indicate_overflow.Length);
                str += indicate_overflow;
            } else {
                str = PadRightTo(str, length, extend_with);
            }

            return str;
        }


        public static string Dequote(this string str) {
            Func<char, bool> isquot = (char c) => (c == '\'' || c == '"');

            if (isquot(str[0])) str = str.Substring(1, str.Length - 1);
            if (isquot(str[str.Length - 1])) str = str.Substring(0, str.Length - 1);

            return str;
        }


        public static string Dedash(this string str) {
            while (str.Length > 0 && str[0] == '-') str = str.Substring(1);
            return str;
        }
    }
}
