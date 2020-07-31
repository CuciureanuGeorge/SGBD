using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Data.SqlClient;


namespace Prima2
{
        class Program
        {
            static void Main2()
            {
                SqlConnection sqlConnection = new SqlConnection("Data Source=localhost;Initial Catalog=Prima;Integrated Security=True");

                sqlConnection.Open();
                SqlCommand sqlCommand = new SqlCommand("EXEC D1", sqlConnection);
                try
                {
                    sqlCommand.ExecuteReader();
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 1205)
                    {
                        Console.WriteLine("A deadlock occured.");
                        for (int i = 0; i <= 10; i++)
                        {
                            Thread.Sleep(1000);
                            Console.WriteLine("Retrying in " + (10 - i) + " seconds...");
                        }
                        sqlCommand.ExecuteNonQuery();
                        Console.WriteLine("Procedure D1 was reexecuted with success.");
                    }
                }
                sqlConnection.Close();
            }

            static void Main(string[] args)
            {
                ThreadStart childref = new ThreadStart(Main2);
                Thread childThread = new Thread(childref);
                childThread.Start();

                SqlConnection sqlConnection = new SqlConnection("Data Source=localhost;Initial Catalog=Prima;Integrated Security=True");
                sqlConnection.Open();
            SqlCommand sqlCommand = new SqlCommand("EXEC D2", sqlConnection);
                try
                {
                    sqlCommand.ExecuteReader();
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 1205)
                    {
                        Console.WriteLine("A deadlock occured.");
                        for (int i = 0; i <= 10; i++)
                        {
                            Thread.Sleep(1000);
                            Console.WriteLine("Retrying in " + (10 - i) + " seconds...");
                        }
                        sqlCommand.ExecuteNonQuery();
                        Console.WriteLine("Procedure D2 was reexecuted with success.");
                    }
                }
                sqlConnection.Close();
                Console.WriteLine("All procedures completed successfully. Press any key to exit...");
                Console.ReadKey();
            }
        }
    
}
