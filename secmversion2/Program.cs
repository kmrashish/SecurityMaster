using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Collections;


using System.Data;namespace secmversion2
{
    class Program
    {
        char delimiter = '|';
        static void Main(string[] args)
        {

            //string ConnectionString = "";
            //SqlConnection connection = new SqlConnection(ConnectionString);
            //connection.Open();
            //string data = string.Empty;
            //// string data = "Col1 || Col2"+"\n";

            //string query = @"select * from ashish;";
            //SqlCommand cmd = new SqlCommand(query, connection);

            //SqlDataReader reader;
            //reader = cmd.ExecuteReader();
            //int i = 1;
            //while (reader.Read())
            //{
            //    if (i == 1) data += reader.GetName(0) + "   " + reader.GetName(1) + "\n";
            //    data += " " + reader[0] + "    " + reader[1] + "\n";
            //    i++;

            //}

            //DataTable dt = new DataTable();
            //dt.Load(reader);

            //writing a .csv parser and inserting data into the tables

            Hashtable equityHashTable = new Hashtable();
            equityHashTable.Add("Security Name", "security_name");
            equityHashTable.Add("Security Description", "security_description");
            equityHashTable.Add("Has Position", "has_position");
            equityHashTable.Add("Is Active Security", "is_active");
            equityHashTable.Add("Lot Size", "round_lot_size");
            equityHashTable.Add("BBG Unique Name", "bloomberg_unique_name");
            equityHashTable.Add("CUSIP", "cusip");
            equityHashTable.Add("ISIN", "isin");
            equityHashTable.Add("SEDOL", "sedol");
            equityHashTable.Add("Bloomberg Ticker", "bloomberg_ticker");
            equityHashTable.Add("Bloomberg Unique ID", "bloomberg_unique_id");
            equityHashTable.Add("BBG Global ID", "bloomberg_global_id");
            equityHashTable.Add("Ticker and Exchange", "bloombert_ticker_and_exchange");
            equityHashTable.Add("Is ADR Flag", "is_adr");
            equityHashTable.Add("ADR Underlying Ticker", "adr_underlying_ticker");
            equityHashTable.Add("ADR Underlying Currency", "adr_underlying_currency");
            equityHashTable.Add("Shares Per ADR","shares_per_adr");
            equityHashTable.Add("IPO Date","ipo_date");
            equityHashTable.Add("Pricing Currency","price_currency");
            equityHashTable.Add("Settle Days","settle_days");
            equityHashTable.Add("Total Shares Outstanding","shares_outstanding");
            equityHashTable.Add("Voting Rights Per Share","voting_rights_per_share");
            equityHashTable.Add("Average Volume - 20D","twenty_day_average_volume");
            equityHashTable.Add("Beta","beta");
            equityHashTable.Add("Short Interest","short_interest");
            equityHashTable.Add("Return - YTD","ytd_return");
            equityHashTable.Add("Volatility - 90D","ninty_day_price_volatility");
            equityHashTable.Add("PF Asset Class","form_pf_asset_class");
            equityHashTable.Add("PF Country","form_pf_country");
            equityHashTable.Add("PF Credit Rating","form_pf_credit_rating");
            equityHashTable.Add("PF Currency","form_pf_currency");
            equityHashTable.Add("PF Instrument","form_pf_instrument");
            equityHashTable.Add("PF Liquidity Profile","form_pf_liquid_profile");
            equityHashTable.Add("PF Maturity","form_pf_maturity");
            equityHashTable.Add("PF NAICS Code","form_pf_naics_code");
            equityHashTable.Add("PF Region","form_pf_region");
            equityHashTable.Add("PF Sector","form_pf_sector");
            equityHashTable.Add("PF Sub Asset Class","form_pf_sub_asset_class");
            equityHashTable.Add("Country of Issuance","issue_country");
            equityHashTable.Add("Exchange","exchange");
            equityHashTable.Add("Issuer","issuer");
            equityHashTable.Add("Issue Currency","issue_currency");
            equityHashTable.Add("Trading Currency","trading_currency");
            equityHashTable.Add("BBG Industry Sub Group","bloomberg_industry_sub_group");            
            equityHashTable.Add("Bloomberg Industry Group","bloomberg_industry_group");
            equityHashTable.Add("Bloomberg Sector","bloomberg_industry_sector");
            equityHashTable.Add("Country of Incorporation","country_of_incorporation");
            equityHashTable.Add("Risk Currency","risk_currency");
            equityHashTable.Add("Open Price","open_price");
            equityHashTable.Add("Close Price","close_price");
            equityHashTable.Add("Volume","volume");
            equityHashTable.Add("Last Price","last_price");
            equityHashTable.Add("Ask Price","ask_price");
            equityHashTable.Add("Bid Price","bid_price");
            equityHashTable.Add("PE Ratio","pe_ratio");
            equityHashTable.Add("Dividend Declared Date","declared_date");
            equityHashTable.Add("Dividend Ex Date","ex_date");
            equityHashTable.Add("Dividend Record Date","record_date");
            equityHashTable.Add("Dividend Pay Date","pay_date");
            equityHashTable.Add("Dividend Amount","amount");
            equityHashTable.Add("Frequency","frequency");
            equityHashTable.Add("Dividend Type","dividend_type");

            //Hashtable bondHashTable = new Hashtable();
            //bondHashTable.Add();
            //similarily form the hashtable for the mapping of the bond file field names and the column names in the database tables
            //form the insertion queries for the bond type in the same manner or call the stored procedures as per required

            

            string[] allData = System.IO.File.ReadAllLines(@"E:\Indus Valley Partners\SecurityMaster\Data for securities.csv");
            string attributeHeadersUnseperated = allData[0];
            string[] attributeHeadersSeperated = attributeHeadersUnseperated.Split(',');

            string queryHeadersPart = string.Empty;

            foreach (string s in attributeHeadersSeperated)
            {
                Console.Write(s);
                if(s!=string.Empty)queryHeadersPart += equityHashTable[s]+",";

            }
            queryHeadersPart.TrimStart(',');
            queryHeadersPart.TrimEnd(',');

            Console.WriteLine("\n");
            Console.WriteLine(queryHeadersPart);
            Console.WriteLine();


            string queryValues = string.Empty;
            string dataRowUnseperated = allData[1];

            string[] dataRowSeperated = dataRowUnseperated.Split(',');

            foreach (string dr in dataRowSeperated)
            {
                Console.Write(dr);                
                if(dr!=string.Empty)queryValues += dr + ",";
                //Console.WriteLine("\n");
            } queryValues.TrimEnd(',');

            Console.Write(queryValues);

            // after fetching the values for each data row, do the insertion for that row
            string query="insert into table_name ("+queryHeadersPart+") values ("+queryValues+")";

            Console.WriteLine();
            Console.WriteLine();
            Console.WriteLine(query);

            //Console.Write(attributeHeadersSeperated[1]);
            Console.Read();           
           
        }
    }
}
