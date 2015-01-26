using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;



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
                     
            string[] allData = System.IO.File.ReadAllLines(@"C:\Users\ashikumar\Downloads\Data for securities.csv");
            string attributeHeadersUnseperated = allData[0];
            string[] attributeHeadersSeperated = attributeHeadersUnseperated.Split('|');

            foreach (string s in attributeHeadersSeperated)
            {
                Console.Write(s);
            }

            string dataRowUnseperated = allData[1];

            string[] dataRowSeperated = dataRowUnseperated.Split('|');
            foreach (string dr in dataRowSeperated)
            {
                Console.Write(dr);
            }

            Console.Write("\n");

            Console.Write(attributeHeadersSeperated[1]);

            string[] EquityFieldNamesFromFile = {
                                            "Security Name",
                                            "Security Description",
                                            "Has Position",
                                            "Is Active Security",
                                            "Lot Size",
                                            "BBG Unique Name",
                                            "CUSIP",
                                            "ISIN",
                                            "SEDOL",
                                            "Bloomberg Ticker",
                                            "Bloomberg Unique ID",
                                            "BBG Global ID",
                                            "Ticker and Exchange",
                                            "Is ADR Flag",
                                            "ADR Underlying Ticker",
                                            "ADR Underlying Currency",
                                            "Shares Per ADR",
                                            "IPO Date",
                                            "Pricing Currency",
                                            "Settle Days",
                                            "Total Shares Outstanding",
                                            "Voting Rights Per Share",
                                            "Average Volume - 20D",
                                            "Beta",
                                            "Short Interest",
                                            "Return - YTD",
                                            "Volatility - 90D",
                                            "PF Asset Class",
                                            "PF Country",
                                            "PF Credit Rating",
                                            "PF Currency",
                                            "PF Instrument",
                                            "PF Liquidity Profile",
                                            "PF Maturity",
                                            "PF NAICS Code",
                                            "PF Region",
                                            "PF Sector",
                                            "PF Sub Asset Class",
                                            "Country of Issuance",
                                            "Exchange",
                                            "Issuer",
                                            "Issue Currency",
                                            "Trading Currency",
                                            "BBG Industry Sub Group",
                                            "Bloomberg Industry Group",
                                            "Bloomberg Sector",
                                            "Country of Incorporation",
                                            "Risk Currency",
                                            "Open Price",
                                            "Close Price",
                                            "Volume",
                                            "Last Price",
                                            "Ask Price",
                                            "Bid Price",
                                            "PE Ratio",
                                            "Dividend Declared Date",
                                            "Dividend Ex Date",
                                            "Dividend Record Date",
                                            "Dividend Pay Date",
                                            "Dividend Amount",
                                            "Frequency",
                                            "Dividend Type"
                                          };
            string[] ActualEquityDBFieldNames = {
                                             "security_name",
                                            "security_description",
                                            "has_position",
                                            "is_active",
                                            "round_lot_size",
                                            "bloomberg_unique_name",
                                            "cusip",
                                            "isin",
                                            "sedol",
                                            "bloomberg_ticker",
                                            "bloomberg_unique_id",
                                            "bloomberg_global_id",
                                            "bloombert_ticker_and_exchange",
                                            "is_adr",
                                            "adr_underlying_ticker",
                                            "adr_underlying_currency",
                                            "shares_per_adr",
                                            "ipo_date",
                                            "price_currency",
                                            "settle_days",
                                            "shares_outstanding",
                                            "voting_rights_per_share",
                                            "twenty_day_average_volume",
                                            "beta",
                                            "short_interest",
                                            "ytd_return",
                                            "ninty_day_price_volatility",
                                            "form_pf_asset_class",
                                            "form_pf_country",
                                            "form_pf_credit_rating",
                                            "form_pf_currency",
                                            "form_pf_instrument",
                                            "for_pf_liquid_profile",
                                            "form_pf_maturity",
                                            "form_pf_naics_code",
                                            "form_pf_region",
                                            "form_pf_sector",
                                            "form_pf_sub_asset_class",
                                            "issue_country",
                                            "exchange",
                                            "issuer",
                                            "issue_currency",
                                            "trading_currency",
                                            "bloomberg_industry_sub_group",
                                            "bloomberg_industry_group",
                                            "bloomberg_industry_sector",
                                            "country_of_incorporation",
                                            "risk_currency",
                                            "open_price",
                                            "close_price",
                                            "volume",
                                            "last_price",
                                            "ask_price",
                                            "bid_price",
                                            "pe_ratio",
                                            "declared_date",
                                            "ex_date",
                                            "record_date",
                                            "pay_date",
                                            "amount",
                                            "frequency",
                                            "dividend_type"
                                          };

            string[] BondFieldNamesFromFile = {
                                            "Security Description",
                                            "Security Name",
                                            "Asset Type",
                                            "Investment Type",
                                            "Trading Factor",
                                            "Pricing Factor",
                                            "ISIN",
                                            "BBG Ticker",
                                            "BBG Unique ID",
                                            "CUSIP",
                                            "SEDOL",
                                            "First Coupon Date",
                                            "Cap",
                                            "Floor",
                                            "Coupon Frequency",
                                            "Coupon",
                                            "Coupon Type",
                                            "Spread",
                                            "Callable Flag",
                                            "Fix to Float Flag",
                                            "Putable Flag",
                                            "Issue Date",
                                            "Last Reset Date",
                                            "Maturity",
                                            "Call Notification Max Days",
                                            "Put Notification Max Days",
                                            "Penultimate Coupon Date",
                                            "Reset Frequency",
                                            "Has Position",
                                            "Macaulay Duration",
                                            "30D Volatility",
                                            "90D Volatility",
                                            "Convexity",
                                            "30D Average Volume",
                                            "PF Asset Class",
                                            "PF Country",
                                            "PF Credit Rating",
                                            "PF Currency",
                                            "PF Instrument",
                                            "PF Liquidity Profile",
                                            "PF Maturity",
                                            "PF NAICS Code",
                                            "PF Region",
                                            "PF Sector",
                                            "PF Sub Asset Class",
                                            "Bloomberg Industry Group",
                                            "Bloomberg Industry Sub Group",
                                            "Bloomberg Industry Sector",
                                            "Country of Issuance",
                                            "Issue Currency",
                                            "Issuer",
                                            "Issuer",
                                            "Risk Currency",
                                            "Put Date",
                                            "Put Price",
                                            "Ask Price",
                                            "High Price",
                                            "Low Price",
                                            "Open Price",
                                            "Volume",
                                            "Bid Price",
                                            "Last Price",
                                            "Call Date",
                                            "Call Price"
                                          };
            string[] ActualBondDBFieldNames = {
                                             "security_name",
                                            "security_description",
                                            "has_position",
                                            "is_active",
                                            "round_lot_size",
                                            "bloomberg_unique_name",
                                            "cusip",
                                            "isin",
                                            "sedol",
                                            "bloomberg_ticker",
                                            "bloomberg_unique_id",
                                            "bloomberg_global_id",
                                            "bloombert_ticker_and_exchange",
                                            "is_adr",
                                            "adr_underlying_ticker",
                                            "adr_underlying_currency",
                                            "shares_per_adr",
                                            "ipo_date",
                                            "price_currency",
                                            "settle_days",
                                            "shares_outstanding",
                                            "voting_rights_per_share",
                                            "twenty_day_average_volume",
                                            "beta",
                                            "short_interest",
                                            "ytd_return",
                                            "ninty_day_price_volatility",
                                            "form_pf_asset_class",
                                            "form_pf_country",
                                            "form_pf_credit_rating",
                                            "form_pf_currency",
                                            "form_pf_instrument",
                                            "for_pf_liquid_profile",
                                            "form_pf_maturity",
                                            "form_pf_naics_code",
                                            "form_pf_region",
                                            "form_pf_sector",
                                            "form_pf_sub_asset_class",
                                            "issue_country",
                                            "exchange",
                                            "issuer",
                                            "issue_currency",
                                            "trading_currency",
                                            "bloomberg_industry_sub_group",
                                            "bloomberg_industry_group",
                                            "bloomberg_industry_sector",
                                            "country_of_incorporation",
                                            "risk_currency",
                                            "open_price",
                                            "close_price",
                                            "volume",
                                            "last_price",
                                            "ask_price",
                                            "bid_price",
                                            "pe_ratio",
                                            "declared_date",
                                            "ex_date",
                                            "record_date",
                                            "pay_date",
                                            "amount",
                                            "frequency",
                                            "dividend_type"
                                          };
        }
    }
}
