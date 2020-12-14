CREATE OR REPLACE PACKAGE "UIPKGIMPDCABL" AS

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
TYPE REF_CURSOR IS REF CURSOR;


procedure spPopulateCustomer(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
);

procedure spPopulateCard(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
);

procedure spPopulateAccount(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
);

procedure spPopulateAccountRel(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
);

FUNCTION fnBreakName
(
  inName varchar2,
  inType varchar2
) RETURN varchar2;

FUNCTION fnIsProductValid
(
  inFormatID varchar2,
  inProduct varchar2
) RETURN varchar2;

procedure spPopulateHeader(
 inFormatID VARCHAR2,
 outMsg OUT VARCHAR2,
 outRetVal OUT NUMBER
);

procedure spPopulateFooter(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
);


FUNCTION fnIsPrimaryProduct
(
  inFormatID varchar2,
  inProduct varchar2
) RETURN varchar2;

FUNCTION fnGetProductType
(
  inFormatID varchar2,
  inProduct varchar2,
  recordnumber varchar2  
) RETURN VARCHAR2;

PROCEDURE SPPOPULATECARDTRACK(
  INFORMATID VARCHAR2--, 
  -- outMsg OUT VARCHAR2,
  --outRetVal OUT NUMBER
);

procedure spPopulateCustomer_Enhanced(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
);

procedure spPopulateCard_Enhanced(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
);

procedure spPopulateAccount_Enhanced(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
);

procedure spPopulateAccountRel_Enhanced(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
);

--added by Adil
FUNCTION fnGetIntBranchById
(
  /*<param>*/
  incode varchar2,
  ININSTITUTIONID varchar2 default null-- ADD AUTHOR: "ZAINAB" TRACKERID: BUG "997"
  /*<param>*/
) return  VARCHAR2;

END UIPKGIMPDCABL;
/


CREATE OR REPLACE PACKAGE BODY      "UIPKGIMPDCABL" AS

  procedure spPopulateCustomer(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
) AS
  
  historyID VARCHAR2(100);
  spName VARCHAR2(100);
  spDesc VARCHAR2(500);
    
  BEGIN
    
     ---Fariha: Setting values of variables  
         
      outRetVal := -1;
      spName := 'UIPKGIMPDCABL.spPopulateCustomer';
      spDesc := 'SP to populate TBLIMPTMPCUSTOMER from TBLIMPLOGCUSTOMER';
      
      --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
      
      --Fariha: First Step is to log the start of this SP
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
      
      
      --Fariha: Moving data from log table to temp table
  
      insert into TBLIMPTMPCUSTOMER 
         (CUSTOMERID, STATUS, CNIC, NIC, DATEOFBIRTH, 
         HomeAddress1, HomeAddress2, HomeAddress3, HomeAddress4,
         HOMEPHONE, MOBILENUMBER, OFFICEPHONE, MOTHERSNAME, EMAIL, 
         COMPANY, HOMEPOSTALCODE, OFFICEADDRESS1, OFFICEADDRESS2, OFFICEADDRESS3, OFFICEADDRESS4, OFFICEADDRESS5, 
         OFFICEPOSTALCODE, DESIGNATION, IMD, FIRSTNAME, MIDDLENAME, LASTNAME, BILLINGFLAG, ACTIVIATIONDATE, 
         LASTUPDATEDDATE, REGISTRATIONDATE, BRANCH_CODE, PASSPORT_NO, OLDCUSTOMER_ID, TRANSACTIONALERTS, CHANNELALERTS, 
         TRANSACTIONINSURANCE, INTERNAL_BRANCH_ID, GENDER, HOSTCUSTOMERID, FAXNUMBER, PLACEOFBIRTH, NATIONALITY, 
         OCCUPATION, PROVINCE, MARITALSTATUS, ACTIONFLAG, ACTIONDATE, PROCESSFLAG, PROCESSDATE, INSTITUTIONID, 
         ERR_DESCRIPTION, FAILED, LOCATIONBRANCH, CONSUMERRNUMBER, FULLNAME, TITLE, LOG_FEEDBACK_ID, ERR_CODE, 
         ANNIVERSARYDATE, RECORDNUMBER, FATHERSNAME, REL2CUSTOMER)
     
          select null as CUSTOMERID, '00' as STATUS, CNIC, NIC, DATEOFBIRTH, 
          HomeAddress1, HomeAddress2, HomeAddress3, HomeAddress4,
          HOMEPHONE, MOBILENUMBER, OFFICEPHONE, MOTHERSNAME, 
          EMAIL, COMPANY, HOMEPOSTALCODE, OFFICEADDRESS1, OFFICEADDRESS2, OFFICEADDRESS3, OFFICEADDRESS4, OFFICEADDRESS5, 
          OFFICEPOSTALCODE, '' as DESIGNATION,
          (select defaultimd from tblinstitution where institutionid='0030') as IMD,
          UIPKGIMPDCABL.fnBreakName(fullname,'first') as FIRSTNAME,
          UIPKGIMPDCABL.fnBreakName(fullname,'middle') as MIDDLENAME,
          UIPKGIMPDCABL.fnBreakName(fullname,'last') as LASTNAME,
          BILLINGFLAG, ACTIVIATIONDATE, '' as  LASTUPDATEDDATE, '' as REGISTRATIONDATE, BRANCH_CODE,
          upper(PASSPORT_NO) as PASSPORT_NO, '' as OLDCUSTOMER_ID, '' as  TRANSACTIONALERTS, '' as CHANNELALERTS, 
          '' as TRANSACTIONINSURANCE,'' as INTERNAL_BRANCH_ID, '' as  GENDER, '' as HOSTCUSTOMERID, '' as FAXNUMBER, 
          '' as PLACEOFBIRTH, NATIONALITY, '' as OCCUPATION,'' as PROVINCE, '' as MARITALSTATUS,
           decode(tblimplogcustomer.ACTIONFLAG, '09','09',
            '03','03',
            '01','02',
            '00','01') ACTIONFLAG,
          ACTIONDATE, PROCESSFLAG, PROCESSDATE, INSTITUTIONID, '' as ERR_DESCRIPTION, '' as FAILED, LOCATIONBRANCH, 
          CONSUMERRNUMBER, FULLNAME, TITLE, LOG_FEEDBACK_ID, '' as ERR_CODE, ANNIVERSARYDATE,RECORDNUMBER, FATHERSNAME, REL2CUSTOMER
          FROM TBLIMPLOGCUSTOMER
          where
            log_process_code = '00' -- not processed
            and FORMAT_ID = inFormatID;                   
     
    
       --Fariha: Last Step is to log the end of this SP
      UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
       commit;
      
      outRetVal := 0;
      
    --Fariha: In case of any exception, return the oracle error code and message
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
            outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;          
        END;
      
  END spPopulateCustomer;

  procedure spPopulateCard(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
) AS

  historyID VARCHAR2(100);
  spName VARCHAR2(100);
  spDesc VARCHAR2(500);

  BEGIN

    
    ---Fariha: Setting values of variables  
         
      outRetVal := -1;
      spName := 'UIPKGIMPDCABL.spPopulateCard';
      spDesc := 'SP to populate TBLIMPTMPCARD from TBLIMPLOGCARD';
      
      --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
      
      --Fariha: First Step is to log the start of this SP
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
      
      
      --Fariha: Moving data from log table to temp table
    
    
       insert into TBLIMPTMPCARD (CARDNUMBER, EXPIRYDATE, CUSTOMERID, CARDNAME, CARDSTATUS, BRANCHID, CREATIONDATE, 
      PRODUCTID, IMD, RELATIONSHIP_ID, ACTIONFLAG, ACTIONDATE, PROCESSFLAG, PROCESSDATE, ERR_DESCRIPTION, JOBID, 
      RENEWAL_FEE_PAID, REPLACEMENT_FEE_PAID, ISSUANCE_FEE_PAID, EXCEPTIONFILE_STATUS, REGENERATION_TYPE, 
      RENEWAL_DATE, RENEWAL_STATUS, EXISTINGCARDNUMBER, DELIVERYSTATUS, MODIFICATION_DATE, IS_INDIVIDUAL, 
      PROCESSINGCODE, ACTIVATIONDATE, PRIMARYCARDNUMBER, REGIONCODE, HUBCODE, CVV2, CVV1, TRACK3_DATA, TRACK2_DATA, 
      TRACK1_DATA, LANGUAGECODE, SERVICECODE, ISSUPPLEMENTARYCARD, FAILED, CUSTOMERTYPE, RFLIMIT, MARKUPRATE, 
      DESIGNCODE, CARD_INTERFACING_NO, HOMEADDRESS1, HOMEADDRESS2, HOMEADDRESS3, HOMEADDRESS4, LOCATIONBRANCH, 
      ERR_CODE, LOG_FEEDBACK_ID,INSTITUTIONID,SEQNO,RECORDNUMBER, OLDPAN, OLDCARDEXPIRYDATE, CNIC, format_id, firstcardnumber
      ,DESTINATION_PRODUCTID) --NAZIM: Added for soft recarding
      
      SELECT CARDNUMBER, EXPIRYDATE,
      CNIC, CARDNAME, '11', BRANCHID, CREATIONDATE,
      UIPKGABL.fngetinternalproductcode(PRODUCTID) PRODUCTID,
      --(select defaultimd from tblinstitution where institutionid='0030') as IMD, 
      '' as IMD, -- Fariha: Keeping IMD null for now, it will be updated in BLL layer
      CARDNUMBER,
      decode(TBLIMPLOGCARD.ACTIONFLAG, '09','09',
            '03','03',
            '01','02',
            '00','01') ACTIONFLAG,
      ACTIONDATE, PROCESSFLAG, PROCESSDATE, ERR_DESCRIPTION, LOG_FEEDBACK_ID as JOBID, RENEWAL_FEE_PAID, 
      REPLACEMENT_FEE_PAID, ISSUANCE_FEE_PAID, EXCEPTIONFILE_STATUS,
      decode(TBLIMPLOGCARD.REGENERATION_TYPE, '00','10', --new
              '01','11', -- reissued
              '02','12'  -- soft recarding
              ) REGENERATION_TYPE,              
      RENEWAL_DATE, RENEWAL_STATUS,  
      '', DELIVERYSTATUS, MODIFICATION_DATE, IS_INDIVIDUAL, 
      PROCESSINGCODE, ACTIVATIONDATE, PRIMARYCARDNUMBER, REGIONCODE, HUBCODE, CVV2, CVV1, TRACK3_DATA, TRACK2_DATA, 
      TRACK1_DATA, LANGUAGECODE, SERVICECODE, ISSUPPLEMENTARYCARD, '', 
      decode(CUSTOMERTYPE,'0','02',
      '1','00')CUSTOMERTYPE, RFLIMIT, MARKUPRATE, DESIGNCODE, 
      CARD_INTERFACING_NO, HOMEADDRESS1, HOMEADDRESS2, HOMEADDRESS3, HOMEADDRESS4, /*LOCATIONBRANCH*/uipkgimpdcabl.fnGetIntBranchById(delivery_branch,'0030'), ERR_CODE,
      LOG_FEEDBACK_ID,INSTITUTIONID,SEQ_TBLIMPTMPCARD.NextVal, RECORDNUMBER, 
      OLDPAN, OLDCARDEXPIRYDATE, CNIC, format_id, 
      ''
      ,DESTINATION_PRODUCTID --NAZIM: Added for soft recarding
      
      FROM TBLIMPLOGCARD
      where
        log_process_code = '00' -- not processed
        and FORMAT_ID = inFormatID;
   
   --Fariha: Last Step is to log the end of this SP
      UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
       commit;
      
      outRetVal := 0;
      
       --Fariha: In case of any exception, return the oracle error code and message
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
             outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;        
             --raise_application_error(SQLCODE, spName || ': ' || SQLERRM);
          
        END;
  END spPopulateCard;

  procedure spPopulateAccount(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
) AS

  historyID VARCHAR2(100);
  spName VARCHAR2(100);
  spDesc VARCHAR2(500);

  BEGIN
  
    
    ---Fariha: Setting values of variables  
         
      outRetVal := -1;
      spName := 'UIPKGIMPDCABL.spPopulateAccount';
      spDesc := 'SP to populate TBLIMPTMPACCOUNT from TBLIMPLOGACCOUNT';
      
      --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
      
      --Fariha: First Step is to log the start of this SP
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
    
    
      --Fariha: Moving data from log table to temp table
      
      insert into TBLIMPTMPACCOUNT
      (TITLE, STATUS, ACTUAL_BALANCE, ACCOUNT_ID, ACCOUNT_TYPE, ACCOUNT_CURRENCY, 
      BRANCHID, AVAILABLE_BALANCE, OLDACCOUNT_ID, LAST_UPDATED, INTERNAL_BRANCH_ID, MARITALSTATUS, ACTIONFLAG, 
      ACTIONDATE, PROCESSFLAG, PROCESSDATE, INSTITUTIONID, ERR_DESCRIPTION, FAILED, CUSTOMERID, IS_DEFAULT, NATURE, 
      ERR_CODE, LOG_FEEDBACK_ID, CNIC, RECORDNUMBER)
      
          SELECT TITLE, STATUS, nvl(ACTUAL_BALANCE,'0') as ACTUAL_BALANCE, 
          trim(ACCOUNT_ID) as ACCOUNT_ID, 
          ACCOUNT_TYPE, ACCOUNT_CURRENCY, BRANCHID, nvl(AVAILABLE_BALANCE,'0') as AVAILABLE_BALANCE, OLDACCOUNT_ID, 
          LAST_UPDATED, INTERNAL_BRANCH_ID, MARITALSTATUS,
         decode(TBLIMPLOGACCOUNT.ACTIONFLAG, '02','03',
                '01','02',
                '00','01') ACTIONFLAG,
          ACTIONDATE, PROCESSFLAG, PROCESSDATE, INSTITUTIONID, '' as ERR_DESCRIPTION,'' as FAILED, CUSTOMERID, 
          IS_DEFAULT,
          '0' as NATURE, '' as ERR_CODE, LOG_FEEDBACK_ID,  trim(CNIC) as CNIC, RECORDNUMBER
          FROM TBLIMPLOGACCOUNT
          where
            log_process_code = '00' -- not processed
            and FORMAT_ID = inFormatID;
        
      
      
  /*Fariha - transferred to BL
   update TBLIMPLOGACCOUNT  --marking duplicate entries as failure records
    set --log_process_code='01',
        log_status='05'
    where
      log_process_code = '00' -- not processed
      and FORMAT_ID = inFormatID
      and log_feedback_id not in (select log_feedback_id from TBLIMPTMPACCOUNT);*/
      
    -- if account request is for add and already present in IRIS then change action flag to 02 to make it update request
    update TBLIMPTMPACCOUNT set actionflag='02'
    where actionflag='01'
    and (trim(ACCOUNT_ID), ACCOUNT_TYPE, ACCOUNT_CURRENCY) 
    in 
    (select trim(ACCOUNT_ID), ACCOUNT_TYPE, ACCOUNT_CURRENCY from tblaccount);
      
      --Fariha: Last Step is to log the end of this SP
      UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
       commit;
      
      outRetVal := 0;
      
      --Fariha: In case of any exception, return the oracle error code and message
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
             outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;        
             --raise_application_error(SQLCODE, spName || ': ' || SQLERRM);
          
        END;
  END spPopulateAccount;

  procedure spPopulateAccountRel(
   inFormatID VARCHAR2,
   outMsg OUT VARCHAR2,
   outRetVal OUT NUMBER
) AS

  historyID VARCHAR2(100);
  spName VARCHAR2(100);
  spDesc VARCHAR2(500);
  
  BEGIN
    
    ---Fariha: Setting values of variables  
         
      outRetVal := -1;
      spName := 'UIPKGIMPDCABL.spPopulateAccountRel';
      spDesc := 'SP to populate TBLIMPTMPACCOUNT from TBLIMPLOGACCOUNT';
      
      --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
      
      --Fariha: First Step is to log the start of this SP
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
    
    
    --Fariha: Moving data from log table to temp table
      insert into TBLIMPTMPACCOUNT_REL (CHANNEL_ID, RELATIONSHIP_ID, ACCOUNT_ID, Type, CURRENCY, ACCOUNTMAP, IS_DEFAULT, CUSTOMER_ID, NATURE, ACTIONFLAG, INSTITUTIONID, productid, RECORDNUMBER, cnic, DESTINATION_PRODUCTID) --NAZIM: Added for soft recarding
    select '9999' as CHANNEL_ID, tblimplogcard.cnic as RELATIONSHIP_ID,
    ACCOUNT_ID as ACCOUNT_ID, 
    ACCOUNT_TYPE as Type, ACCOUNT_CURRENCY as CURRENCY,
    ACCOUNT_ID as ACCOUNTMAP,
-- '0' as IS_DEFAULT,    
    IS_DEFAULT, tblimplogcard.CNIC, '0',
    decode(TBLIMPLOGACCOUNT.ACTIONFLAG, '02','03',
          '01','02',
          '00','01') ACTIONFLAG,      
    TBLIMPLOGACCOUNT.INSTITUTIONID, 
    nvl(UIPKGABL.fngetinternalproductcode(tblimplogcard.PRODUCTID), '-1') as productid,
    TBLIMPLOGACCOUNT.RECORDNUMBER,  TBLIMPLOGACCOUNT.cnic
    ,tblimplogcard.DESTINATION_PRODUCTID --NAZIM: Added for soft recarding
    from TBLIMPLOGACCOUNT
    inner join tblimplogcard on tblimplogcard.history_id = TBLIMPLOGACCOUNT.history_id
  --  left outer join tblimplogcard tc on tc.history_id = ta.history_id
    and tblimplogcard.FORMAT_ID  = TBLIMPLOGACCOUNT.FORMAT_ID
    and tblimplogcard.recordnumber = TBLIMPLOGACCOUNT.recordnumber
    and TBLIMPLOGACCOUNT.log_process_code = tblimplogcard.log_process_code
    where
      TBLIMPLOGACCOUNT.log_process_code = '00' -- not processed
      and TBLIMPLOGACCOUNT.FORMAT_ID = inFormatID;
    commit;
 
   --Fariha: Last Step is to log the end of this SP
      UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
       commit;
      
      outRetVal := 0;
      
      --Fariha: In case of any exception, return the oracle error code and message
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
            outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;        
            --raise_application_error(SQLCODE, spName || ': ' || SQLERRM);
          
        END;
  END spPopulateAccountRel;

  
FUNCTION fnBreakName
(
  inName varchar2,
  inType varchar2
) RETURN varchar2 
  IS
  tmpVar varchar2(40);
BEGIN
   tmpVar := '';
   
    if inType = 'first' then
      select trim(substr(inName,1,instr(inName,' '))) into tmpVar from dual;
    
    elsif inType = 'last' then
      select reverse(inName) into tmpVar from dual;
      select substr(tmpVar,1,instr(tmpVar,' ')) into tmpVar from dual;
      select reverse(trim(tmpVar)) into tmpVar from dual;
      
    elsif inType = 'middle' then
      select substr(inName,instr(inName,' '),length(inName)-instr(inName,' ')) into tmpVar from dual;
      select reverse(tmpVar) into tmpVar from dual;
      select substr(tmpVar,instr(tmpVar,' '),length(tmpVar)-instr(tmpVar,' ')) into tmpVar from dual;
      select reverse(trim(tmpVar)) into tmpVar from dual;
    end if;
                      
   return tmpVar;

  END fnBreakName;

  FUNCTION fnIsProductValid
(
  inFormatID varchar2,
  inProduct varchar2
) RETURN varchar2 IS
      tmpVar   varchar2(30);
      tmpCount Number;
    BEGIN
       tmpVar := 'false';
         
      if inFormatID in ('995', '985') then  ---Fariha:  995, 985 are Format IDs for ABL CIF Import Format
        select count(product_id) into tmpCount from tblcfgproduct
        where product_id = inProduct
        and producttype='Card Based'; ---Fariha: At ABL only card based product customers will be added through CIF
      end if;
      
      if tmpCount > 0 then
        tmpVar := 'true';
      end if;
                        
     return tmpVar;
     
  END fnIsProductValid;

  procedure spPopulateHeader(
   inFormatID VARCHAR2,
   outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
) AS

  historyID VARCHAR2(100);
  spName VARCHAR2(100);
  spDesc VARCHAR2(500);
  
  BEGIN
  
    ---Fariha: Setting values of variables  
         
      outRetVal := -1;
      spName := 'UIPKGIMPDCABL.spPopulateHeader';
      spDesc := 'SP to populate TBLIMPTMPHEADER from TBLIMPLOGHEADER';
      
      --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
      
      --Fariha: First Step is to log the start of this SP
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
      
      
    --Fariha: Moving data from log table to temp table
    insert into TBLIMPTMPHEADER (RECORDNUMBER, RECORDCATEGORY, RECORDDATE, FILENAME, RECORDVERSION, INSTITUTIONID, LOG_FEEDBACK_ID)
    SELECT RECORDNUMBER, RECORDCATEGORY, RECORDDATE, FILENAME, RECORDVERSION, INSTITUTIONID, LOG_FEEDBACK_ID
    FROM tblimplogheader
    where log_process_code = '00' and FORMAT_ID = inFormatID;

   --Fariha: Last Step is to log the end of this SP
      UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
       commit;
      
      outRetVal := 0;
      
      --Fariha: In case of any exception, return the oracle error code and message
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
             outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;        
             --raise_application_error(SQLCODE, spName || ': ' || SQLERRM);
          
        END;
    
  END spPopulateHeader;

  procedure spPopulateFooter(
   inFormatID VARCHAR2,
   outMsg OUT VARCHAR2,
   outRetVal OUT NUMBER
) AS

  historyID VARCHAR2(100);
  spName VARCHAR2(100);
  spDesc VARCHAR2(500);
  
  BEGIN
      ---Fariha: Setting values of variables  
         
      outRetVal := -1;
      spName := 'UIPKGIMPDCABL.spPopulateFooter';
      spDesc := 'SP to populate TBLIMPTMPFOOTER from TBLIMPLOGFOOTER';
      
      --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
      
      --Fariha: First Step is to log the start of this SP
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
     
     --Fariha: Moving data from log table to temp table
     insert into TBLIMPTMPFOOTER (RECORDNUMBER, RECORDCATEGORY, RECORDDATE, FILENAME, INSTITUTIONID, LOG_FEEDBACK_ID)
    SELECT RECORDNUMBER, RECORDCATEGORY, RECORDDATE, FILENAME, INSTITUTIONID, LOG_FEEDBACK_ID
    FROM tblimplogfooter
    where log_process_code = '00' and FORMAT_ID = inFormatID;

    --Fariha: Last Step is to log the end of this SP
      UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
       commit;
      
      outRetVal := 0;
      
     --Fariha: In case of any exception, return the oracle error code and message
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
             outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;        
             --raise_application_error(SQLCODE, spName || ': ' || SQLERRM);
          
        END;
      
  END spPopulateFooter;
  
   
   

  FUNCTION fnIsPrimaryProduct
(
  inFormatID varchar2,
  inProduct varchar2
) RETURN varchar2 IS
  tmpVar   varchar2(30);
  tmpCount Number;
BEGIN
   tmpVar := 'false';
     
  if inFormatID = '995' then
   /* select count(p.product_id) into tmpCount from tblcfgproduct p, tblcfgproductdetail pd
    where p.product_id = pd.product_id
    and pd.productcode = inProduct
    --where product_id = UIPKGABL.fngetinternalproductcode(inProduct)
    and nvl(issupplementry,'0') = '0';*/
    select count(*)  into tmpCount from tblcfgproduct 
    where product_id = inProduct
    and nvl(issupplementry,'0') = '0';
  end if;
  
  if tmpCount > 0 then
    tmpVar := 'true';
  end if;
                    
 return tmpVar;
  END fnIsPrimaryProduct;
  
  FUNCTION fnGetProductType
(
  inFormatID varchar2,
  inProduct varchar2,
  recordnumber varchar2
) RETURN varchar2
IS
  tmpVar   varchar2(30);
  tmpCount Number;
BEGIN
   tmpVar := '0';
     
  if inFormatID = '995' then
    select count(p.product_id) into tmpCount from tblcfgproduct p, tblcfgproductdetail pd
    where p.product_id = pd.product_id
    and pd.productcode = inProduct
    and nvl(issupplementry,'0') = '0';
  end if;
  
  if inProduct is null or tmpCount > 0 then
    tmpVar := '0';
  else tmpVar := recordnumber;
  end if;
                    
 return tmpVar;
  END fnGetProductType;


procedure spPopulateCustomer_Enhanced(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
) AS

  historyID VARCHAR2(100);
  spName VARCHAR2(100);
  spDesc VARCHAR2(500);
  
  BEGIN
  
      ---Fariha: Setting values of variables  
         
      outRetVal := -1;
      spName := 'UIPKGIMPDCABL.spPopulateCustomer_Enhanced';
      spDesc := 'SP to populate TBLIMPTMPCUSTOMER_ENHANCED from TBLIMPLOGCUSTOMER inner joined with TBLIMPLOGCARD';
      
      --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
      
      --Fariha: First Step is to log the start of this SP
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
   
      --Fariha: Moving data from log table to temp table
      
      insert into TBLIMPTMPCUSTOMER_ENHANCED 
         (CUSTOMERID, STATUS, CNIC, NIC, DATEOFBIRTH, 
         HomeAddress1, HomeAddress2, HomeAddress3, HomeAddress4,
         HOMEPHONE, MOBILENUMBER, OFFICEPHONE, MOTHERSNAME, EMAIL, 
         COMPANY, HOMEPOSTALCODE, OFFICEADDRESS1, OFFICEADDRESS2, OFFICEADDRESS3, OFFICEADDRESS4, OFFICEADDRESS5, 
         OFFICEPOSTALCODE, DESIGNATION, IMD, FIRSTNAME, MIDDLENAME, LASTNAME, BILLINGFLAG, ACTIVIATIONDATE, 
         LASTUPDATEDDATE, REGISTRATIONDATE, BRANCH_CODE, PASSPORT_NO, OLDCUSTOMER_ID, TRANSACTIONALERTS, CHANNELALERTS, 
         TRANSACTIONINSURANCE, INTERNAL_BRANCH_ID, GENDER, HOSTCUSTOMERID, FAXNUMBER, PLACEOFBIRTH, NATIONALITY, 
         OCCUPATION, PROVINCE, MARITALSTATUS, ACTIONFLAG, ACTIONDATE, PROCESSFLAG, PROCESSDATE, INSTITUTIONID, 
         ERR_DESCRIPTION, FAILED, LOCATIONBRANCH, CONSUMERRNUMBER, FULLNAME, TITLE, LOG_FEEDBACK_ID, ERR_CODE, 
         ANNIVERSARYDATE, RECORDNUMBER, FATHERSNAME, REL2CUSTOMER, casetype)
      select CUSTOMERID, STATUS, trim(CNIC), NIC, DATEOFBIRTH, 
       HomeAddress1, HomeAddress2, HomeAddress3, HomeAddress4,
       HOMEPHONE, MOBILENUMBER, OFFICEPHONE, MOTHERSNAME, EMAIL, 
       COMPANY, HOMEPOSTALCODE, OFFICEADDRESS1, OFFICEADDRESS2, OFFICEADDRESS3, OFFICEADDRESS4, OFFICEADDRESS5, 
       OFFICEPOSTALCODE, DESIGNATION, IMD, FIRSTNAME, MIDDLENAME, LASTNAME, BILLINGFLAG, ACTIVIATIONDATE, 
       LASTUPDATEDDATE, REGISTRATIONDATE, BRANCH_CODE,trim(PASSPORT_NO), OLDCUSTOMER_ID, TRANSACTIONALERTS, CHANNELALERTS, 
       TRANSACTIONINSURANCE, INTERNAL_BRANCH_ID, GENDER, HOSTCUSTOMERID, FAXNUMBER, PLACEOFBIRTH, NATIONALITY,
       OCCUPATION, PROVINCE, MARITALSTATUS, ACTIONFLAG, ACTIONDATE, PROCESSFLAG, PROCESSDATE, INSTITUTIONID, 
       ERR_DESCRIPTION, FAILED, LOCATIONBRANCH, CONSUMERRNUMBER, FULLNAME, TITLE, LOG_FEEDBACK_ID, ERR_CODE, 
       ANNIVERSARYDATE, RECORDNUMBER, FATHERSNAME, REL2CUSTOMER,CASETYPE
       from (
        Select temp1.* , ROW_NUMBER() OVER (PARTITION BY CNIC ORDER BY CNIC) AS rn
     from
     (
     select case 
     when ((
     select count(*) from tblimplogaccount where tblimplogaccount.format_id = tblimplogcustomer.format_id 
     and tblimplogaccount.recordnumber = tblimplogcustomer.recordnumber 
     and tblimplogaccount.history_id = tblimplogcustomer.history_id 
     and tblimplogaccount.log_process_code = tblimplogcustomer.log_process_code) > 1) then 'C7' --for multiple action on account
     when tblimplogaccount.actionflag = '00'
      then 'C4'
      when tblimplogaccount.actionflag = '09'
      then 'C5'
      when tblimplogaccount.actionflag = '03'
      then 'C6'
      end as casetype,
      tblimplogcustomer.CNIC as CUSTOMERID, '00' as STATUS, tblimplogcustomer.CNIC, tblimplogcustomer.NIC, tblimplogcustomer.DATEOFBIRTH, 
      tblimplogcustomer.HomeAddress1, tblimplogcustomer.HomeAddress2, tblimplogcustomer.HomeAddress3, tblimplogcustomer.HomeAddress4,
      tblimplogcustomer.HOMEPHONE, tblimplogcustomer.MOBILENUMBER, tblimplogcustomer.OFFICEPHONE, tblimplogcustomer.MOTHERSNAME, 
      tblimplogcustomer.EMAIL, tblimplogcustomer.COMPANY, tblimplogcustomer.HOMEPOSTALCODE, tblimplogcustomer.OFFICEADDRESS1, tblimplogcustomer.OFFICEADDRESS2, tblimplogcustomer.OFFICEADDRESS3, tblimplogcustomer.OFFICEADDRESS4, tblimplogcustomer.OFFICEADDRESS5, 
      Officepostalcode, '' As Designation,
      (select defaultimd from tblinstitution where institutionid='0030') as IMD,
      UIPKGIMPDCABL.fnBreakName(fullname,'first') as FIRSTNAME,
      UIPKGIMPDCABL.fnBreakName(fullname,'middle') as MIDDLENAME,
      UIPKGIMPDCABL.fnBreakName(fullname,'last') as LASTNAME,
      NVL(BILLINGFLAG,'H') as BILLINGFLAG, tblimplogcustomer.ACTIVIATIONDATE, '' as  LASTUPDATEDDATE, '' as REGISTRATIONDATE, tblimplogcustomer.BRANCH_CODE,
      upper(tblimplogcustomer.PASSPORT_NO) as PASSPORT_NO, '' as OLDCUSTOMER_ID, '' as  TRANSACTIONALERTS, '' as CHANNELALERTS, 
      '' as TRANSACTIONINSURANCE,'' as INTERNAL_BRANCH_ID, '' as  GENDER, '' as HOSTCUSTOMERID, '' as FAXNUMBER, 
      '' as PLACEOFBIRTH, NATIONALITY, '' as OCCUPATION,'' as PROVINCE, '' as MARITALSTATUS,
      decode(tblimplogcustomer.ACTIONFLAG, '09','09',
            '03','03',
            '01','02',
            '00','01') ACTIONFLAG,
      --tblimplogcustomer.ACTIONFLAG,
      tblimplogcustomer.ACTIONDATE, tblimplogcustomer.PROCESSFLAG, tblimplogcustomer.PROCESSDATE, tblimplogcustomer.INSTITUTIONID, '' as ERR_DESCRIPTION, '' as FAILED, tblimplogcustomer.LOCATIONBRANCH, 
      tblimplogcustomer.CONSUMERRNUMBER, tblimplogcustomer.FULLNAME, tblimplogcustomer.TITLE, tblimplogcustomer.LOG_FEEDBACK_ID, '' as ERR_CODE, tblimplogcustomer.ANNIVERSARYDATE,tblimplogcustomer.RECORDNUMBER, tblimplogcustomer.FATHERSNAME, tblimplogcustomer.REL2CUSTOMER
     
     
     from tblimplogcustomer  
        inner join tblimplogcard on
        tblimplogcard.format_id = tblimplogcustomer.format_id
        and tblimplogcard.recordnumber = tblimplogcustomer.recordnumber
        and tblimplogcard.history_id = tblimplogcustomer.history_id
        and tblimplogcard.log_process_code = tblimplogcustomer.log_process_code
        
        inner join tblimplogaccount on
        tblimplogcard.format_id = tblimplogcustomer.format_id
        and tblimplogcard.recordnumber = tblimplogaccount.recordnumber
        and tblimplogcard.history_id = tblimplogaccount.history_id
        and tblimplogcard.log_process_code = tblimplogaccount.log_process_code
        
        where tblimplogcustomer.log_process_code = '00'
        --and a.history_id ='7088'
        and tblimplogcustomer.actionflag = '01'-----CaseType = 04
        and tblimplogcard.actionflag = '01'-----CaseType = 04
        and (tblimplogaccount.actionflag = '00' or tblimplogaccount.actionflag = '03' or tblimplogaccount.actionflag = '09')
        and tblimplogcustomer.format_id = inFormatid
        )temp1
        )temp2
        where 
        temp2.rn = 1;
      
      ------Update above inserted rows so not to insert them again
       Update tblimplogcustomer set log_process_code = '01', log_status = '11'
       where recordnumber in (select distinct recordnumber from tblimptmpcustomer_ENHANCED where casetype in ('C4','C5','C6','C7'))
       and log_process_code = '00'
       and format_id = inFormatid;
      
       --marking duplicate entries as failure records
      update TBLIMPLOGCUSTOMER 
      set log_process_code='01', log_status='12'
      where        
         log_feedback_id in (
          SELECT tblimplogcustomer.log_feedback_id
            from tblimplogcustomer
            inner join tblimplogcard on
            tblimplogcard.format_id = tblimplogcustomer.format_id
            and tblimplogcard.recordnumber = tblimplogcustomer.recordnumber
            and tblimplogcard.history_id = tblimplogcustomer.history_id
            and tblimplogcard.log_process_code = tblimplogcustomer.log_process_code
            
            inner join tblimplogaccount on
            tblimplogcard.format_id = tblimplogcustomer.format_id
            and tblimplogcard.recordnumber = tblimplogaccount.recordnumber
            and tblimplogcard.history_id = tblimplogaccount.history_id
            and tblimplogcard.log_process_code = tblimplogaccount.log_process_code
            
            where tblimplogcustomer.log_process_code = '00'
            and tblimplogcustomer.actionflag = '01'-----CaseType = 04
            and tblimplogcard.actionflag = '01'-----CaseType = 04
            and (tblimplogaccount.actionflag = '00' or tblimplogaccount.actionflag = '03' or tblimplogaccount.actionflag = '09')-----CaseType = 04
            and tblimplogcustomer.FORMAT_ID = inFormatID 
            and tblimplogcustomer.log_feedback_id not in (select log_feedback_id from tblimptmpcustomer_enhanced where casetype in ('C4','C5','C6','C7'))
         );
        
        
      INSERT INTO tblimpfeedbacklog (feedback_id, feedback_code, feedback_description)
            SELECT tblimplogcustomer .log_feedback_id, '' as err_code, 'Unique Constraint For CustomerID failed. Duplicate CustomerID Check For C4,C5,C6.' as err_description 
            from tblimplogcustomer 
            where tblimplogcustomer .log_status = '12';
     --marking duplicate entries as failure records
     
   --Fariha: Last Step is to log the end of this SP
      UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
       commit;
      
      outRetVal := 0;
      
      --Fariha: In case of any exception, return the oracle error code and message
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
             outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;        
             --raise_application_error(SQLCODE, spName || ': ' || SQLERRM);
          
        END;
        
  END spPopulateCustomer_Enhanced;
 
 
 procedure spPopulateCard_Enhanced(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
) AS

  historyID VARCHAR2(100);
  spName VARCHAR2(100);
  spDesc VARCHAR2(500);
  
  BEGIN
  
       ---Fariha: Setting values of variables  
         
      outRetVal := -1;
      spName := 'UIPKGIMPDCABL.spPopulateCard_Enhanced';
      spDesc := 'SP to populate TBLIMPTMPCARD_ENHANCED from TBLIMPLOGCARD inner joined with TBLIMPTMPCUSTOMER_ENHANCED';
      
      --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
      
      --Fariha: First Step is to log the start of this SP
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  
      --Fariha: Moving data from log table to temp table
  
       insert into TBLIMPTMPCARD_ENHANCED (CARDNUMBER, EXPIRYDATE, CUSTOMERID, CARDNAME, CARDSTATUS, BRANCHID, CREATIONDATE, 
      PRODUCTID, IMD, RELATIONSHIP_ID, ACTIONFLAG, ACTIONDATE, PROCESSFLAG, PROCESSDATE, ERR_DESCRIPTION, JOBID, 
      RENEWAL_FEE_PAID, REPLACEMENT_FEE_PAID, ISSUANCE_FEE_PAID, EXCEPTIONFILE_STATUS, REGENERATION_TYPE, 
      RENEWAL_DATE, RENEWAL_STATUS, EXISTINGCARDNUMBER, DELIVERYSTATUS, MODIFICATION_DATE, IS_INDIVIDUAL, 
      PROCESSINGCODE, ACTIVATIONDATE, PRIMARYCARDNUMBER, REGIONCODE, HUBCODE, CVV2, CVV1, TRACK3_DATA, TRACK2_DATA, 
      TRACK1_DATA, LANGUAGECODE, SERVICECODE, ISSUPPLEMENTARYCARD, FAILED, CUSTOMERTYPE, RFLIMIT, MARKUPRATE, 
      DESIGNCODE, CARD_INTERFACING_NO, HOMEADDRESS1, HOMEADDRESS2, HOMEADDRESS3, HOMEADDRESS4, LOCATIONBRANCH, 
      ERR_CODE, LOG_FEEDBACK_ID,INSTITUTIONID,SEQNO,RECORDNUMBER, OLDPAN, OLDCARDEXPIRYDATE, CNIC, PRIMARY_CNIC, PRIMARY_PRODUCT_CODE, format_id, firstcardnumber, casetype)
      
      SELECT trim(TBLIMPLOGCARD.CARDNUMBER), 
      --UIPKGABL.fnGetCardExpiryDate(PRODUCTID) as EXPIRYDATE,
      TBLIMPLOGCARD.EXPIRYDATE,
      trim(TBLIMPLOGCARD.CNIC), upper(TBLIMPLOGCARD.CARDNAME), '11', TBLIMPLOGCARD.BRANCHID, TBLIMPLOGCARD.CREATIONDATE,
      UIPKGABL.fngetinternalproductcode(TBLIMPLOGCARD.PRODUCTID) PRODUCTID,
     /* (select imd from tblcfgproduct p, tblcfgproductdetail pd
       where P.Product_Id = Pd.Product_Id
        and pd.productcode = a.PRODUCTID) as IMD, */
      TBLIMPLOGCARD.IMD, --Fariha: Keeping IMD null for now. It will be filled in datacopy layer    
      TBLIMPLOGCARD.CARDNUMBER,
      decode(TBLIMPLOGCARD.ACTIONFLAG, '09','09',
            '03','03',
            '01','02',
            '00','01') ACTIONFLAG,
      --TBLIMPLOGCARD.ACTIONFLAG,     
      TBLIMPLOGCARD.ACTIONDATE, TBLIMPLOGCARD.PROCESSFLAG, TBLIMPLOGCARD.PROCESSDATE, TBLIMPLOGCARD.ERR_DESCRIPTION, TBLIMPLOGCARD.HISTORY_ID as JOBID, TBLIMPLOGCARD.RENEWAL_FEE_PAID, 
      TBLIMPLOGCARD.REPLACEMENT_FEE_PAID, TBLIMPLOGCARD.ISSUANCE_FEE_PAID, TBLIMPLOGCARD.EXCEPTIONFILE_STATUS,
      REGENERATION_TYPE,              
      TBLIMPLOGCARD.RENEWAL_DATE, TBLIMPLOGCARD.RENEWAL_STATUS,  
      /*CASE WHEN REGENERATION_TYPE = '02' then trim(oldpan) || '=' || substr(oldcardexpirydate,3,4)
        else ''
        end,*/'', TBLIMPLOGCARD.DELIVERYSTATUS, TBLIMPLOGCARD.MODIFICATION_DATE, TBLIMPLOGCARD.IS_INDIVIDUAL, 
      TBLIMPLOGCARD.PROCESSINGCODE, TBLIMPLOGCARD.ACTIVATIONDATE, TBLIMPLOGCARD.PRIMARYCARDNUMBER, TBLIMPLOGCARD.REGIONCODE, TBLIMPLOGCARD.HUBCODE, TBLIMPLOGCARD.CVV2, TBLIMPLOGCARD.CVV1, TBLIMPLOGCARD.TRACK3_DATA, TBLIMPLOGCARD.TRACK2_DATA, 
      TBLIMPLOGCARD.TRACK1_DATA, TBLIMPLOGCARD.LANGUAGECODE, TBLIMPLOGCARD.SERVICECODE, TBLIMPLOGCARD.ISSUPPLEMENTARYCARD, '', TBLIMPLOGCARD.CUSTOMERTYPE, TBLIMPLOGCARD.RFLIMIT, TBLIMPLOGCARD.MARKUPRATE, TBLIMPLOGCARD.DESIGNCODE, 
      TBLIMPLOGCARD.CARD_INTERFACING_NO, TBLIMPLOGCARD.HOMEADDRESS1, TBLIMPLOGCARD.HOMEADDRESS2, TBLIMPLOGCARD.HOMEADDRESS3, TBLIMPLOGCARD.HOMEADDRESS4, uipkgimpdcabl.fnGetIntBranchById(TBLIMPLOGCARD.delivery_branch,'0030'), TBLIMPLOGCARD.ERR_CODE,
      TBLIMPLOGCARD.LOG_FEEDBACK_ID,TBLIMPLOGCARD.INSTITUTIONID,SEQ_TBLIMPTMPCARD.NextVal, TBLIMPLOGCARD.RECORDNUMBER, 
      trim(TBLIMPLOGCARD.OLDPAN), TBLIMPLOGCARD.OLDCARDEXPIRYDATE, trim(TBLIMPLOGCARD.CNIC), trim(TBLIMPLOGCARD.PRIMARY_CNIC), TBLIMPLOGCARD.PRIMARY_PRODUCT_CODE, TBLIMPLOGCARD.format_id, 
        /*CASE WHEN REGENERATION_TYPE = '02' then trim(oldpan) || '=' || substr(oldcardexpirydate,3,4)
        else ''
        end*/
        '',
        tblimptmpcustomer_Enhanced.casetype
              
      FROM TBLIMPLOGCARD 
      inner join tblimptmpcustomer_Enhanced on
        tblimptmpcustomer_Enhanced.recordnumber = TBLIMPLOGCARD.recordnumber
        and TBLIMPLOGCARD.log_process_code = '00'
        and TBLIMPLOGCARD.format_id = inFormatid
        and tblimptmpcustomer_Enhanced.casetype in ('C4','C5','C6','C7');
        
        
       ------Update above inserted rows so not to insert them again
       Update TBLIMPLOGCARD set log_process_code = '01', log_status = '13'
       where recordnumber in (select distinct recordnumber from TBLIMPTMPCARD_ENHANCED where casetype in ('C4','C5','C6','C7'))
       and log_process_code = '00'
       and format_id = inFormatid;
        
    --Fariha: Last Step is to log the end of this SP
      UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
       commit;
      
      outRetVal := 0;
      
      --Fariha: In case of any exception, return the oracle error code and message
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
             outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;        
             --raise_application_error(SQLCODE, spName || ': ' || SQLERRM);
          
        END;
  END spPopulateCard_Enhanced;
  
  
  procedure spPopulateAccount_Enhanced(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
) AS

  historyID VARCHAR2(100);
  spName VARCHAR2(100);
  spDesc VARCHAR2(500);
  
  BEGIN
  
        ---Fariha: Setting values of variables  
         
      outRetVal := -1;
      spName := 'UIPKGIMPDCABL.spPopulateAccount_Enhanced';
      spDesc := 'SP to populate TBLIMPTMPACCOUNT_ENHANCED from TBLIMPLOGACCOUNT inner joined with TBLIMPTMPCARD_ENHANCED';
      
      --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
      
      --Fariha: First Step is to log the start of this SP
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  
      --Fariha: Moving data from log table to temp table
  
        insert into TBLIMPTMPACCOUNT_ENHANCED
      (TITLE, STATUS, ACTUAL_BALANCE, ACCOUNT_ID, ACCOUNT_TYPE, ACCOUNT_CURRENCY, 
      BRANCHID, AVAILABLE_BALANCE, OLDACCOUNT_ID, LAST_UPDATED, INTERNAL_BRANCH_ID, MARITALSTATUS, ACTIONFLAG, 
      ACTIONDATE, PROCESSFLAG, PROCESSDATE, INSTITUTIONID, ERR_DESCRIPTION, FAILED, CUSTOMERID, IS_DEFAULT, NATURE, 
      ERR_CODE, LOG_FEEDBACK_ID, CNIC, BANKIMD, RECORDNUMBER, CARDNUMBER, CASETYPE)
      
    select       TITLE, STATUS, ACTUAL_BALANCE,trim(ACCOUNT_ID),ACCOUNT_TYPE, ACCOUNT_CURRENCY, 
      BRANCHID, AVAILABLE_BALANCE, OLDACCOUNT_ID, LAST_UPDATED, INTERNAL_BRANCH_ID, MARITALSTATUS, ACTIONFLAG, 
      ACTIONDATE, PROCESSFLAG, PROCESSDATE, INSTITUTIONID, ERR_DESCRIPTION, FAILED, trim(CNIC) /*CUSTOMERID DualProfileCase*/, 
      IS_DEFAULT, 
      NATURE,
      ERR_CODE, LOG_FEEDBACK_ID, CNIC, BANKIMD, RECORDNUMBER,CARDNUMBER, CASETYPE 
      from(
      select
      t.*, ROW_NUMBER() OVER (PARTITION BY ACCOUNT_ID,account_type,account_currency, CNIC/*, CASETYPE*/ ORDER BY ACTIONFLAG asc) AS rn
      from (
          SELECT tblimplogaccount.TITLE, nvl(tblimplogaccount.STATUS,'00') as STATUS, nvl(tblimplogaccount.ACTUAL_BALANCE,'0') as ACTUAL_BALANCE, 
          trim(tblimplogaccount.ACCOUNT_ID) as ACCOUNT_ID, 
          ACCOUNT_TYPE, ACCOUNT_CURRENCY, tblimplogaccount.BRANCHID, nvl(AVAILABLE_BALANCE,'0') as AVAILABLE_BALANCE, OLDACCOUNT_ID, 
          tblimplogaccount.LAST_UPDATED, tblimplogaccount.INTERNAL_BRANCH_ID, tblimplogaccount.MARITALSTATUS,
      decode(tblimplogaccount.ACTIONFLAG, '09','09',
            '03','03',
            '01','02',
            '00','01') ACTIONFLAG,  
         -- tblimplogaccount.ACTIONFLAG,
          tblimplogaccount.ACTIONDATE, tblimplogaccount.PROCESSFLAG, tblimplogaccount.PROCESSDATE, tblimplogaccount.INSTITUTIONID, '' as ERR_DESCRIPTION,'' as FAILED, tblimplogaccount.CUSTOMERID, 
          tblimplogaccount.IS_DEFAULT,
          '0' as NATURE, '' as ERR_CODE, tblimplogaccount.LOG_FEEDBACK_ID,  trim(tblimplogaccount.CNIC) as CNIC, tblimplogaccount.BANKIMD, tblimplogaccount.RECORDNUMBER, tblimplogaccount.CARDNUMBER,
            case when tblimptmpcard_Enhanced.casetype = 'C7' then 
                case when tblimplogaccount.actionflag = '00' then 'C4'
                      when tblimplogaccount.actionflag = '09' then 'C5'
                      when tblimplogaccount.actionflag = '03' then 'C6'
                      end
            else tblimptmpcard_Enhanced.casetype
            end as casetype
          
          From tblimplogaccount
          inner join tblimptmpcard_Enhanced on
          tblimptmpcard_Enhanced.recordnumber = tblimplogaccount.recordnumber
          and tblimplogaccount.log_process_code = '00'
          and tblimplogaccount.format_id = '995'
--          and a.actionflag = case when b.casetype = 'C4' then '00'
--                   when b.casetype = 'C5' then '09'
--                   when b.casetype = 'C6' then '03'
--                   end
          and tblimptmpcard_Enhanced.casetype in ('C4','C5','C6','C7')
          ) t
          )t2
          where t2.rn = 1;
      
             
      ------Update above inserted rows so not to insert them again       
      Update tblimplogaccount set log_process_code = '01', log_status = '14'
       where log_feedback_id in (select distinct log_feedback_id from tblimptmpaccount_ENHANCED where casetype in ('C4','C5','C6','C7'))
       and log_process_code = '00'
       and format_id = inFormatid;
       
   
       --marking duplicate entries as failure records
    update TBLIMPLOGACCOUNT  
      set log_process_code='01',
        log_status='15'
       where
      log_feedback_id in (SELECT TBLIMPLOGACCOUNT.log_feedback_id
            from tblimplogaccount 
            inner join tblimptmpcustomer_Enhanced on
             tblimptmpcustomer_Enhanced.recordnumber = TBLIMPLOGACCOUNT.recordnumber
            and TBLIMPLOGACCOUNT.log_process_code = '00'
            and TBLIMPLOGACCOUNT.format_id = inFormatid            
            and TBLIMPLOGACCOUNT.log_feedback_id not in (select log_feedback_id from tblimptmpaccount_enhanced where casetype in ('C4','C5','C6','C7'))
            );
            
        INSERT INTO tblimpfeedbacklog (feedback_id, feedback_code, feedback_description)
        SELECT log_feedback_id, '' as err_code, 'Unique Constraint For AccountID failed. Duplicate AccountID Check for C4,C5,C6,C7.' as err_description from TBLIMPLOGACCOUNT
        where log_status = '15';
    --marking duplicate entries as failure records
      
    -- if account request is for add and already present in IRIS then change action flag to 02 to make it update request
--    update TBLIMPTMPACCOUNT_ENHANCED set actionflag='02'
--    where actionflag='01'
--    and (trim(ACCOUNT_ID), ACCOUNT_TYPE, ACCOUNT_CURRENCY) 
--    in 
--    (select trim(ACCOUNT_ID), ACCOUNT_TYPE, ACCOUNT_CURRENCY from tblaccount); 
      
      --Fariha: Last Step is to log the end of this SP
      UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
       commit;
      
      outRetVal := 0;
      
      --Fariha: In case of any exception, return the oracle error code and message
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
            outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;        
            --raise_application_error(SQLCODE, spName || ': ' || SQLERRM);
          
        END;
        
  END spPopulateAccount_Enhanced;
  
  
  procedure spPopulateAccountRel_Enhanced(
  inFormatID VARCHAR2,
  outMsg OUT VARCHAR2,
  outRetVal OUT NUMBER
) AS

  historyID VARCHAR2(100);
  spName VARCHAR2(100);
  spDesc VARCHAR2(500);
  
  BEGIN
  
  
     ---Fariha: Setting values of variables  
         
      outRetVal := -1;
      spName := 'UIPKGIMPDCABL.spPopulateAccountRel_Enhanced';
      spDesc := 'SP to populate TBLIMPTMPACCOUNT_REL_ENHANCED from TBLIMPLOGACCOUNT inner joined with TBLIMPTMPCARD_ENHANCED';
      
      --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
      
      --Fariha: First Step is to log the start of this SP
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
      
      --Fariha: Moving data from log table to temp table
    insert into TBLIMPTMPACCOUNT_REL_ENHANCED (CHANNEL_ID, RELATIONSHIP_ID, ACCOUNT_ID, Type, CURRENCY, ACCOUNTMAP, IS_DEFAULT, CUSTOMER_ID, NATURE, ACTIONFLAG, INSTITUTIONID, productid, RECORDNUMBER, cnic, casetype)
    select CHANNEL_ID, RELATIONSHIP_ID, ACCOUNT_ID, Type, CURRENCY, ACCOUNTMAP, IS_DEFAULT, CUSTOMER_ID, NATURE,  ACTIONFLAG, INSTITUTIONID, productid, RECORDNUMBER, cnic, casetype 
    from(
      select 
      t.*, ROW_NUMBER() OVER (PARTITION BY ACCOUNT_ID,Type,CURRENCY, CNIC/*, CASETYPE*/ ORDER BY Actionflag asc) AS rn
      from (
          select '9999' as CHANNEL_ID, trim(tblimptmpcard_Enhanced.cnic) as RELATIONSHIP_ID,
        trim(ACCOUNT_ID) as ACCOUNT_ID, 
        ACCOUNT_TYPE as Type, ACCOUNT_CURRENCY as CURRENCY,
        ACCOUNT_ID as ACCOUNTMAP,
    -- '0' as IS_DEFAULT,    
        IS_DEFAULT, trim(tblimptmpcard_Enhanced.CNIC) as CUSTOMER_ID, '0' as NATURE,
          decode(TBLIMPLOGACCOUNT.ACTIONFLAG, '09','09',
                '03','03',
                '01','02',
                '00','01') ACTIONFLAG,
       -- TBLIMPLOGACCOUNT.ACTIONFLAG as ACTIONFLAG,      
        TBLIMPLOGACCOUNT.INSTITUTIONID as INSTITUTIONID, nvl(tblimptmpcard_Enhanced.PRODUCTID, '-1') as productid, TBLIMPLOGACCOUNT.RECORDNUMBER as RECORDNUMBER,  trim(TBLIMPLOGACCOUNT.cnic) as cnic, 
        case when tblimptmpcard_Enhanced.casetype = 'C7' then 
                    case when TBLIMPLOGACCOUNT.actionflag = '01' then 'C4'
                          when TBLIMPLOGACCOUNT.actionflag = '09' then 'C5'
                          when TBLIMPLOGACCOUNT.actionflag = '03' then 'C6'
                          end
                else tblimptmpcard_Enhanced.casetype
                end as casetype
          from TBLIMPLOGACCOUNT
          inner join tblimptmpcard_Enhanced on --tc.history_id = ta.history_id
        --  left outer join tblimplogcard tc on tc.history_id = ta.history_id
          --and tc.FORMAT_ID  = ta.FORMAT_ID
          tblimptmpcard_Enhanced.recordnumber = TBLIMPLOGACCOUNT.recordnumber
       --and ta.log_process_code = tc.log_process_code
          where
          TBLIMPLOGACCOUNT.log_process_code = '00' -- not processed
          and tblimptmpcard_Enhanced.CNIC = tblimplogaccount.cnic  ---Fariha:  To stop multiple entries as CNIC makes combination unique
          and TBLIMPLOGACCOUNT.FORMAT_ID = inFormatID
          )t)t2
          where t2.rn = 1;
 
    --Fariha: Last Step is to log the end of this SP
      UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
       commit;
      
      outRetVal := 0;
      
      --Fariha: In case of any exception, return the oracle error code and message
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
             outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;        
             --raise_application_error(SQLCODE, spName || ': ' || SQLERRM);
          
        END;
        
  END spPopulateAccountRel_Enhanced;
  



 procedure spPopulateCardTrack(
  INFORMATID VARCHAR2
--   outMsg OUT VARCHAR2,
--  outRetVal OUT NUMBER
) AS
  historyID VARCHAR2(100);
  SPNAME VARCHAR2(100);
  spDesc VARCHAR2(500);
  
  BEGIN
    
--      outRetVal := -1;    
      spName := 'UIPKGIMPDCABL.spPopulateCardTrack';
      spDesc := 'SP to populate TBLIMPTMPABL_CARDTRACK from TBLIMPLOGABL_CARDTRACK';
      
      select max(history_id) into historyID from tblimpformathistory
      where format_id=inFormatID;
    
      UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
    
   INSERT INTO TBLIMPTMPABL_CARDTRACK(CARDNUMBER,STATUS,CONSIGNMENT_NUM,RECV_NAME,DELIVERY_DATE,RELATIONSHIP_ID,CUSTOMER_ID,ENTRY_DATE,ERR_CODE, ERR_DESCRIPTION,INSTITUTIONID,LOG_FEEDBACK_ID,LOG_PROCESS_CODE,FORMAT_ID,LOG_STATUS,ACTIONFLAG,FAILED,HISTORY_ID, ISCUSTDETUPDATE)
  SELECT  TRIM(CARDNUMBER) CARDNUMBER,
          STATUS,
          TRIM(CONSIGNMENT_NUM) CONSIGNMENT_NUM,
          trim(RECV_NAME) RECV_NAME,
          DELIVERY_DATE,
          RELATIONSHIP_ID,
          CUSTOMER_ID,
          ENTRY_DATE,
          ERR_CODE,
          ERR_DESCRIPTION,
          INSTITUTIONID,
          LOG_FEEDBACK_ID,
          LOG_PROCESS_CODE,
          FORMAT_ID,
          LOG_STATUS,
          ACTIONFLAG,
          '' FAILED,
          HISTORY_ID, 
          '' ISCUSTDETUPDATE
FROM TBLIMPLOGABL_CARDTRACK WHERE LOG_PROCESS_CODE = '00' AND FORMAT_ID = inFormatID;

           UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
      
      
      -- outRetVal := 0;
       commit;
      
     
      
    
        EXCEPTION
          WHEN OTHERS THEN
          BEGIN
            -- outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;        
            rollback;
          
        END;
       
     
    
    COMMIT;
  END spPopulateCardTrack;

--added by Adil
FUNCTION fnGetIntBranchById
(
  /*<param>*/
  incode varchar2,
  ININSTITUTIONID varchar2 default null-- ADD AUTHOR: "ZAINAB" TRACKERID: BUG "997"
  /*<param>*/
) return  VARCHAR2

IS
  retname varchar2(100);
  P_INSTITUTIONID varchar2(10);-- ADD AUTHOR: "ZAINAB" TRACKERID: BUG "997"
begin

 -- ADD AUTHOR: "ZAINAB" TRACKERID: BUG "997"
  IF(ININSTITUTIONID IS NULL)
  THEN BEGIN
  SELECT INSTITUTIONID INTO P_INSTITUTIONID FROM TBLINSTITUTION WHERE ROWNUM = 1;
  END;
  ELSE P_INSTITUTIONID := ININSTITUTIONID;
  END IF ;
  -- /Add

  select internal_branch_id into retname from tblbranch where branch_id = incode
  and institutionid = P_INSTITUTIONID;

 return retName;

EXCEPTION
WHEN NO_DATA_FOUND THEN
 return incode;

END fnGetIntBranchById;

END UIPKGIMPDCABL;
/
