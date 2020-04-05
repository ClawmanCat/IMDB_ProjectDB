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
            return (data) => { File.WriteAllText(path, data); };
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
    }
}
