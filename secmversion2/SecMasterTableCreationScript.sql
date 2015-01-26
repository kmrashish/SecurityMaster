IF EXISTS(SELECT * FROM dbo.sysdatabases WHERE name='SecurityMaster')
DROP DATABASE SecurityMaster;
GO

use [C:\USERS\ASHU\DOCUMENTS\SECMASTERDB.MDF]

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'core')
EXEC sys.sp_executesql N'CREATE SCHEMA [core]'

GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'eq')
EXEC sys.sp_executesql N'CREATE SCHEMA [eq]'

GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'cb')
EXEC sys.sp_executesql N'CREATE SCHEMA [cb]'

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name='ivp_secm_core_sectype_id' AND table_schema='core')
DROP TABLE core.ivp_secm_core_sectype_id;

GO


--- creating the core table sec_id (to determine the sec_type_id)
CREATE TABLE core.ivp_secm_core_sectype_id(
code BIGINT PRIMARY KEY IDENTITY,   -- this will act as the sec_type_id for securities
sectype_name NVARCHAR(100) NOT NULL UNIQUE,   -- name of the security type <equity/bond>
sectype_description NVARCHAR(255) NOT NULL UNIQUE,  -- description of the security_type
created_by NVARCHAR(50) NOT NULL,
created_on DATE,
last_modified_by NVARCHAR(50),
last_modified_on DATE,
);

GO

-- checking whether the master table ivp_secm_core_mastersecurity exists or not
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='ivp_secm_core_mastersecurity' AND TABLE_SCHEMA='core')
DROP TABLE core.ivp_secm_core_mastersecurity;

GO

-- creating the master table (for mapping the table names for the security type)
CREATE TABLE core.ivp_secm_core_mastersecurity(
code BIGINT PRIMARY KEY IDENTITY,
sectype_id BIGINT FOREIGN KEY REFERENCES core.ivp_secm_core_sectype_id(code) on delete cascade,
table_name NVARCHAR(100) NOT NULL UNIQUE,
)

GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='ivp_secm_core_securityidentifier' AND TABLE_SCHEMA='core')
DROP TABLE core.ivp_secm_core_securityidentifier;

GO

-- creating security_identifier table (common for both security types)
create table core.ivp_secm_core_securityidentifier(
code bigint primary key identity,
cusip nvarchar(100),
isin nvarchar(100),
sedol nvarchar(100),
bloomberg_ticker nvarchar(100),
bloomberg_unique_id bigint unique,
bloomberg_global_id bigint unique,
bloomberg_ticker_and_exchange nvarchar(100)
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_core_referencedata' AND TABLE_SCHEMA='core')
drop table core.ivp_secm_core_referencedata;

go
create table core.ivp_secm_core_referencedata(
code bigint primary key identity,
issue_country nvarchar(100),
exchange nvarchar(100),
issuer nvarchar(100),
issue_currency nvarchar(100),
trading_currency nvarchar(100),
bloomberg_industry_sub_group nvarchar(100),
bloomberg_industry_group nvarchar(100),
bloomberg_industry_sector nvarchar(100),
country_of_incorporation nvarchar(100),
risk_currency nvarchar(100)
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_securitysummary' AND TABLE_SCHEMA='eq')
drop table eq.ivp_secm_securitysummary;

go

create table eq.ivp_secm_securitysummary(
security_id bigint primary key identity(100,1),
security_name nvarchar(255) not null,
security_description nvarchar(255),
has_position nvarchar(10),
is_active bit not null,
round_lot_size nvarchar(10),
bloomberg_unique_name nvarchar(255) unique,
created_by nvarchar(50) not null,
created_on date,
last_modified_by nvarchar(50),
last_modified_on date,
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_securitydetails' AND TABLE_SCHEMA='eq')
drop table eq.ivp_secm_securitydetails;

go

create table eq.ivp_secm_securitydetails(
code bigint primary key identity,
fk_security_id bigint foreign key references  eq.ivp_secm_securitysummary(security_id),
is_adr nvarchar(100),
adr_underlying_ticker nvarchar(100),
adr_underlying_currency nvarchar(100),
shares_per_adr nvarchar(100),
ipo_date date,
price_currency nvarchar(100),
settle_days bigint,
shares_outstanding nvarchar(100),
voting_rights_per_share nvarchar(100),
form_pf_asset_class nvarchar(100),
form_pf_country nvarchar(100),
form_pf_credit_rating nvarchar(100),
form_pf_currency nvarchar(100),
form_pf_instrument nvarchar(100),
form_pf_liquid_profile nvarchar(100),
form_pf_maturity nvarchar(100),
form_pf_naics_code nvarchar(100),
form_pf_region nvarchar(100),
form_pf_sector nvarchar(100),
form_pf_sub_asset_class nvarchar(100)
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_risk' AND TABLE_SCHEMA='eq')
drop table eq.ivp_secm_risk;

go

create table eq.ivp_secm_risk(
code bigint primary key identity,
fk_security_id bigint foreign key references  eq.ivp_secm_securitysummary(security_id),
twenty_day_average_volume nvarchar(100),
beta nvarchar(100),
short_interest nvarchar(100),
ytd_return nvarchar(100),
ninty_day_price_volatility nvarchar(100),
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_pricingdetails' AND TABLE_SCHEMA='eq')
drop table eq.ivp_secm_pricingdetails;

go

create table eq.ivp_secm_pricingdetails(
code bigint primary key identity,
fk_security_id bigint foreign key references  eq.ivp_secm_securitysummary(security_id),
open_price money,
close_price money,
volume bigint,
last_price money,
ask_price money,
bid_price money,
pe_ratio nvarchar(100)
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_dividendhistory' AND TABLE_SCHEMA='eq')
drop table eq.ivp_secm_dividendhistory;

go

create table eq.ivp_secm_dividendhistory(
code bigint primary key identity,
fk_security_id bigint foreign key references  eq.ivp_secm_securitysummary(security_id),
declared_date date,
ex_date date,
record_date date,
pay_date date,
amount money,
frequency nvarchar(100),
dividend_type nvarchar(100),
created_by nvarchar(50) not null,  --- field not in the sample data file
created_on date,    --- field not in the sample data file
last_modified_by nvarchar(50),   --- field not in the sample data file
last_modified_on date,   -- field not in the sample data file
is_active bit    --- field not in the sample data file
)

go

/***************Corporate Bond**********************/

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_securitysummary' AND TABLE_SCHEMA='cb')
drop table cb.ivp_secm_securitysummary;

go


--creating the security_summary table for corporate bond
create table cb.ivp_secm_securitysummary(
security_id bigint primary key identity(100000,1),
security_description nvarchar(100),
security_name nvarchar(100),
asset_type nvarchar(100),
investment_type nvarchar(100),
trading_factor nvarchar(100),
pricing_factor nvarchar(100),
created_by nvarchar(50) not null,
created_on date,
last_modified_by nvarchar(50),
last_modified_on date,
is_active bit
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_securitydetails' AND TABLE_SCHEMA='cb')
drop table cb.ivp_secm_securitydetails;

go


--creating the security_details + regulatory_details table (common for both equity and bond security types)
create table cb.ivp_secm_securitydetails(
code bigint primary key identity,  --identity column for the security_details table
fk_security_id bigint foreign key references  cb.ivp_secm_securitysummary(security_id),
first_coupon_date date,
coupon_cap nvarchar(100),
coupon_floor nvarchar(100),
coupon_frequency nvarchar(100),
coupon_rate nvarchar(100),
coupon_type nvarchar(100),
float_spread nvarchar(100),
is_callable nvarchar(100),
is_fix_to_float nvarchar(100),
is_putable nvarchar(100),
issue_date date,
last_reset_date date,
maturity_date date,
maximum_call_notice_days bigint,
maximum_put_notice_days bigint,
penultimate_coupon_date date,
reset_frequency nvarchar(100),
has_position nvarchar(100),
form_pf_asset_class nvarchar(100),
form_pf_country nvarchar(100),
form_pf_credit_rating nvarchar(100),
form_pf_currency nvarchar(100),
form_pf_instrument nvarchar(100),
form_pf_liquidity_profile nvarchar(100),
form_pf_maturity nvarchar(100),
form_pf_naics_code nvarchar(100),
form_pf_region nvarchar(100),
form_pf_sector nvarchar(100),
form_pf_sub_asset_class nvarchar(100)
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_risk' AND TABLE_SCHEMA='cb')
drop table cb.ivp_secm_risk;

go

create table cb.ivp_secm_risk(
code bigint primary key identity,
fk_security_id bigint foreign key references  cb.ivp_secm_securitysummary(security_id),
firstcouponcode nvarchar(100),
duration nvarchar(100),
volatility_thirtyD nvarchar(100),
volatility_nintyD nvarchar(100),
convexity nvarchar(100),
average_volume_thirtyD nvarchar(100)
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_putschedule' AND TABLE_SCHEMA='cb')
drop table cb.ivp_secm_putschedule;

go

create table cb.ivp_secm_putschedule(
code bigint primary key identity,
fk_security_id bigint foreign key references  cb.ivp_secm_securitysummary(security_id),
put_date date,
put_price money,
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_pricingandanalytics' AND TABLE_SCHEMA='cb')
drop table cb.ivp_secm_pricingandanalytics;

go

create table cb.ivp_secm_pricingandanalytics(
code bigint primary key identity,
fk_security_id bigint foreign key references  cb.ivp_secm_securitysummary(security_id),
ask_price money,
high_price money,
low_price money,
open_price money,
volume bigint,
bid_price money,
last_price money
)

go

IF EXISTS (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='ivp_secm_callschedule' AND TABLE_SCHEMA='cb')
drop table cb.ivp_secm_pricingandanalytics;

go

create table cb.ivp_secm_callschedule(
code bigint primary key identity,
fk_security_id bigint foreign key references  cb.ivp_secm_securitysummary(security_id),
call_date date,
call_price money,
)

go
