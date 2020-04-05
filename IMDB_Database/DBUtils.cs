using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static IMDB_Database.StringUtils;

namespace IMDB_Database {
    public static class DBUtils {
        public const string SQL_FILE_FOLDER = "./SQL/";


        public static SqlConnection GetConnection(string connstr) {
            return new SqlConnection(connstr);
        }


        public static SqlDataReader RunSQLFile(SqlConnection conn, string file) {
            string sql = File.ReadAllText(Path.IsPathRooted(file) ?  file : Path.Combine(SQL_FILE_FOLDER, file));

            SqlCommand command = new SqlCommand(sql, conn);
            SqlDataReader reader = command.ExecuteReader();

            return reader;
        }


        public static void PrintResults(SqlDataReader reader, StringStream stream) {
            const int COLUMN_WIDTH = 50;

            for (int i = 0; i < reader.FieldCount; ++i) {
                stream(reader.GetName(i).MakeFixedLength(COLUMN_WIDTH) + "\n");
            }

            while (reader.Read()) {
                for (int i = 0; i < reader.FieldCount; ++i) {
                    stream(reader[i].ToString().MakeFixedLength(COLUMN_WIDTH) + "\n");
                }
            }
        }
    }
}
