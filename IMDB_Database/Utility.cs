using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMDB_Database {
    public static class Utility {
        public static void Deconstruct<K, V>(this KeyValuePair<K, V> kv, out K k, out V v) {
            k = kv.Key;
            v = kv.Value;
        }
    }
}
