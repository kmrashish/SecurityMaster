

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[eq].[sp_ivp_secm_iud_security]') AND type in (N'P', N'PC'))
DROP PROCEDURE eq.sp_ivp_secm_iud_security

GO
/****** Object:  StoredProcedure [eq].[sp_ivp_secm_iud_security]    Script Date: 21-Jan-15 1:18:16 PM ******/
--- Combine/Generic Store procedure for insert,update,delete --> Equity
create procedure eq.sp_ivp_secm_iud_security
	(
	@action nvarchar(10),
	@security_name nvarchar(255)= null,
	@security_description nvarchar(255) = null,
	@has_position nvarchar(10) = null,
	@is_active bit = null,
	@round_lot_size nvarchar(10) = null,
	@bloomberg_unique_name nvarchar(255) = null,
	@is_adr nvarchar(100) = null,
	@adr_underlying_ticker nvarchar(100) = null,
	@adr_underlying_currency nvarchar(100) = null,
	@shares_per_adr nvarchar(100) = null,
	@ipo_date date = null,
	@price_currency nvarchar(100) = null,
	@settle_days bigint = null,
	@shares_outstanding nvarchar(100) = null,
	@voting_rights_per_share nvarchar(100) = null,
	@form_pf_asset_class nvarchar(100) = null,
	@form_pf_country nvarchar(100) = null,
	@form_pf_credit_rating nvarchar(100) = null,
	@form_pf_currency nvarchar(100) = null,
	@form_pf_instrument nvarchar(100) = null,
	@form_pf_liquid_profile nvarchar(100) = null,
	@form_pf_maturity nvarchar(100) = null,
	@form_pf_naics_code nvarchar(100) = null,
	@form_pf_region nvarchar(100) = null,
	@form_pf_sector nvarchar(100) = null,
	@form_pf_sub_asset_class nvarchar(100) = null,
	@created_by nvarchar(50) = null,
	@created_on date = null,
	@last_modified_by nvarchar(50) = null,
	@last_modified_on date = null,
	@security_id bigint output
	)
AS              
BEGIN  
	SET NOCOUNT ON

-------------------------------------------------------	
	-- INSERT PROCEDURE
-------------------------------------------------------
	
	IF @Action = 'INSERT'
	BEGIN
		insert into eq.ivp_secm_securitysummary
		(
		security_Name,
		security_Description,
		has_Position,
		is_Active,
		round_Lot_Size,
		bloomberg_Unique_Name,
		created_by,
		created_on,
		last_modified_by,
		last_modified_on
		) 
		values
		(
		@security_Name,
		@security_Description,
		@has_Position,
		@is_Active,
		@round_Lot_Size,
		@bloomberg_Unique_Name,
		@created_by,
		@created_on,
		@last_modified_by,
		@last_modified_on
		);
		
		SET @security_id=SCOPE_IDENTITY();
		
		insert into eq.ivp_secm_securitydetails
		(
		fk_security_id,
		is_adr, 
		adr_underlying_ticker,
		adr_underlying_currency,
		shares_per_adr,
		ipo_date,
		price_currency,
		settle_days,
		shares_outstanding,
		voting_rights_per_share,
		form_pf_asset_class,
		form_pf_country,
		form_pf_credit_rating,
		form_pf_currency,
		form_pf_instrument,
		form_pf_liquid_profile,
		form_pf_maturity,
		form_pf_naics_code,
		form_pf_region,
		form_pf_sector,
		form_pf_sub_asset_class
		) 
		values
		( 
		@security_id,
		@is_adr,
		@adr_underlying_ticker,
		@adr_underlying_currency,
		@shares_per_adr,
		@ipo_date,
		@price_currency,
		@settle_days,
		@shares_outstanding,
		@voting_rights_per_share,
		@form_pf_asset_class,
		@form_pf_country,
		@form_pf_credit_rating,
		@form_pf_currency,
		@form_pf_instrument,
		@form_pf_liquid_profile,
		@form_pf_maturity,
		@form_pf_naics_code,
		@form_pf_region,
		@form_pf_sector,
		@form_pf_sub_asset_class
		);
	END


-------------------------------------------------------	
	-- UPDATE PROCEDURE
-------------------------------------------------------
	
	IF @Action = 'UPDATE'
	BEGIN
	update 	eq.ivp_secm_securitysummary set
	 security_Name=@security_Name ,
	 security_Description=@security_Description,
	 has_Position=@has_Position, 
	 is_Active=@is_Active, 
	 round_Lot_Size=@round_Lot_Size, 
	 last_modified_by=@last_modified_by, 
	 last_modified_on=@last_modified_on 
	 where  security_id=@security_id
	
	update eq.ivp_secm_securitydetails set 
	is_adr=@is_adr, 
	adr_underlying_ticker=@adr_underlying_ticker, 
	adr_underlying_currency=@adr_underlying_currency, 
	shares_per_adr=@shares_per_adr, 
	ipo_date=@ipo_date, 
	price_currency=@price_currency, 
	settle_days=@settle_days, 
	shares_outstanding=@shares_outstanding, 
	voting_rights_per_share=@voting_rights_per_share,
	form_pf_asset_class=@form_pf_asset_class,
	form_pf_country=@form_pf_country,
	form_pf_credit_rating=@form_pf_credit_rating,
	form_pf_currency=@form_pf_currency,
	form_pf_instrument=@form_pf_instrument,
	form_pf_liquid_profile=@form_pf_liquid_profile,
	form_pf_maturity=@form_pf_maturity,
	form_pf_naics_code=@form_pf_naics_code,
	form_pf_region=@form_pf_region,
	form_pf_sector=@form_pf_sector,
	form_pf_sub_asset_class=@form_pf_sub_asset_class 
	where fk_security_id=@security_id
	print 'DONE'
	END


-------------------------------------------------------	
	-- DELETE PROCEDURE
-------------------------------------------------------
	
	IF @Action = 'DELETE'
	BEGIN
	delete from eq.ivp_secm_securitydetails where fk_security_id=@security_id;
	delete from eq.ivp_secm_securitysummary where security_id=@security_id;
	END
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[cb].[sp_ivp_secm_iud_security]') AND type in (N'P', N'PC'))
DROP PROCEDURE cb.sp_ivp_secm_iud_security

GO

/****** Object:  StoredProcedure [cb].[sp_ivp_secm_iud_security]    Script Date: 21-Jan-15 1:18:16 PM ******/
--- Combine/Generic Store procedure for insert,update,delete --> Corporate Bond

create procedure cb.sp_ivp_secm_iud_security
	(
	@action nvarchar(10),
	@security_name nvarchar(255) = null,
	@security_description nvarchar(255) = null,
	@asset_type nvarchar(100) = null,
	@investment_type nvarchar(100) = null,
	@trading_factor nvarchar(100) = null,
	@pricing_factor nvarchar(255) = null,
	@first_coupon_date date = null,
	@coupon_cap nvarchar(100) = null,
	@coupon_floor nvarchar(100) = null,
	@coupon_frequency nvarchar(100) = null,
	@coupon_rate nvarchar(100) = null,
	@coupon_type nvarchar(100) = null,
	@float_spread nvarchar(100) = null,
	@is_callable nvarchar(100) = null,
	@is_fix_to_float nvarchar(100) = null,
	@is_putable nvarchar(100) = null,
	@issue_date date = null,
	@last_reset_date date = null,
	@maturity_date date = null,
	@maximum_call_notice_days bigint = null,
	@maximum_put_notice_days bigint = null,
	@penultimate_coupon_date date = null,
	@reset_frequency nvarchar(100) = null,
	@has_position nvarchar(100) = null,
	@form_pf_asset_class nvarchar(100) = null,
	@form_pf_country nvarchar(100) = null,
	@form_pf_credit_rating nvarchar(100) = null,
	@form_pf_currency nvarchar(100) = null,
	@form_pf_instrument nvarchar(100) = null,
	@form_pf_liquid_profile nvarchar(100) = null,
	@form_pf_maturity nvarchar(100) = null,
	@form_pf_naics_code nvarchar(100) = null,
	@form_pf_region nvarchar(100) = null,
	@form_pf_sector nvarchar(100) = null,
	@form_pf_sub_asset_class nvarchar(100) = null,
	@created_by nvarchar(50) = null,
	@created_on date = null,
	@last_modified_by nvarchar(50) = null,
	@last_modified_on date = null,
	@is_active bit = null,
	@security_id bigint output
	)
AS
BEGIN
	SET NOCOUNT ON
	

-------------------------------------------------------	
	-- INSERT PROCEDURE
-------------------------------------------------------
	
	
	IF @Action = 'INSERT'
	BEGIN
		insert into cb.ivp_secm_securitysummary
		(
		security_name,
		security_description,
		asset_type, 
		investment_type, 
		trading_factor, 
		pricing_factor, 
		created_by, 
		created_on, 
		last_modified_by, 
		last_modified_on , 
		is_active
		) 
		values
		(
		@security_Name,
		@security_Description,
		@asset_type,
		@investment_type,
		@trading_factor,
		@pricing_factor,
		@created_by,
		@created_on,
		@last_modified_by,
		@last_modified_on,
		@is_active
		);
		
		SET @security_id=SCOPE_IDENTITY();
		
		insert into cb.ivp_secm_securitydetails
		(
		fk_security_id,
		first_coupon_date, 
		coupon_cap, coupon_floor , 
		coupon_frequency , 
		coupon_rate , 
		coupon_type, 
		float_spread, 
		is_callable , 
		is_fix_to_float, 
		is_putable , 
		issue_date , 
		last_reset_date , 
		maturity_date , 
		maximum_call_notice_days, 
		maximum_put_notice_days , 
		penultimate_coupon_date, 
		reset_frequency , 
		has_position,
		form_pf_asset_class,
		form_pf_country,
		form_pf_credit_rating,
		form_pf_currency,
		form_pf_instrument,
		form_pf_liquidity_profile,
		form_pf_maturity,
		form_pf_naics_code,
		form_pf_region,
		form_pf_sector,
		form_pf_sub_asset_class
		 )
		values
		(
		@security_id,
		@first_coupon_date,
		@coupon_cap,
		@coupon_floor,
		@coupon_frequency,
		@coupon_rate,
		@coupon_type, 
		@float_spread,
		@is_callable,
		@is_fix_to_float,
		@is_putable,
		@issue_date,
		@last_reset_date,
		@maturity_date,
		@maximum_call_notice_days, 
		@maximum_put_notice_days,
		@penultimate_coupon_date,
		@reset_frequency,
		@has_position,
		@form_pf_asset_class,
		@form_pf_country,
		@form_pf_credit_rating,
		@form_pf_currency,
		@form_pf_instrument,
		@form_pf_liquid_profile,
		@form_pf_maturity,
		@form_pf_naics_code,
		@form_pf_region,
		@form_pf_sector,
		@form_pf_sub_asset_class
		)
	
	END

-------------------------------------------------------	
	-- UPDATE PROCEDURE
-------------------------------------------------------
	
	IF @Action = 'UPDATE'
	BEGIN
	update cb.ivp_secm_securitysummary set 
	security_name=@security_Name , 
	security_description=@security_Description, 
	asset_type=@asset_type, 
	investment_type=@investment_type, 
	trading_factor=@trading_factor,
	pricing_factor=@pricing_factor, 
	last_modified_by=@last_modified_by, 
	last_modified_on=@last_modified_on,
	is_active=@is_active 
	where  security_id=@security_id
	
	update cb.ivp_secm_securitydetails set 
	first_coupon_date=@first_coupon_date, 
	coupon_cap=@coupon_cap, 
	coupon_floor=@coupon_floor, 
	coupon_frequency=@coupon_frequency, 
	coupon_rate=@coupon_rate, 
	coupon_type=@coupon_type, 
	float_spread=@float_spread, 
	is_callable=@is_callable, 
	is_fix_to_float=@is_fix_to_float, 
	is_putable=@is_putable, 
	issue_date=@issue_date, 
	last_reset_date=@last_reset_date, 
	maturity_date=@maturity_date, 
	maximum_call_notice_days=@maximum_call_notice_days, 
	maximum_put_notice_days=@maximum_put_notice_days, 
	reset_frequency=@reset_frequency, 
	has_position=@has_position,
	form_pf_asset_class=@form_pf_asset_class,
	form_pf_country=@form_pf_country,
	form_pf_credit_rating=@form_pf_credit_rating,
	form_pf_currency=@form_pf_currency,
	form_pf_instrument=@form_pf_instrument,
	form_pf_liquidity_profile=@form_pf_liquid_profile,
	form_pf_maturity=@form_pf_maturity,
	form_pf_naics_code=@form_pf_naics_code,
	form_pf_region=@form_pf_region,
	form_pf_sector=@form_pf_sector,
	form_pf_sub_asset_class=@form_pf_sub_asset_class 
	where fk_security_id=@security_id
	print 'DONE'
	
	END

	
-------------------------------------------------------	
	-- DELETE PROCEDURE
-------------------------------------------------------
	

	IF @Action = 'DELETE'
	BEGIN
		delete from cb.ivp_secm_securitydetails where fk_security_id=@security_id;
		delete from cb.ivp_secm_securitysummary where security_id=@security_id;
	END
END

GO

-------------------------------------------------------	
	-- INSERT QUERIES
-------------------------------------------------------
	
-------------------------------------------------------	
	-- CORE QUERIES
-------------------------------------------------------
	
insert into core.ivp_secm_core_sectype_id(sectype_name,sectype_description,created_by,created_on,last_modified_by,last_modified_on) values('EQUITY','Equity SHARES','jaskeerat',GETDATE(),'xyz',GETDATE());

GO

insert into core.ivp_secm_core_sectype_id(sectype_name,sectype_description,created_by,created_on,last_modified_by,last_modified_on) values('Bonds',' Corporate Bonds','jaskeerat',GETDATE(),'xyz',GETDATE());

GO

insert into core.ivp_secm_core_mastersecurity(table_name,sectype_id) values('ivp_secm_securitysummary',1)

GO

insert into core.ivp_secm_core_securityidentifier(cusip,isin,sedol,bloomberg_ticker,bloomberg_unique_id,bloomberg_global_id)
values('cusip','10524','sedol','ticker',102214,457554);

GO

insert into core.ivp_secm_core_referencedata(issue_country,exchange,issuer,issue_currency,trading_currency,bloomberg_industry_sub_group,bloomberg_industry_group,bloomberg_industry_sector,country_of_incorporation,risk_currency)
values
('US','MAIL','GOVT','DOLLER','INR','SUB_GROUP','IND_GROUP','IND_SECTOR','US-INDIA','NONE');

GO

-------------------------------------------------------	
	-- EQUITY QUERIES
-------------------------------------------------------

GO
	
insert into eq.ivp_secm_securitysummary(security_name,security_description,has_position,is_active,round_lot_size,bloomberg_unique_name,created_by,created_on,last_modified_by,last_modified_on)
values
('EQUITY','EQUITY SHARES','A','TRUE','N','BLOOMBERG','jaskeerat',GETDATE(),'xyz',GETDATE());

GO

insert into eq.ivp_secm_securitydetails(fk_security_id,is_adr,adr_underlying_ticker,adr_underlying_currency,shares_per_adr,ipo_date,price_currency,settle_days,shares_outstanding,voting_rights_per_share,form_pf_asset_class,form_pf_country,form_pf_credit_rating,form_pf_currency,form_pf_instrument,form_pf_liquid_profile,form_pf_maturity,form_pf_naics_code,form_pf_region,form_pf_sector,form_pf_sub_asset_class)
values
(100,'Y','tickter','INR','100',GETDATE(),'100',20,'N','500','assets','INDIA','NONE','INR','INST','PRO','10 END','NICS','DELHI','SECTOR','SUB_ASSETS');

GO

insert into eq.ivp_secm_risk(fk_security_id,twenty_day_average_volume,beta,short_interest,ytd_return,ninty_day_price_volatility)
values
(100,'LACKS','NONE','INR','RETURN','VALALITY');

GO

insert into eq.ivp_secm_pricingdetails(fk_security_id,open_price,close_price,volume,last_price,ask_price,bid_price,pe_ratio)
values
(100,20,15,1000,22,14,16,'10');

GO

insert into eq.ivp_secm_dividendhistory(fk_security_id,declared_date,ex_date,record_date,pay_date,amount,frequency,dividend_type,created_by,created_on,last_modified_by,last_modified_on,is_active)
values
(100,GETDATE(),GETDATE(),GETDATE(),GETDATE(),2000,'FRE','TYPE','jaskeerat',GETDATE(),'xyz',GETDATE(),'TRUE');

GO

-------------------------------------------------------	
	-- CORPORATE BONDS QUERIES
-------------------------------------------------------

GO
	
insert into cb.ivp_secm_securitysummary(security_name,security_description,asset_type,investment_type,trading_factor,pricing_factor,created_by,created_on,last_modified_by,last_modified_on,is_active)
values
('CORPORATE BONDS','CORPORATE','DEBANTURES','FIXED','NONE','REGULAR','Jaskeerat',GETDATE(),'xyz',GETDATE(),'TRUE');

GO

insert into cb.ivp_secm_securitydetails( fk_security_id,first_coupon_date,coupon_cap,coupon_floor,coupon_frequency,coupon_rate,coupon_type,float_spread,is_callable,is_fix_to_float,is_putable,issue_date,last_reset_date,maturity_date,maximum_call_notice_days,maximum_put_notice_days,penultimate_coupon_date,reset_frequency,has_position,form_pf_asset_class,form_pf_country,form_pf_credit_rating,form_pf_currency,form_pf_instrument,form_pf_liquidity_profile,form_pf_maturity,form_pf_naics_code,form_pf_region,form_pf_sector,form_pf_sub_asset_class)
values
(100000,GETDATE(),'CAP','FLOOR','FREQUENCY','RATE','TYPE','FLOAT','Y','N','Y',GETDATE(),GETDATE(),GETDATE(),10,5,GETDATE(),'NONE','Y','assets','INDIA','NONE','INR','INST','PRO','10 END','NICS','DELHI','SECTOR','SUB_ASSETS');

GO

insert into cb.ivp_secm_risk(fk_security_id,firstcouponcode,duration,volatility_thirtyD,volatility_nintyD,convexity,average_volume_thirtyD)
values
(100000,'COUPON','10','20','40','BO','si');

GO

insert into cb.ivp_secm_putschedule(fk_security_id,put_date,put_price) 
values(100000,GETDATE(),100);

GO

insert into cb.ivp_secm_pricingandanalytics(fk_security_id,ask_price,high_price,low_price,open_price,volume,bid_price,last_price)
values
(100000,20,30,15,22,10,25,27);

GO

insert into cb.ivp_secm_callschedule(fk_security_id,call_date,call_price)
values
(100000,GETDATE(),100);

GO


-------------------------------------------------------	
	-- STORED PROCEDURE QUERIES
-------------------------------------------------------

-------------------------------------------------------	
	-- ENTITY
-------------------------------------------------------

GO

DECLARE @SECID bigint
exec eq.sp_ivp_secm_iud_security 'INSERT','EQU01','EQUAL','POS','TRUE','LOT','B_NAME1','ADR','TICKTER','INR','SHR','2015-01-20','US',10,'OUT','VOTING','assets','IND','CR','INR','INSTR','LIQPRO','MATURITY','naics','REGIN','SECTOR','SUB_ASSETS','jaskeerat','2015-01-20','XYZ','2015-01-20',@SECID out;
print @SECID;

GO

DECLARE @SECID bigint=101
exec eq.sp_ivp_secm_iud_security 'UPDATE','EQU0','EQUAL','POS','TRUE','LOT','B_NAME1','ADR','TICKTER','INR','SHR','2015-01-20','US',10,'OUT','VOTING','assets','IND','CR','INR','INSTR','LIQPRO','MATURITY','naics','REGIN','SECTOR','SUB_ASSETS','jaskeerat','2015-01-20','XYZ','2015-01-20',@SECID out;
print @SECID;

GO

DECLARE @SECID bigint=101
exec eq.sp_ivp_secm_iud_security @action='DELETE',  @security_id=@SECID out;
print @SECID;

-------------------------------------------------------	
	-- CORPORATE BOND
-------------------------------------------------------

GO

DECLARE @SECID bigint
exec cb.sp_ivp_secm_iud_security
'INSERT','SEQ','DESC','BOND','FIXED','FACTOR','PRICE','2015-01-20','CAP','FLOOR','FREQ','RATE','TYPE','FLOAT','Y','N','Y','2015-01-20','2015-01-20','2015-01-20',20,10,'2015-01-20','FREQ','500','assets','INDIA','NONE','INR','INST','PRO','10 END','NICS','DELHI','SECTOR','SUB_ASSETS','jaskeerat','2015-01-20','XYZ','2015-01-20','true',@SECID out;
print @SECID;

GO

DECLARE @SECID bigint=100001
exec cb.sp_ivp_secm_iud_security
'UPDATE','SEQ','DESC','BOND','FIXED','FACTOR','PRICE','2015-01-20','CAP','FLOOR','FREQ','RATE','TYPE','FLOAT','Y','N','Y','2015-01-20','2015-01-20','2015-01-20',20,10,'2015-01-20','FREQ','500','assets','INDIA','NONE','INR','INST','PRO','10 END','NICS','DELHI','SECTOR','SUB_ASSETS','jaskeerat','2015-01-20','XYZ','2015-01-20','true',@SECID out;
print @SECID;

GO

DECLARE @SECID bigint=100001
exec cb.sp_ivp_secm_iud_security @action='DELETE',  @security_id=@SECID out;
print @SECID;

