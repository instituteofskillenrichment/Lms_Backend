CREATE OR REPLACE PACKAGE "UIPKGIMPORTINSERTION" AS

TYPE REF_CURSOR IS REF CURSOR;

--CUSTOMER STATUS
ACTIVE_CUSTOMER     CONSTANT VARCHAR2(2) := '00';
INACTIVE_CUSTOMER   CONSTANT VARCHAR2(2) := '01';

--ACCOUNT STATUS
ACTIVE_ACCOUNT      CONSTANT  VARCHAR2(2) := '00';
INACTIVE_ACCOUNT    CONSTANT  VARCHAR2(2) := '01';

--CARD STATUS
ACTIVE_CARD     CONSTANT  VARCHAR2(2) := '00';
WARM_CARD       CONSTANT  VARCHAR2(2) := '01';
HOT_CARD        CONSTANT  VARCHAR2(2) := '02';

-- For Customer updation
Type        T_CUST_CUSTOMERID  IS TABLE OF TBLCUSTOMER.CUSTOMERID%TYPE;
Type            T_CUST_STATUS  IS TABLE OF TBLCUSTOMER.STATUS%TYPE;
Type        T_CUST_CNIC  IS TABLE OF TBLCUSTOMER.CNIC%TYPE;
Type         T_CUST_NIC  IS TABLE OF TBLCUSTOMER.NIC%TYPE;
Type       T_CUST_DATEOFBIRTH  IS TABLE OF TBLCUSTOMER.DATEOFBIRTH%TYPE;
Type         T_CUST_HOMEPHONE  IS TABLE OF TBLCUSTOMER.HOMEPHONE%TYPE;
Type      T_CUST_MOBILENUMBER  IS TABLE OF TBLCUSTOMER.MOBILENUMBER%TYPE;
Type       T_CUST_OFFICEPHONE  IS TABLE OF TBLCUSTOMER.OFFICEPHONE%TYPE;
Type       T_CUST_FATHERSNAME  IS TABLE OF TBLCUSTOMER.FATHERSNAME%TYPE;
Type       T_CUST_MOTHERSNAME  IS TABLE OF TBLCUSTOMER.MOTHERSNAME%TYPE;
Type             T_CUST_EMAIL  IS TABLE OF TBLCUSTOMER.EMAIL%TYPE;
Type           T_CUST_COMPANY  IS TABLE OF TBLCUSTOMER.COMPANY%TYPE;
Type      T_CUST_CUSTOMERTYPE  IS TABLE OF TBLCUSTOMER.CUSTOMERTYPE%TYPE;
Type              T_CUST_CITY  IS TABLE OF TBLCUSTOMER.CITY%TYPE;
Type           T_CUST_COUNTRY  IS TABLE OF TBLCUSTOMER.COUNTRY%TYPE;
Type      T_CUST_HOMEADDRESS1  IS TABLE OF TBLCUSTOMER.HOMEADDRESS1%TYPE;
Type      T_CUST_HOMEADDRESS2  IS TABLE OF TBLCUSTOMER.HOMEADDRESS2%TYPE;
Type      T_CUST_HOMEADDRESS3  IS TABLE OF TBLCUSTOMER.HOMEADDRESS3%TYPE;
Type      T_CUST_HOMEADDRESS4  IS TABLE OF TBLCUSTOMER.HOMEADDRESS4%TYPE;
Type      T_CUST_HOMEADDRESS5  IS TABLE OF TBLCUSTOMER.HOMEADDRESS5%TYPE;
Type    T_CUST_OFFICEADDRESS1  IS TABLE OF TBLCUSTOMER.OFFICEADDRESS1%TYPE;
Type    T_CUST_OFFICEADDRESS2  IS TABLE OF TBLCUSTOMER.OFFICEADDRESS2%TYPE;
Type    T_CUST_OFFICEADDRESS3  IS TABLE OF TBLCUSTOMER.OFFICEADDRESS3%TYPE;
Type    T_CUST_OFFICEADDRESS4  IS TABLE OF TBLCUSTOMER.OFFICEADDRESS4%TYPE;
Type    T_CUST_OFFICEADDRESS5  IS TABLE OF TBLCUSTOMER.OFFICEADDRESS5%TYPE;
Type       T_CUST_DESIGNATION  IS TABLE OF TBLCUSTOMER.DESIGNATION%TYPE;
Type               T_CUST_IMD  IS TABLE OF TBLCUSTOMER.IMD%TYPE;
Type         T_CUST_FIRSTNAME  IS TABLE OF TBLCUSTOMER.FIRSTNAME%TYPE;
Type        T_CUST_MIDDLENAME  IS TABLE OF TBLCUSTOMER.MIDDLENAME%TYPE;
Type          T_CUST_LASTNAME  IS TABLE OF TBLCUSTOMER.LASTNAME%TYPE;
Type       T_CUST_BILLINGFLAG  IS TABLE OF TBLCUSTOMER.BILLINGFLAG%TYPE;
Type   T_CUST_ACTIVIATIONDATE  IS TABLE OF TBLCUSTOMER.ACTIVIATIONDATE%TYPE;
Type   T_CUST_LASTUPDATEDDATE  IS TABLE OF TBLCUSTOMER.LASTUPDATEDDATE%TYPE;
Type  T_CUST_REGISTRATIONDATE  IS TABLE OF TBLCUSTOMER.REGISTRATIONDATE%TYPE;
Type       T_CUST_BRANCH_CODE  IS TABLE OF TBLCUSTOMER.BRANCH_CODE%TYPE;
Type       T_CUST_PASSPORT_NO  IS TABLE OF TBLCUSTOMER.PASSPORT_NO%TYPE;
Type    T_CUST_OLDCUSTOMER_ID  IS TABLE OF TBLCUSTOMER.OLDCUSTOMER_ID%TYPE;
Type T_CUST_TRANSACTIONALERTS  IS TABLE OF TBLCUSTOMER.TRANSACTIONALERTS%TYPE;
Type     T_CUST_CHANNELALERTS  IS TABLE OF TBLCUSTOMER.CHANNELALERTS%TYPE;
Type T_CUST_TRANSACTIONINSURANCE IS TABLE OF TBLCUSTOMER.TRANSACTIONINSURANCE%TYPE;
TYPE T_INTERNAL_BRANCH_ID IS TABLE OF TBLCUSTOMER.INTERNAL_BRANCH_ID%TYPE;
TYPE T_GENDER             IS TABLE OF TBLCUSTOMER.GENDER%TYPE;
TYPE T_FAXNUMBER          IS TABLE OF TBLCUSTOMER.FAXNUMBER%TYPE;
TYPE T_HOSTCUSTOMERID     IS TABLE OF TBLCUSTOMER.HOSTCUSTOMERID%TYPE;
TYPE T_OFFICEPOSTALCODE     IS TABLE OF TBLCUSTOMER.OFFICEPOSTALCODE%TYPE;
TYPE T_HOMEPOSTALCODE     IS TABLE OF TBLCUSTOMER.HOMEPOSTALCODE%TYPE;
-- for Account Updation
TYPE T_ACCT_TITLE             IS TABLE OF TBLACCOUNT.TITLE%Type;
TYPE T_ACCT_STATUS            IS TABLE OF TBLACCOUNT.STATUS%Type;
TYPE T_ACCT_ACTUAL_BALANCE    IS TABLE OF TBLACCOUNT.ACTUAL_BALANCE%Type;
TYPE T_ACCT_ACCOUNT_ID        IS TABLE OF TBLACCOUNT.ACCOUNT_ID%Type;
TYPE T_ACCT_ACCOUNT_TYPE      IS TABLE OF TBLACCOUNT.ACCOUNT_TYPE%Type;
TYPE T_ACCT_ACCOUNT_CURRENCY  IS TABLE OF TBLACCOUNT.ACCOUNT_CURRENCY%Type;
TYPE T_ACCT_LAST_UPDATED      IS TABLE OF TBLACCOUNT.LAST_UPDATED%Type;
TYPE T_ACCT_BRANCHID          IS TABLE OF TBLACCOUNT.BRANCHID%Type;
TYPE T_ACCT_AVAILABLE_BALANCE IS TABLE OF TBLACCOUNT.AVAILABLE_BALANCE%Type;
TYPE T_ACCT_OLDACCOUNT_ID     IS TABLE OF TBLACCOUNT.OLDACCOUNT_ID%Type;



-- for custchannelacct updation
TYPE T_REL_SELECTIONTYPE       IS TABLE OF TBLCUSTCHANNELACCT.SELECTIONTYPE      %Type;
TYPE T_REL_ACCOUNTMAP          IS TABLE OF TBLCUSTCHANNELACCT.ACCOUNTMAP         %Type;
TYPE T_REL_CHANNEL_ID          IS TABLE OF TBLCUSTCHANNELACCT.CHANNEL_ID         %Type;
TYPE T_REL_RELATIONSHIP_ID     IS TABLE OF TBLCUSTCHANNELACCT.RELATIONSHIP_ID    %Type;
TYPE T_REL_IS_DEFAULT          IS TABLE OF TBLCUSTCHANNELACCT.IS_DEFAULT         %Type;
TYPE T_REL_ACCOUNT_ID          IS TABLE OF TBLCUSTCHANNELACCT.ACCOUNT_ID         %Type;
TYPE T_REL_ACCOUNT_TYPE        IS TABLE OF TBLCUSTCHANNELACCT.ACCOUNT_TYPE       %Type;
TYPE T_REL_ACCOUNT_CURRENCY    IS TABLE OF TBLCUSTCHANNELACCT.ACCOUNT_CURRENCY   %Type;
TYPE T_REL_CUSTOMER_ID         IS TABLE OF TBLCUSTCHANNELACCT.CUSTOMER_ID        %Type;
TYPE T_REL_TRAN_PERM           IS TABLE OF TBLCUSTCHANNELACCT.TRAN_PERM          %Type;
TYPE T_REL_NATURE              IS TABLE OF TBLCUSTCHANNELACCT.NATURE             %Type;
TYPE T_REL_RELATIONSHIPAUTH_ID IS TABLE OF TBLCUSTCHANNELACCT.RELATIONSHIPAUTH_ID%Type;
TYPE T_REL_PRODUCTID           IS TABLE OF TBLCUSTCHANNELACCT.PRODUCTID          %Type;

--for debit card updation
--FOR DEBIT CARD
TYPE t_cust_id IS TABLE OF TBLDEBITCARD.CUSTOMERID%TYPE;
TYPE t_card_number IS TABLE OF TBLDEBITCARD.CARDNUMBER%TYPE;
TYPE t_expiry_date IS TABLE OF TBLDEBITCARD.EXPIRYDATE%TYPE;
TYPE t_name_on_card IS TABLE OF TBLDEBITCARD.CARDNAME%TYPE;
TYPE t_card_status IS TABLE OF TBLDEBITCARD.CARDSTATUS%TYPE;
TYPE t_branch_code IS TABLE OF TBLDEBITCARD.BRANCHCODE%TYPE;
TYPE t_group_id IS TABLE OF TBLDEBITCARD.GROUP_ID%TYPE;
TYPE t_relationship_id IS TABLE OF TBLDEBITCARD.RELATIONSHIP_ID%TYPE;


--For currency updation
TYPE t_is_atm_curr IS TABLE OF TBLCFGCURRENCY.IS_ATM_CURR%TYPE;
TYPE t_modification_date IS TABLE OF TBLCFGCURRENCY.MODIFICATION_DATE%TYPE;
TYPE t_buy_rate_xfer IS TABLE OF TBLCFGCURRENCY.BUY_RATE_XFER%TYPE;
TYPE t_sell_rate_xfer IS TABLE OF TBLCFGCURRENCY.SELL_RATE_XFER%TYPE;
TYPE t_code IS TABLE OF TBLCFGCURRENCY.CODE%TYPE;
TYPE t_description IS TABLE OF TBLCFGCURRENCY.DESCRIPTION%TYPE;
TYPE t_symbol IS TABLE OF TBLCFGCURRENCY.SYMBOL%TYPE;
TYPE t_decimals IS TABLE OF TBLCFGCURRENCY.DECIMALS%TYPE;
TYPE t_buy_rate_cash IS TABLE OF TBLCFGCURRENCY.BUY_RATE_CASH%TYPE;
TYPE t_sell_rate_cash IS TABLE OF TBLCFGCURRENCY.SELL_RATE_CASH%TYPE;
TYPE t_is_base_curr IS TABLE OF TBLCFGCURRENCY.IS_BASE_CURR%TYPE;


--FOR TBLCORPORATE
TYPE T_CORP_CORPORATEID      IS TABLE OF TBLCORPORATE.CORPORATE_ID%TYPE;
TYPE T_CORP_NAME             IS TABLE OF TBLCORPORATE.NAME%TYPE;
TYPE T_CORP_STATUS           IS TABLE OF TBLCORPORATE.STATUS%TYPE;

--OSAMA SIRAJ SIDDIQUI
---*** FOR CUSTOMERBENEFICIARY UPDATION
---------------------------------------------------------------------------------------------
TYPE T_BENEFICIARY_ID                   IS TABLE OF TBLCUSTOMERBENEFICIARY.BENEFICIARYID%TYPE;
TYPE T_BENEFICIARY_SHORT_NAME           IS TABLE OF TBLCUSTOMERBENEFICIARY.SHORT_NAME%TYPE;
TYPE T_CUSTOMER_ID                      IS TABLE OF TBLCUSTOMERBENEFICIARY.CUSTOMER_ID%TYPE;
-- BY SR - Feb 22 - 2011 - Merged from ENBD
TYPE T_MOBILE_NUMBER                    IS TABLE OF TBLCUSTOMERBENEFICIARY.MOBILE_NUMBER%TYPE;
TYPE T_FIRST_NAME                       IS TABLE OF TBLCUSTOMERBENEFICIARY.FIRST_NAME%TYPE;
TYPE T_LAST_NAME                        IS TABLE OF TBLCUSTOMERBENEFICIARY.LAST_NAME%TYPE;
TYPE T_BENEFICIARY_EMAIL                IS TABLE OF TBLCUSTOMERBENEFICIARY.EMAIL_ADDRESS%TYPE;
TYPE T_BENEFICIARY_PHONENUMBER          IS TABLE OF TBLCUSTOMERBENEFICIARY.TELEPHONE_NUMBER%TYPE;
TYPE T_BENEFICIARY_ADDRESS              IS TABLE OF TBLCUSTOMERBENEFICIARY.MAILING_ADDRESS%TYPE;
TYPE T_BENEFICIARY_BANKNAME             IS TABLE OF TBLCUSTOMERBENEFICIARY.BANK_NAME%TYPE;
TYPE T_BENEFICIARY_BANK_ADDRESS         IS TABLE OF TBLCUSTOMERBENEFICIARY.BANK_ADDRESS%TYPE;
TYPE T_BENEFICIARY_ACCOUNTNUMBER        IS TABLE OF TBLCUSTOMERBENEFICIARY.ACCOUNT_NUMBER%TYPE;
TYPE T_BENEFICIARY_SWIFT_CODE           IS TABLE OF TBLCUSTOMERBENEFICIARY.SWIFT_CODE%TYPE;
TYPE T_BENEFICIARY_COUNTRY_CODE         IS TABLE OF TBLCUSTOMERBENEFICIARY.COUNTRY_CODE%TYPE;
TYPE T_BENEFICIARY_COUNTRY_CUR_CODE     IS TABLE OF TBLCUSTOMERBENEFICIARY.COUNTRY_CURRENCY_CODE%TYPE;
--Type for TBLCFGLIMIT
TYPE T_LIMIT_AMOUNT         IS TABLE OF tblcfglimitamount.amount%TYPE;
TYPE T_CYCLE_LENGTH         IS TABLE OF tblcfglimitamount.cycle_length%TYPE;
TYPE T_CYCLE_BEGIN_DATE         IS TABLE OF tblremainingaccountlimit.CYCLE_BEGIN_DATE%TYPE;

PROCEDURE spUpdateCLIBRevAccountBalance
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spUpdateCLIBFixAccountBalance
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

-- ENBD MERGED FARAZ---------------------------------------------------------------------------------------------

function fnCallspCardStatusUpdate(
 inRelationship_ID IN VARCHAR2,
    inCARDSTATUS      IN VARCHAR2,
    inOLDCARDSTATUS   IN VARCHAR2,
    inRelauthId   IN VARCHAR2
)return Number;

/******************************* DATA INSERTION SP's *************************************/

PROCEDURE spAddAAEX
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);
PROCEDURE spUpdateCustomerBeneficiary
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);
PROCEDURE spDeleteCustomerBeneficiary
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);
PROCEDURE spInsertCustomer
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spUpdateCustomer
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spInsertAccount
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spUpdateAccount
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spInsertRelation
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spUpdateRelation
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spInsertCard
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spUpdateCard
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE sprelationshipauthAdd
(
  inPIN  IN VARCHAR2,
  inMAXRETRIES  IN VARCHAR2,
  inREMRETRIES  IN VARCHAR2,
  inSTATUS  IN VARCHAR2,
  inPIN_GEN_DATE  IN VARCHAR2,
  outRetVal  OUT varchar2
);


PROCEDURE spInsertCustomerDetails
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spUpdateCustomerDetails
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spCustomerProductAdd
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);

PROCEDURE spInsertLimit
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spUpdateLimit
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spInsertCurrency
(
        outMsg OUT VARCHAR2,
        outRetVal  OUT NUMBER
);

PROCEDURE spUpdateCurrency
(
        outMsg OUT VARCHAR2,
        outRetVal  OUT NUMBER
);

PROCEDURE spDeleteCustomer
(
        outMsg OUT VARCHAR2,
        outRetVal  OUT NUMBER
);

PROCEDURE spDeleteAccount
(
        outMsg OUT VARCHAR2,
        outRetVal  OUT NUMBER
);

PROCEDURE spDeleteCard
(
        outMsg OUT VARCHAR2,
        outRetVal  OUT NUMBER
);

PROCEDURE spDeleteRelation
(
        outMsg OUT VARCHAR2,
        outRetVal  OUT NUMBER
);

PROCEDURE spInsertAccountLimit
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spInsertCardLimit
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spInsertProductionCycle
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spInsertCustomerLimit
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spInsertRelAuth
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

/*
***************************************************************************
Created By  : Fariha Akhtar
Dated       : 26-Oct-2010
Description : To update PIN and PIN_GEN_DATE in tblrelationshipauth from
              tblimptmppinoffset

***************************************************************************
S#     Who           Date          Change Description
***************************************************************************

***************************************************************************
*/

PROCEDURE spUpdateRelAuth
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spInsertCorporate
(
        inXML IN CLOB,
        outMsg OUT VARCHAR2,
        outRetVal  OUT NUMBER
);


PROCEDURE spUpdateCorporate
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spUpdateAccountBalance
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);


PROCEDURE spInsertALFromMultiLO
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spInsertCardForcePinGeneration
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

/*
***************************************************************************
Created By  : Salman Aziz
Dated        : 06-April-2010
Description :  Insert Rows in tblcustomerbeneficiary from tblimptmpcustbeneficiary

***************************************************************************
S#  Who    Date    Change Description
***************************************************************************

***************************************************************************
*/
PROCEDURE spInsertCustomerBeneficiary
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);
PROCEDURE spUpdateALFromMultiLO
(
        outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
) ;

/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIILOG

***************************************************************************
S#  Who    Date    Change Description
***************************************************************************

***************************************************************************
*/
PROCEDURE spInsertBASEIILOG
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);

/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIILOG

***************************************************************************
S#  Who    Date    Change Description
***************************************************************************

***************************************************************************
*/
PROCEDURE spInsertBASEIILOG01
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);

/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIILOG

***************************************************************************
S#  Who    Date    Change Description
***************************************************************************

***************************************************************************
*/
PROCEDURE spInsertBASEIILOG05
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);

--<Add Author='Tabish Habib' Date='14/03/2013' Comments='Visa Mandate 2013'>
PROCEDURE spInsertBASEIILOG03
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);
--</Add>



/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIILOG

***************************************************************************
S#  Who    Date    Change Description
***************************************************************************

***************************************************************************
*/
PROCEDURE spInsertBASEIILOG07
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);


/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIILOG

***************************************************************************
S#  Who    Date    Change Description
***************************************************************************

***************************************************************************
*/
PROCEDURE spInsertBASEIICREDITLOG
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);


/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIIFEECOLLECTION

***************************************************************************
S#  Who    Date    Change Description
***************************************************************************

***************************************************************************
*/
PROCEDURE spInsertBASEIIFEECOLL
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);


/*
***************************************************************************
Created By  : Rabia Masroor
Dated        : 07-July-2010
Description : Insert Rows in TBLRELATIONSHIPCHARGES

***************************************************************************
S#  Who    Date    Change Description
***************************************************************************

***************************************************************************
*/
PROCEDURE spInsertRelCharges
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);

PROCEDURE spInsertOberthurImport
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

/*
***************************************************************************
Created By  : Fariha Akhtar
Dated       : 26-Oct-2010
Description : To update PIN and PIN_GEN_DATE in tblrelationshipauth from
              tblimptmppinoffset

***************************************************************************
S#     Who           Date          Change Description
***************************************************************************

***************************************************************************
*/
PROCEDURE spUpdatePin
(

    outMsg OUT VARCHAR2,
    outRetVal  OUT NUMBER
);

PROCEDURE spUpdateHBLWatan
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);


PROCEDURE spUpdateHBLTCS
(
      outMsg OUT VARCHAR2,
      outRetVal  OUT NUMBER
);

PROCEDURE SPINSERTIMD
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

PROCEDURE spUpdateMucodecAccountBalance
(
  outMsg OUT VARCHAR2,
  outRetVal  OUT NUMBER
);

--Tabish Habib | CUP IMD DataCopy | Friday, December 9
/*procedure spPopulateCUPIMD(
  inFormatID varchar2
);*/

PROCEDURE spUpdateDeliveryStatus
(
  outMsg OUT VARCHAR2,
  OUTRETVAL  OUT NUMBER
);

PROCEDURE spInsertCustomerDet
(
  outMsg OUT VARCHAR2,
  OUTRETVAL  OUT NUMBER
);

PROCEDURE spInsertPreGenCardData
(
  outMsg OUT VARCHAR2,
  OUTRETVAL  OUT NUMBER
);
END UIPKGIMPORTINSERTION;
/


CREATE OR REPLACE PACKAGE BODY      "UIPKGIMPORTINSERTION"
AS
  --CLIB OSAMA
  PROCEDURE spUpdateCLIBRevAccountBalance(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inLIMIT_AMOUNT T_LIMIT_AMOUNT          := T_LIMIT_AMOUNT();
    inCYCLE_LENGTH T_CYCLE_LENGTH          := T_CYCLE_LENGTH();
    inACCOUNT_ID T_ACCT_ACCOUNT_ID         := T_ACCT_ACCOUNT_ID();
    in_CYCLE_BEGIN_DATE T_CYCLE_BEGIN_DATE := T_CYCLE_BEGIN_DATE();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    /* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
    SELECT account_balance.accountid ,
    account_balance.limit ,
    account_balance.cycle_length ,
    ACCOUNT_BALANCE.CYCLE_BEGIN_DATE bulk collect
    INTO inACCOUNT_ID ,
    inLIMIT_AMOUNT ,
    inCYCLE_LENGTH ,
    in_CYCLE_BEGIN_DATE
    FROM TBLIMPCLIB_TMPACCOUNT_BALANCE ACCOUNT_BALANCE
    WHERE ACCOUNT_BALANCE.ACTIONFLAG = '02'
    AND ACCOUNT_BALANCE.FAILED      IS NULL
    AND ACCOUNT_BALANCE.limit_type   ='R'; */
    --------------------------------------------------------------------------------
    /*
    FORALL i in 1..inACCOUNT_ID.COUNT
    --tblcfglimitamount
    UPDATE tblcfglimitamount
    SET
    amount            = inLIMIT_AMOUNT           (i),
    cycle_length      = inCYCLE_LENGTH           (i)
    WHERE
    (tblcfglimitamount.amount_id)
    in
    (
    select tblremainingaccountlimit.amount_id from tblremainingaccountlimit
    inner join tblcfglimit
    on tblcfglimit.AMOUNT_ID=tblremainingaccountlimit.AMOUNT_ID
    where ACCOUNT_ID=inACCOUNT_ID(i)
    and TRAN_CODE='01' and CHANNEL_ID='0001'
    );
    */
    --------------------------------------------------------------------------------
    FOR i IN 1..inACCOUNT_ID.COUNT
    LOOP
      UPDATE tblcfglimitamount
      SET amount                           = inLIMIT_AMOUNT (i),
        cycle_length                       = inCYCLE_LENGTH (i)
      WHERE (tblcfglimitamount.amount_id) IN
        (SELECT amount_id
        FROM tblremainingaccountlimit
        INNER JOIN tblindlimitinfo
        ON tblremainingaccountlimit.AMOUNT_ID    =tblindlimitinfo.LIMIT_INFO_ID
        WHERE tblremainingaccountlimit.ACCOUNT_ID=inACCOUNT_ID(i)
        AND TRAN_CODE                            ='01'
        AND CHANNEL_ID                           ='0001'
        );
      --tblremainingaccountlimit
      -- FORALL i in 1..inACCOUNT_ID.COUNT
      UPDATE tblremainingaccountlimit
      SET CYCLE_BEGIN_DATE=in_CYCLE_BEGIN_DATE(i)
      WHERE ACCOUNT_ID    =inACCOUNT_ID(i);
      --outRetVal := SQL%ROWCOUNT;
    END LOOP;
  END spUpdateCLIBRevAccountBalance;
--CLIB OSAMA
  PROCEDURE spUpdateCLIBFixAccountBalance(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inTITLE T_ACCT_TITLE                        := T_ACCT_TITLE();
    inSTATUS T_ACCT_STATUS                      := T_ACCT_STATUS();
    inACTUAL_BALANCE T_ACCT_ACTUAL_BALANCE      := T_ACCT_ACTUAL_BALANCE();
    inACCOUNT_ID T_ACCT_ACCOUNT_ID              := T_ACCT_ACCOUNT_ID();
    inACCOUNT_TYPE T_ACCT_ACCOUNT_TYPE          := T_ACCT_ACCOUNT_TYPE();
    inACCOUNT_CURRENCY T_ACCT_ACCOUNT_CURRENCY  := T_ACCT_ACCOUNT_CURRENCY();
    inLAST_UPDATED T_ACCT_LAST_UPDATED          := T_ACCT_LAST_UPDATED();
    inBRANCHID T_ACCT_BRANCHID                  := T_ACCT_BRANCHID();
    inAVAILABLE_BALANCE T_ACCT_AVAILABLE_BALANCE:= T_ACCT_AVAILABLE_BALANCE();
    inOLDACCOUNT_ID T_ACCT_OLDACCOUNT_ID        := T_ACCT_OLDACCOUNT_ID();
    inINTERNAL_BRANCH_ID T_INTERNAL_BRANCH_ID   := T_INTERNAL_BRANCH_ID();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    /* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
    SELECT ACCOUNT_BALANCE."STATUS" ,
    ACCOUNT_BALANCE."ACCOUNTID" , --ACCOUNT_BALANCE."ACCOUNT_ID"       ,
    ACCOUNT_BALANCE."TYPE" ,      --ACCOUNT_BALANCE."ACCOUNT_TYPE"     ,
    ACCOUNT_BALANCE."CURRENCY" ,  --ACCOUNT_BALANCE."ACCOUNT_CURRENCY" ,
    ACCOUNT_BALANCE."ACTUAL_BALANCE" ,
    ACCOUNT_BALANCE."AVAILABLE_BALANCE" bulk collect
    INTO inSTATUS ,
    inACCOUNT_ID ,
    inACCOUNT_TYPE ,
    inACCOUNT_CURRENCY ,
    inACTUAL_BALANCE ,
    inAVAILABLE_BALANCE
    FROM TBLIMPCLIB_TMPACCOUNT_BALANCE ACCOUNT_BALANCE
    WHERE ACCOUNT_BALANCE.ACTIONFLAG = '02'
    AND ACCOUNT_BALANCE.FAILED      IS NULL
    AND ACCOUNT_BALANCE.limit_type   ='F'; */
    FORALL i IN 1..inACCOUNT_ID.COUNT
    UPDATE TBLACCOUNT
    SET STATUS                    = inSTATUS (i),
      ACTUAL_BALANCE              = TO_CHAR( TO_NUMBER(inACTUAL_BALANCE (i)) - NVL(TO_NUMBER(amt_tran_sum),0) ),
      LAST_UPDATED                = TO_CHAR(sysdate,'yyyymmdd'),
      AVAILABLE_BALANCE           = TO_CHAR( TO_NUMBER(inAVAILABLE_BALANCE(i)) - NVL(TO_NUMBER(amt_tran_sum),0) ),
      is_settled                  = '1',
      amt_tran_sum                = '0'
    WHERE (TBLACCOUNT.ACCOUNT_ID) = (inACCOUNT_ID(i)) -- trim removed due to performance as all balances comes at once, it is transformed in datacopy
    AND ACCOUNT_TYPE              = inACCOUNT_TYPE (i)
    AND ACCOUNT_CURRENCY          = inACCOUNT_CURRENCY (i);
    outRetVal                    := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spUpdateCLIBFixAccountBalance;
-- ENBD MERGED FARAZ
  FUNCTION fnCallspCardStatusUpdate(
      inRelationship_ID IN VARCHAR2,
      inCARDSTATUS      IN VARCHAR2,
      inOLDCARDSTATUS   IN VARCHAR2,
      inRelauthId       IN VARCHAR2 )
    RETURN NUMBER
  IS
    outRetVal NUMBER;
  BEGIN
    INSERT
    INTO tblactivitylogs
      (
        ACTIVITYLOGID,
        REL_ID,
        ACTIVITIYCODE,
        ALERTSENT,
        STATUS,
        CHANNELID,
        AGENTID,
        ACTIVITYDATETIME,
        OLD_STATUS
      )
    SELECT SEQ_ACTIVITYLOG.nextval,
      inRelationship_ID,
      '05',
      '',
      inCARDSTATUS,
      '0001',
      'Offline',
      TO_CHAR(sysdate,'yyyyMMddHH24MISS'),
      inOLDCARDSTATUS
    FROM dual;
    COMMIT;
    UPDATE tblrelationshipauth
    SET status   = inCARDSTATUS,
      reasoncode = inCARDSTATUS
      ||'00'
    WHERE relationshipauth_id=inRelauthId;
    COMMIT;
    DELETE FROM tblproduction WHERE relationship_Id = inRelationship_ID;
    COMMIT;
    RETURN 1;
  END fnCallspCardStatusUpdate;
  PROCEDURE spAddAAEX(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    ---------------------------------SCLABOR--------------------------------------
    INSERT
    INTO tblsclabor
      (
        LABORID,
        CORPORATEID,
        FIRSTNAME,
        LASTNAME,
        NATIONALITY,
        MOBILENUMBER,
        BANKNAME,
        BANKACCOUTNO,
        SALARYCURRENCY,
        ACTIONFLAG,
        PROCESSFLAG,
        SEQUENCE
      )
    SELECT DISTINCT(labor.labor_id),
      labor.corporate_id,
      labor.firstname,
      labor.lastname,
      labor.nationality,
      labor.mobilenumber,
      labor.bankname,
      labor.bankaccountno,
      labor.salarycurrency,
      labor.actionflag,
      labor.processflag,
      labor.sequence
    FROM tblimplogexplabor labor
    WHERE labor.processflag = '0';
    ---------------------------------SCCARD---------------------------------------
    INSERT
    INTO TBLSCCARD
      (
        LABORID,
        FOLABOURID,
        CARDNUMBER,
        ACTIONFLAG,
        PROCESSFLAG,
        SEQUENCE
      )
    SELECT DISTINCT(labor.labor_id),
      labor.folabourid,
      (SELECT NVL(cardnumber,' ')
      FROM tblimptmpcard
      WHERE tblimptmpcard.seqno=labor.sequence
      ),
      labor.actionflag,
      labor.processflag,
      labor.sequence
    FROM tblimplogexplabor labor
    WHERE labor.processflag = '0';
    -------------------------------SCACCOUNT--------------------------------------
    INSERT
    INTO TBLSCACCOUNTS
      (
        LABORID,
        CORPORATEID,
        ACCOUNTTITLE,
        ACCOUNTNO,
        ACCOUNTTYPE,
        ACCOUNTCURRENCY,
        ACCOUNTSTATUS,
        ACTIONFLAG,
        PROCESSFLAG,
        SEQUENCE,
        FOLABOURID
      )
    SELECT DISTINCT(labor.labor_id),
      labor.corporate_id,
      (SELECT NVL(tblimptmpaccount.title,' ')
      FROM tblimptmpaccount
      WHERE tblimptmpaccount.sequence=labor.sequence
      ),
      (SELECT NVL(TBLIMPTMPACCOUNT.ACCOUNT_ID,' ')
      FROM tblimptmpaccount
      WHERE tblimptmpaccount.sequence=labor.sequence
      ),
      (SELECT NVL(tblimptmpaccount.account_type,' ')
      FROM tblimptmpaccount
      WHERE tblimptmpaccount.sequence=labor.sequence
      ),
      (SELECT NVL(tblimptmpaccount.account_currency,' ')
      FROM tblimptmpaccount
      WHERE tblimptmpaccount.sequence=labor.sequence
      ),
      (SELECT NVL(tblimptmpaccount.status,' ')
      FROM tblimptmpaccount
      WHERE tblimptmpaccount.sequence=labor.sequence
      ),
      labor.actionflag,
      labor.processflag,
      labor.sequence,
      labor.folabourid
    FROM tblimplogexplabor labor
    WHERE labor.processflag = '0';
    --------------------------------TBLEXPLABOR-------------------------------------
    UPDATE tblimplogexplabor
    SET processflag   ='1',
      log_process_code='01'
    WHERE processflag = '0';
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    /* UPDATE tblexplabor
    SET processflag  ='1'
    WHERE processflag='0';*/
    --commit;  -- BY SR - Feb 22 - 2011 - Merged from ENBD
    outRetVal := SQL%ROWCOUNT;
    --commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    --commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      ---if error occur then update the process flag
      UPDATE tblimplogexplabor
      SET processflag   ='2',
        log_process_code='01'
      WHERE processflag = '0';
      -- BY SR - Feb 22 - 2011 - Merged from ENBD
      COMMIT;
      COMMIT;
      COMMIT;
      outRetVal := 0;
    END;
    --Adding rows from Log Table to Host Table[tblafexlabor]
  END spAddAAEX;
  PROCEDURE spInsertCustomer(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLCUSTOMER
      (
        CUSTOMERID,
        STATUS,
        CNIC,
        NIC,
        DATEOFBIRTH,
        HOMEPHONE,
        MOBILENUMBER,
        OFFICEPHONE,
        FATHERSNAME,
        MOTHERSNAME,
        EMAIL,
        COMPANY,
        CUSTOMERTYPE,
        CITY,
        COUNTRY,
        HOMEADDRESS1,
        HOMEADDRESS2,
        HOMEADDRESS3,
        HOMEADDRESS4,
        HOMEADDRESS5,
        OFFICEADDRESS1,
        OFFICEADDRESS2,
        OFFICEADDRESS3,
        OFFICEADDRESS4,
        OFFICEADDRESS5,
        DESIGNATION,
        IMD,
        FIRSTNAME,
        MIDDLENAME,
        LASTNAME,
        BILLINGFLAG,
        ACTIVIATIONDATE,
        LASTUPDATEDDATE,
        REGISTRATIONDATE,
        BRANCH_CODE,
        PASSPORT_NO,
        OLDCUSTOMER_ID,
        TRANSACTIONALERTS,
        CHANNELALERTS,
        TRANSACTIONINSURANCE,
        INTERNAL_BRANCH_ID,
        GENDER,
        FAXNUMBER,
        HOMEPOSTALCODE,
        OFFICEPOSTALCODE,
        PLACEOFBIRTH,
        NATIONALITY,
        OCCUPATION,
        PROVINCE,
        MARITALSTATUS,
        HOSTCUSTOMERID
      )
    SELECT DISTINCT CUSTOMER.CUSTOMERID ,
      CUSTOMER.STATUS ,
      CUSTOMER.CNIC ,
      CUSTOMER.NIC ,
      CUSTOMER.DATEOFBIRTH ,
      CUSTOMER.HOMEPHONE ,
      CUSTOMER.MOBILENUMBER ,
      CUSTOMER.OFFICEPHONE ,
      CUSTOMER.FATHERSNAME ,
      CUSTOMER.MOTHERSNAME ,
      CUSTOMER.EMAIL ,
      CUSTOMER.COMPANY ,
      CUSTOMER.CUSTOMERTYPE ,
      CUSTOMER.CITY ,
      CUSTOMER.COUNTRY ,
      CUSTOMER.HOMEADDRESS1 ,
      CUSTOMER.HOMEADDRESS2 ,
      CUSTOMER.HOMEADDRESS3 ,
      CUSTOMER.HOMEADDRESS4 ,
      CUSTOMER.HOMEADDRESS5 ,
      CUSTOMER.OFFICEADDRESS1 ,
      CUSTOMER.OFFICEADDRESS2 ,
      CUSTOMER.OFFICEADDRESS3 ,
      CUSTOMER.OFFICEADDRESS4 ,
      CUSTOMER.OFFICEADDRESS5 ,
      CUSTOMER.DESIGNATION ,
      CUSTOMER.IMD ,
      CUSTOMER.FIRSTNAME ,
      CUSTOMER.MIDDLENAME ,
      CUSTOMER.LASTNAME ,
      CUSTOMER.BILLINGFLAG ,
      -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --CUSTOMER.ACTIVIATIONDATE  ,
      CASE
        WHEN CUSTOMER.ACTIVIATIONDATE IS NULL
        THEN TO_CHAR(sysdate,'yyyymmdd')
        ELSE CUSTOMER.ACTIVIATIONDATE
      END,
      CASE
        WHEN CUSTOMER.LASTUPDATEDDATE IS NULL
        THEN TO_CHAR(sysdate,'yyyymmdd')
        ELSE CUSTOMER.LASTUPDATEDDATE
      END,
      CASE
        WHEN CUSTOMER.REGISTRATIONDATE IS NULL
        THEN TO_CHAR(sysdate,'yyyymmdd')
        ELSE CUSTOMER.REGISTRATIONDATE
      END,
      CUSTOMER.BRANCH_CODE ,
      CUSTOMER.PASSPORT_NO ,
      CUSTOMER.OLDCUSTOMER_ID ,
      CUSTOMER.TRANSACTIONALERTS,
      CUSTOMER.CHANNELALERTS ,
      CUSTOMER.TRANSACTIONINSURANCE,
      CUSTOMER.INTERNAL_BRANCH_ID,
      CUSTOMER.GENDER ,
      CUSTOMER.FAXNUMBER ,
      CUSTOMER.HOMEPOSTALCODE ,
      CUSTOMER.OFFICEPOSTALCODE ,
      CUSTOMER.PLACEOFBIRTH ,
      CUSTOMER.NATIONALITY ,
      CUSTOMER.OCCUPATION ,
      CUSTOMER.PROVINCE ,
      CUSTOMER.MARITALSTATUS ,
      CUSTOMER.HOSTCUSTOMERID
    FROM tblimptmpcustomer CUSTOMER
    WHERE CUSTOMER.ACTIONFLAG = '01'
    AND CUSTOMER.FAILED      IS NULL ;
    outRetVal                := SQL%ROWCOUNT;
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    COMMIT;
    ----commit;
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      UPDATE tblimptmpcustomer
      SET tblimptmpcustomer.Failed = '1' ,
        err_code                   = errorCode,
        err_description            = errorDesc;
      COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --
      outRetVal := 0;
    END;
  END spInsertCustomer;
  PROCEDURE spUpdateCustomer(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inCUSTOMERID T_CUST_CUSTOMERID                    := T_CUST_CUSTOMERID();
    inSTATUS T_CUST_STATUS                            := T_CUST_STATUS();
    inCNIC T_CUST_CNIC                                := T_CUST_CNIC();
    inNIC T_CUST_NIC                                  := T_CUST_NIC();
    inDATEOFBIRTH T_CUST_DATEOFBIRTH                  := T_CUST_DATEOFBIRTH();
    inHOMEPHONE T_CUST_HOMEPHONE                      := T_CUST_HOMEPHONE();
    inMOBILENUMBER T_CUST_MOBILENUMBER                := T_CUST_MOBILENUMBER();
    inOFFICEPHONE T_CUST_OFFICEPHONE                  := T_CUST_OFFICEPHONE();
    inFATHERSNAME T_CUST_FATHERSNAME                  := T_CUST_FATHERSNAME();
    inMOTHERSNAME T_CUST_MOTHERSNAME                  := T_CUST_MOTHERSNAME();
    inEMAIL T_CUST_EMAIL                              := T_CUST_EMAIL();
    inCOMPANY T_CUST_COMPANY                          := T_CUST_COMPANY();
    inCUSTOMERTYPE T_CUST_CUSTOMERTYPE                := T_CUST_CUSTOMERTYPE();
    inCITY T_CUST_CITY                                := T_CUST_CITY();
    inCOUNTRY T_CUST_COUNTRY                          := T_CUST_COUNTRY();
    inHOMEADDRESS1 T_CUST_HOMEADDRESS1                := T_CUST_HOMEADDRESS1();
    inHOMEADDRESS2 T_CUST_HOMEADDRESS2                := T_CUST_HOMEADDRESS2();
    inHOMEADDRESS3 T_CUST_HOMEADDRESS3                := T_CUST_HOMEADDRESS3();
    inHOMEADDRESS4 T_CUST_HOMEADDRESS4                := T_CUST_HOMEADDRESS4();
    inHOMEADDRESS5 T_CUST_HOMEADDRESS5                := T_CUST_HOMEADDRESS5();
    inOFFICEADDRESS1 T_CUST_OFFICEADDRESS1            := T_CUST_OFFICEADDRESS1();
    inOFFICEADDRESS2 T_CUST_OFFICEADDRESS2            := T_CUST_OFFICEADDRESS2();
    inOFFICEADDRESS3 T_CUST_OFFICEADDRESS3            := T_CUST_OFFICEADDRESS3();
    inOFFICEADDRESS4 T_CUST_OFFICEADDRESS4            := T_CUST_OFFICEADDRESS4();
    inOFFICEADDRESS5 T_CUST_OFFICEADDRESS5            := T_CUST_OFFICEADDRESS5();
    inDESIGNATION T_CUST_DESIGNATION                  := T_CUST_DESIGNATION();
    inIMD T_CUST_IMD                                  := T_CUST_IMD();
    inFIRSTNAME T_CUST_FIRSTNAME                      := T_CUST_FIRSTNAME();
    inMIDDLENAME T_CUST_MIDDLENAME                    := T_CUST_MIDDLENAME();
    inLASTNAME T_CUST_LASTNAME                        := T_CUST_LASTNAME();
    inBILLINGFLAG T_CUST_BILLINGFLAG                  := T_CUST_BILLINGFLAG();
    inACTIVIATIONDATE T_CUST_ACTIVIATIONDATE          := T_CUST_ACTIVIATIONDATE();
    inLASTUPDATEDDATE T_CUST_LASTUPDATEDDATE          := T_CUST_LASTUPDATEDDATE();
    inREGISTRATIONDATE T_CUST_REGISTRATIONDATE        := T_CUST_REGISTRATIONDATE();
    inBRANCH_CODE T_CUST_BRANCH_CODE                  := T_CUST_BRANCH_CODE();
    inPASSPORT_NO T_CUST_PASSPORT_NO                  := T_CUST_PASSPORT_NO();
    inOLDCUSTOMER_ID T_CUST_OLDCUSTOMER_ID            := T_CUST_OLDCUSTOMER_ID();
    inTRANSACTIONALERTS T_CUST_TRANSACTIONALERTS      := T_CUST_TRANSACTIONALERTS();
    inCHANNELALERTS T_CUST_CHANNELALERTS              := T_CUST_CHANNELALERTS();
    inTRANSACTIONINSURANCE T_CUST_TRANSACTIONINSURANCE:=T_CUST_TRANSACTIONINSURANCE();
    inINTERNAL_BRANCH_ID T_INTERNAL_BRANCH_ID         := T_INTERNAL_BRANCH_ID();
    inGENDER T_GENDER                                 := T_GENDER();
    inFAXNUMBER T_FAXNUMBER                           := T_FAXNUMBER();
    inHOSTCUSTOMERID T_HOSTCUSTOMERID                 := T_HOSTCUSTOMERID();
    inOFFICEPOSTALCODE T_OFFICEPOSTALCODE             := T_OFFICEPOSTALCODE();
    inHOMEPOSTALCODE T_HOMEPOSTALCODE                 := T_HOMEPOSTALCODE();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    /*SELECT  CUSTOMER.CUSTOMERID       ,
    CUSTOMER.STATUS           ,
    CUSTOMER.CNIC             ,
    CUSTOMER.NIC              ,
    CUSTOMER.DATEOFBIRTH      ,
    CUSTOMER.HOMEPHONE        ,
    CUSTOMER.MOBILENUMBER     ,
    CUSTOMER.OFFICEPHONE      ,
    CUSTOMER.FATHERSNAME      ,
    CUSTOMER.MOTHERSNAME      ,
    CUSTOMER.EMAIL            ,
    CUSTOMER.COMPANY          ,
    CUSTOMER.CUSTOMERTYPE     ,
    CUSTOMER.CITY             ,
    CUSTOMER.COUNTRY          ,
    CUSTOMER.HOMEADDRESS1     ,
    CUSTOMER.HOMEADDRESS2     ,
    CUSTOMER.HOMEADDRESS3     ,
    CUSTOMER.HOMEADDRESS4     ,
    CUSTOMER.HOMEADDRESS5     ,
    CUSTOMER.OFFICEADDRESS1   ,
    CUSTOMER.OFFICEADDRESS2   ,
    CUSTOMER.OFFICEADDRESS3   ,
    CUSTOMER.OFFICEADDRESS4   ,
    CUSTOMER.OFFICEADDRESS5   ,
    CUSTOMER.DESIGNATION      ,
    CUSTOMER.IMD              ,
    CUSTOMER.FIRSTNAME        ,
    CUSTOMER.MIDDLENAME       ,
    CUSTOMER.LASTNAME         ,
    CUSTOMER.BILLINGFLAG      ,
    CUSTOMER.ACTIVIATIONDATE  ,
    CUSTOMER.LASTUPDATEDDATE  ,
    CUSTOMER.REGISTRATIONDATE ,
    CUSTOMER.BRANCH_CODE      ,
    CUSTOMER.PASSPORT_NO      ,
    CUSTOMER.OLDCUSTOMER_ID   ,
    CUSTOMER.TRANSACTIONALERTS,
    CUSTOMER.CHANNELALERTS    ,
    CUSTOMER.TRANSACTIONINSURANCE,
    CUSTOMER.INTERNAL_BRANCH_ID,
    CUSTOMER.GENDER,
    CUSTOMER.HOSTCUSTOMERID,
    CUSTOMER.FAXNUMBER,
    CUSTOMER.OFFICEPOSTALCODE,
    CUSTOMER.HOMEPOSTALCODE
    bulk collect into
    inCUSTOMERID         ,
    inSTATUS             ,
    inCNIC               ,
    inNIC                ,
    inDATEOFBIRTH        ,
    inHOMEPHONE          ,
    inMOBILENUMBER       ,
    inOFFICEPHONE        ,
    inFATHERSNAME        ,
    inMOTHERSNAME        ,
    inEMAIL              ,
    inCOMPANY            ,
    inCUSTOMERTYPE       ,
    inCITY               ,
    inCOUNTRY            ,
    inHOMEADDRESS1       ,
    inHOMEADDRESS2       ,
    inHOMEADDRESS3       ,
    inHOMEADDRESS4       ,
    inHOMEADDRESS5       ,
    inOFFICEADDRESS1     ,
    inOFFICEADDRESS2     ,
    inOFFICEADDRESS3     ,
    inOFFICEADDRESS4     ,
    inOFFICEADDRESS5     ,
    inDESIGNATION        ,
    inIMD                ,
    inFIRSTNAME          ,
    inMIDDLENAME         ,
    inLASTNAME           ,
    inBILLINGFLAG        ,
    inACTIVIATIONDATE    ,
    inLASTUPDATEDDATE    ,
    inREGISTRATIONDATE   ,
    inBRANCH_CODE        ,
    inPASSPORT_NO        ,
    inOLDCUSTOMER_ID     ,
    inTRANSACTIONALERTS  ,
    inCHANNELALERTS      ,
    inTRANSACTIONINSURANCE,
    inINTERNAL_BRANCH_ID,
    inGENDER,
    inHOSTCUSTOMERID,
    inFAXNUMBER,
    inOFFICEPOSTALCODE,
    inHOMEPOSTALCODE
    from tblimptmpcustomer CUSTOMER
    WHERE CUSTOMER.ACTIONFLAG = '02'
    AND CUSTOMER.FAILED IS NULL;
    --Set Transaction Read Write;
    outRetVal := inCUSTOMERID.count;
    FORALL i in inCUSTOMERID.FIRST..inCUSTOMERID.LAST
    UPDATE TBLCUSTOMER SET
    STATUS =                        inSTATUS(i),
    CNIC =                           inCNIC(i),
    NIC =                            inNIC(i),
    DATEOFBIRTH =                   inDATEOFBIRTH(i),
    HOMEPHONE =                     inHOMEPHONE(i),
    MOBILENUMBER =                  inMOBILENUMBER(i),
    OFFICEPHONE =                   inOFFICEPHONE(i),
    FATHERSNAME =                   inFATHERSNAME(i),
    MOTHERSNAME =                   inMOTHERSNAME(i),
    EMAIL =                         inEMAIL(i),
    COMPANY =                       inCOMPANY(i),
    CUSTOMERTYPE =                  inCUSTOMERTYPE(i),
    CITY =                            inCity(i),
    COUNTRY =                       inCOUNTRY(i),
    HOMEADDRESS1 =                  inHOMEADDRESS1(i),
    HOMEADDRESS2 =                  inHOMEADDRESS2(i),
    HOMEADDRESS3 =                  inHOMEADDRESS3(i),
    HOMEADDRESS4 =                  inHOMEADDRESS4(i),
    HOMEADDRESS5 =                  inHOMEADDRESS5(i),
    OFFICEADDRESS1 =             inOFFICEADDRESS1(i),
    OFFICEADDRESS2 =             inOFFICEADDRESS2(i),
    OFFICEADDRESS3 =             inOFFICEADDRESS3(i),
    OFFICEADDRESS4 =             inOFFICEADDRESS4(i),
    OFFICEADDRESS5 =             inOFFICEADDRESS5(i),
    DESIGNATION =                   inDESIGNATION(i),
    IMD =                             inIMD(i),
    FIRSTNAME =                     inFIRSTNAME(i),
    MIDDLENAME =                    inMIDDLENAME(i),
    LASTNAME =                      inLASTNAME(i),
    BILLINGFLAG =                   inBILLINGFLAG(i),
    ACTIVIATIONDATE=            inACTIVIATIONDATE(i),
    LASTUPDATEDDATE =           inLASTUPDATEDDATE(i),
    REGISTRATIONDATE=          inREGISTRATIONDATE(i),
    BRANCH_CODE =                   inBRANCH_CODE(i),
    PASSPORT_NO =             inPASSPORT_NO(i),
    OLDCUSTOMER_ID =             inOLDCUSTOMER_ID(i),
    TRANSACTIONALERTS =       inTRANSACTIONALERTS(i),
    CHANNELALERTS =               inCHANNELALERTS(i),
    TRANSACTIONINSURANCE=  inTRANSACTIONINSURANCE(i),
    FAXNUMBER = inFAXNUMBER(i),
    GENDER = inGENDER(i),
    HOSTCUSTOMERID = inHOSTCUSTOMERID(i),
    OFFICEPOSTALCODE = inOFFICEPOSTALCODE(i),
    HOMEPOSTALCODE = inHOMEPOSTALCODE(i),
    INTERNAL_BRANCH_ID = inINTERNAL_BRANCH_ID(i)
    WHERE
    TRIM(TBLCUSTOMER.CUSTOMERID) = TRIM(inCUSTOMERID(i))
    ;
    */
    --Set Transaction Read Write;  -- BY SR - Feb 22 - 2011 - Merged from ENBD
    UPDATE TBLCUSTOMER CUST --fahad 27/08/2010 enhancement in customer bulk update
    SET
      (
        CUST.NIC ,
        CUST.DATEOFBIRTH ,
        CUST.HOMEPHONE ,
        CUST.MOBILENUMBER ,
        CUST.OFFICEPHONE ,
        CUST.FATHERSNAME ,
        CUST.MOTHERSNAME ,
        CUST.EMAIL ,
        CUST.COMPANY ,
        CUST.CUSTOMERTYPE ,
        CUST.CITY ,
        CUST.COUNTRY ,
        CUST.HOMEADDRESS1 ,
        CUST.HOMEADDRESS2 ,
        CUST.HOMEADDRESS3 ,
        CUST.HOMEADDRESS4 ,
        CUST.HOMEADDRESS5 ,
        CUST.OFFICEADDRESS1 ,
        CUST.OFFICEADDRESS2 ,
        CUST.OFFICEADDRESS3 ,
        CUST.OFFICEADDRESS4 ,
        CUST.OFFICEADDRESS5 ,
        CUST.DESIGNATION ,
        CUST.FIRSTNAME ,
        CUST.MIDDLENAME ,
        CUST.LASTNAME ,
        CUST.BILLINGFLAG ,
        CUST.ACTIVIATIONDATE ,
        CUST.LASTUPDATEDDATE ,
        CUST.REGISTRATIONDATE ,
        CUST.PASSPORT_NO ,
        CUST.FAXNUMBER ,
        CUST.GENDER ,
        CUST.HOMEPOSTALCODE
      )
      =
      (SELECT TMPCUST.NIC ,
        TMPCUST.DATEOFBIRTH ,
        TMPCUST.HOMEPHONE ,
        TMPCUST.MOBILENUMBER ,
        TMPCUST.OFFICEPHONE ,
        TMPCUST.FATHERSNAME ,
        TMPCUST.MOTHERSNAME ,
        TMPCUST.EMAIL ,
        TMPCUST.COMPANY ,
        --Added by Musfar
        NVL(TMPCUST.CUSTOMERTYPE,CUST.CUSTOMERTYPE) ,
        --Added by Musfar
        TMPCUST.CITY ,
        TMPCUST.COUNTRY ,
        TMPCUST.HOMEADDRESS1 ,
        TMPCUST.HOMEADDRESS2 ,
        TMPCUST.HOMEADDRESS3 ,
        TMPCUST.HOMEADDRESS4 ,
        TMPCUST.HOMEADDRESS5 ,
        TMPCUST.OFFICEADDRESS1 ,
        TMPCUST.OFFICEADDRESS2 ,
        TMPCUST.OFFICEADDRESS3 ,
        TMPCUST.OFFICEADDRESS4 ,
        TMPCUST.OFFICEADDRESS5 ,
        TMPCUST.DESIGNATION ,
        TMPCUST.FIRSTNAME ,
        TMPCUST.MIDDLENAME ,
        TMPCUST.LASTNAME ,
        TMPCUST.BILLINGFLAG ,
        TMPCUST.ACTIVIATIONDATE ,
        TMPCUST.LASTUPDATEDDATE ,
        TMPCUST.REGISTRATIONDATE ,
        TMPCUST.PASSPORT_NO ,
        TMPCUST.FAXNUMBER ,
        TMPCUST.GENDER ,
        TMPCUST.HOMEPOSTALCODE
      FROM tblimptmpcustomer TMPCUST
      WHERE TMPCUST.customerid = CUST.customerid
      AND TMPCUST.ACTIONFLAG   = '02'
      AND TMPCUST.FAILED      IS NULL
      AND rownum               = 1
      )
    WHERE CUST.customerid IN
      (SELECT customerid
      FROM tblimptmpcustomer
      WHERE ACTIONFLAG = '02'
      AND FAILED      IS NULL
      );
    /*
    ----------------MANAZIR for FARMERS CARD--------------------------
    UPDATE TBLCUSTOMER CUST --fahad 27/08/2010 enhancement in customer bulk update
    SET (CUST.NIC,
    CUST.DATEOFBIRTH,
    CUST.HOMEPHONE,
    CUST.MOBILENUMBER,
    CUST.OFFICEPHONE,
    CUST.FATHERSNAME,
    CUST.MOTHERSNAME,
    CUST.EMAIL,
    CUST.COMPANY,
    CUST.CUSTOMERTYPE,
    CUST.CITY,
    CUST.COUNTRY,
    CUST.HOMEADDRESS1,
    CUST.HOMEADDRESS2,
    CUST.HOMEADDRESS3,
    CUST.HOMEADDRESS4,
    CUST.HOMEADDRESS5,
    CUST.OFFICEADDRESS1,
    CUST.OFFICEADDRESS2,
    CUST.OFFICEADDRESS3,
    CUST.OFFICEADDRESS4,
    CUST.OFFICEADDRESS5,
    CUST.DESIGNATION,
    CUST.FIRSTNAME,
    CUST.MIDDLENAME,
    CUST.LASTNAME,
    CUST.BILLINGFLAG,
    CUST.ACTIVIATIONDATE,
    CUST.LASTUPDATEDDATE,
    CUST.REGISTRATIONDATE,
    CUST.PASSPORT_NO,
    CUST.FAXNUMBER,
    CUST.GENDER,
    CUST.HOMEPOSTALCODE,
    CUST.CNIC /*Added by Adil for Farmers card*/
    /*       ) =
    (SELECT TMPCUST.NIC,
    TMPCUST.DATEOFBIRTH,
    TMPCUST.HOMEPHONE,
    TMPCUST.MOBILENUMBER,
    TMPCUST.OFFICEPHONE,
    TMPCUST.FATHERSNAME,
    TMPCUST.MOTHERSNAME,
    TMPCUST.EMAIL,
    TMPCUST.COMPANY,
    --- COMMENTING BELOW
    */
    --Added by Musfar
    /*
    NVL(TMPCUST.CUSTOMERTYPE,CUST.CUSTOMERTYPE) ,
    -- TMPCUST.CUSTOMERTYPE,
    TMPCUST.CITY,
    TMPCUST.COUNTRY,
    TMPCUST.HOMEADDRESS1,
    TMPCUST.HOMEADDRESS2,
    TMPCUST.HOMEADDRESS3,
    TMPCUST.HOMEADDRESS4,
    TMPCUST.HOMEADDRESS5,
    TMPCUST.OFFICEADDRESS1,
    TMPCUST.OFFICEADDRESS2,
    TMPCUST.OFFICEADDRESS3,
    TMPCUST.OFFICEADDRESS4,
    TMPCUST.OFFICEADDRESS5,
    TMPCUST.DESIGNATION,
    TMPCUST.FIRSTNAME,
    TMPCUST.MIDDLENAME,
    TMPCUST.LASTNAME,
    TMPCUST.BILLINGFLAG,
    TMPCUST.ACTIVIATIONDATE,
    TMPCUST.LASTUPDATEDDATE,
    TMPCUST.REGISTRATIONDATE,
    TMPCUST.PASSPORT_NO,
    TMPCUST.FAXNUMBER,
    TMPCUST.GENDER,
    TMPCUST.HOMEPOSTALCODE,
    -- TMPCUST.Cnic /*Added by Adil for Farmers card*/
    --COMENTING BELOW
    /*
    (select tblimptmpcard_enhanced.primary_cnic from tblimptmpcard_enhanced where
    tblimptmpcard_enhanced.customerid = cust.customerid and rownum =1) CNIC
    FROM tblimptmpcustomer_enhanced TMPCUST
    WHERE TMPCUST.customerid = CUST.customerid
    AND TMPCUST.ACTIONFLAG = '02'
    AND TMPCUST.FAILED IS NULL
    AND rownum = 1)
    WHERE CUST.customerid IN (SELECT customerid
    FROM tblimptmpcard_enhanced
    WHERE
    tblimptmpcard_enhanced.customerid = CUST.Customerid
    AND ACTIONFLAG = '02'
    AND tblimptmpcard_enhanced.regeneration_type = '04'
    AND not exists (select 1 from tblcustomer where tblcustomer.cnic =
    tblimptmpcard_enhanced.primary_cnic)
    AND FAILED IS NULL);
    ----------------MANAZIR for FARMERS CARD--------------------------
    */
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    UPDATE TBLCUSTOMER CUST --fahad 27/08/2010 enhancement in customer bulk update
    SET
      (
        CUST.OFFICEPHONE ,
        CUST.OFFICEADDRESS1 ,
        CUST.OFFICEADDRESS2
      )
      =
      (SELECT TMPCUST.officephone ,
        TMPCUST.officeaddress1 ,
        TMPCUST.officeaddress2
      FROM tblimptmpcustomer TMPCUST
      WHERE TMPCUST.customerid = CUST.customerid
      AND TMPCUST.ACTIONFLAG   = '04'
      AND TMPCUST.FAILED      IS NULL
      AND rownum               = 1
      )
    WHERE CUST.customerid IN
      (SELECT customerid
      FROM tblimptmpcustomer
      WHERE ACTIONFLAG = '04'
      AND FAILED      IS NULL
      );
    outRetVal := SQL%ROWCOUNT;
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    COMMIT;
    ----commit;
  END spUpdateCustomer;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 12-Feb-2010
Description : To Insert CustomerDetails in tblcustomerdetail from
tblimptmpcustomerdetail
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spInsertCustomerDetails(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --  Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO tblcustomerdetail
      (
        CUSTOMERID,
        PARAMID,
        IDENTFIER,
        PARAMVALUE
      )
    SELECT DISTINCT CD.CUSTOMERID,
      CD.PARAMID,
      CD.IDENTFIER,
      CD.PARAMVALUE
    FROM tblimptmpcustomerdetail CD
    WHERE CD.ACTIONFLAG='01'
    AND CD.FAILED     IS NULL;
    outRetVal         := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    --  --commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    END;
  END spInsertCustomerDetails;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 12-Feb-2010
Description : To update CustomerDetails in tblcustomerdetail from
tblimptmpcustomerdetail
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
-- BY SR - Feb 22 - 2011 - Merged from ENBD
/*
PROCEDURE spUpdateCustomerDetails
(
outMsg OUT VARCHAR2,
outRetVal  OUT NUMBER
)
IS
BEGIN
outRetVal := 0;
outMsg := 'Executed Successfully';
Set Transaction Read Write;
UPDATE tblcustomerdetail tc
SET tc.PARAMVALUE=(select ta.PARAMVALUE from tblimptmpcustomerdetail ta where ta.CUSTOMERID=tc.CUSTOMERID and ta.PARAMID=tc.PARAMID and ta.IDENTFIER=tc.IDENTFIER and ta.ACTIONFLAG='02' and rownum<2)
WHERE EXISTS (SELECT 1 from tblimptmpcustomerdetail ta where ta.CUSTOMERID=tc.CUSTOMERID and ta.PARAMID=tc.PARAMID and ta.IDENTFIER=tc.IDENTFIER and ta.ACTIONFLAG='02');
outRetVal := SQL%ROWCOUNT;
commit;
commit;
Exception
WHEN OTHERS THEN
begin
outMsg := SQLCODE||' '|| SQLERRM;
rollback;
end;
END spUpdateCustomerDetails;
*/
  PROCEDURE spUpdateCustomerDetails(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    varRowCount NUMBER;
    varRowValue VARCHAR2(50);
  BEGIN
    outRetVal  := 0;
    outMsg     := 'Executed Successfully';
    varRowValue:='';
    SELECT COUNT(*)
    INTO varRowCount
    FROM tblcustomerdetail
    WHERE tblcustomerdetail.customerid =
      (SELECT tblimptmpcustomerdetail.customerid
      FROM tblimptmpcustomerdetail
      WHERE actionflag = '02'
      AND rownum       <2
      )
    AND tblcustomerdetail.paramid = '43';
    --Set Transaction Read Write;
    /*if(varRowCount>0)
    then
    select paramvalue into varRowValue
    from tblcustomerdetail
    where customerid = (select tblimptmpcustomerdetail.customerid from tblimptmpcustomerdetail where actionflag = '02' and rownum<2)
    and paramid = '43';
    end if;
    */
    --if VarRowValue is null OR VarRowValue =''
    --then
    UPDATE tblcustomerdetail tc
    SET tc.PARAMVALUE =
      (SELECT ta.PARAMVALUE
      FROM tblimptmpcustomerdetail ta
      WHERE ta.CUSTOMERID=tc.CUSTOMERID
      AND ta.PARAMID     =tc.PARAMID
      AND ta.IDENTFIER   =tc.IDENTFIER
      AND ta.ACTIONFLAG  ='02'
      AND rownum         <2
      )
    WHERE EXISTS
      (SELECT 1
      FROM tblimptmpcustomerdetail ta
      WHERE ta.CUSTOMERID=tc.CUSTOMERID
      AND ta.PARAMID     =tc.PARAMID
      AND ta.IDENTFIER   =tc.IDENTFIER
      AND ta.ACTIONFLAG  ='02'
      )
    AND tc.PARAMVALUE IS NULL ;
    --end if;
    --UPDATE tblcustomerdetail tc
    --SET tc.PARAMVALUE=(select ta.PARAMVALUE from tblimptmpcustomerdetail ta where ta.CUSTOMERID=tc.CUSTOMERID and ta.PARAMID=tc.PARAMID and ta.IDENTFIER=tc.IDENTFIER and ta.ACTIONFLAG='02' and rownum<2)
    --WHERE EXISTS (SELECT 1 from tblimptmpcustomerdetail ta where ta.CUSTOMERID=tc.CUSTOMERID and ta.PARAMID=tc.PARAMID and ta.IDENTFIER=tc.IDENTFIER and ta.ACTIONFLAG='02');
    outRetVal := SQL%ROWCOUNT;
    COMMIT;
    ----commit;
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
    END;
  END spUpdateCustomerDetails;
  PROCEDURE spInsertAccount(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLACCOUNT
      (
        TITLE,
        STATUS,
        ACTUAL_BALANCE,
        ACCOUNT_ID,
        ACCOUNT_TYPE,
        ACCOUNT_CURRENCY,
        LAST_UPDATED,
        BRANCHID,
        AVAILABLE_BALANCE,
        OLDACCOUNT_ID,
        INTERNAL_BRANCH_ID
      )
    SELECT DISTINCT ACCOUNT."TITLE",
      ACCOUNT."STATUS",
      ACCOUNT."ACTUAL_BALANCE",
      UIPKGACCOUNT.fnTrnasformAccount(ACCOUNT."INSTITUTIONID",ACCOUNT."ACCOUNT_ID"), -- RPAD(ACCOUNT."ACCOUNT_ID",20),
      ACCOUNT."ACCOUNT_TYPE",
      ACCOUNT."ACCOUNT_CURRENCY",
      ACCOUNT.LAST_UPDATED,
      ACCOUNT."BRANCHID",
      ACCOUNT."AVAILABLE_BALANCE",
      RPAD(ACCOUNT."OLDACCOUNT_ID",20),
      ACCOUNT."INTERNAL_BRANCH_ID"
    FROM tblimptmpaccount ACCOUNT
    WHERE ACCOUNT.ACTIONFLAG = '01'
    AND ACCOUNT.FAILED      IS NULL;
    outRetVal               := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    -- --commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spInsertAccount;
  PROCEDURE spUpdateAccount(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inTITLE T_ACCT_TITLE                        := T_ACCT_TITLE();
    inSTATUS T_ACCT_STATUS                      := T_ACCT_STATUS();
    inACTUAL_BALANCE T_ACCT_ACTUAL_BALANCE      := T_ACCT_ACTUAL_BALANCE();
    inACCOUNT_ID T_ACCT_ACCOUNT_ID              := T_ACCT_ACCOUNT_ID();
    inACCOUNT_TYPE T_ACCT_ACCOUNT_TYPE          := T_ACCT_ACCOUNT_TYPE();
    inACCOUNT_CURRENCY T_ACCT_ACCOUNT_CURRENCY  := T_ACCT_ACCOUNT_CURRENCY();
    inLAST_UPDATED T_ACCT_LAST_UPDATED          := T_ACCT_LAST_UPDATED();
    inBRANCHID T_ACCT_BRANCHID                  := T_ACCT_BRANCHID();
    inAVAILABLE_BALANCE T_ACCT_AVAILABLE_BALANCE:= T_ACCT_AVAILABLE_BALANCE();
    inOLDACCOUNT_ID T_ACCT_OLDACCOUNT_ID        := T_ACCT_OLDACCOUNT_ID();
    inINTERNAL_BRANCH_ID T_INTERNAL_BRANCH_ID   := T_INTERNAL_BRANCH_ID();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SELECT ACCOUNT."TITLE" ,
      ACCOUNT."STATUS" ,
      ACCOUNT."ACTUAL_BALANCE" ,
      UIPKGACCOUNT.fnTrnasformAccount(ACCOUNT."INSTITUTIONID",ACCOUNT."ACCOUNT_ID"), --fahad RPAD(ACCOUNT."ACCOUNT_ID",20),
      ACCOUNT."ACCOUNT_TYPE" ,
      ACCOUNT."ACCOUNT_CURRENCY" ,
      ACCOUNT."LAST_UPDATED" ,
      ACCOUNT."BRANCHID" ,
      ACCOUNT."AVAILABLE_BALANCE",
      RPAD(ACCOUNT."OLDACCOUNT_ID",20),
      ACCOUNT."INTERNAL_BRANCH_ID" bulk collect
    INTO inTITLE ,
      inSTATUS ,
      inACTUAL_BALANCE ,
      inACCOUNT_ID ,
      inACCOUNT_TYPE ,
      inACCOUNT_CURRENCY ,
      inLAST_UPDATED ,
      inBRANCHID ,
      inAVAILABLE_BALANCE,
      inOLDACCOUNT_ID,
      inINTERNAL_BRANCH_ID
    FROM TBLIMPTMPACCOUNT ACCOUNT
    WHERE ACCOUNT.ACTIONFLAG = '02'
    AND ACCOUNT.FAILED      IS NULL;
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    FORALL i IN inACCOUNT_ID.FIRST..inACCOUNT_ID.LAST
    UPDATE TBLACCOUNT
    SET TITLE = inTITLE (i),
      STATUS  = inSTATUS (i),
      --            ACTUAL_BALANCE    = inACTUAL_BALANCE   (i), -- as balance update are done through balance download import
      LAST_UPDATED = inLAST_UPDATED (i),
      BRANCHID     = inBRANCHID (i),
      --            AVAILABLE_BALANCE = inAVAILABLE_BALANCE(i),
      OLDACCOUNT_ID                   = inOLDACCOUNT_ID (i),
      INTERNAL_BRANCH_ID              = inINTERNAL_BRANCH_ID(i)
    WHERE TRIM(TBLACCOUNT.ACCOUNT_ID) = TRIM(inACCOUNT_ID(i))
    AND ACCOUNT_TYPE                  = inACCOUNT_TYPE (i)
    AND ACCOUNT_CURRENCY              = inACCOUNT_CURRENCY (i);
    outRetVal                        := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    -- --commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spUpdateAccount;
  PROCEDURE spInsertRelation(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --Set Transaction Read Write;  -- BY SR - Feb 22 - 2011 - Merged from ENBD
    -- ENBD MERGED FARAZ
    /*   Update TBLCUSTCHANNELACCT
    set is_default = '0'
    where relationship_ID in (
    SELECT DISTINCT ACCOUNT_REL.RELATIONSHIP_ID
    FROM   tblimptmpaccount_rel ACCOUNT_REL,
    TBLCUSTCHANNELACCT A
    WHERE A.RELATIONSHIP_ID = ACCOUNT_REL.RELATIONSHIP_ID
    and   A.Channel_ID = ACCOUNT_REL.CHANNEL_ID
    and   A.IS_DEFAULT = ACCOUNT_REL.IS_DEFAULT
    AND   ACCOUNT_REL.IS_DEFAULT = '1'
    AND ACCOUNT_REL.ACTIONFLAG = '01'
    AND ACCOUNT_REL.FAILED IS NULL
    );
    */
    INSERT
    INTO TBLCUSTCHANNELACCT
      (
        SELECTIONTYPE,
        ACCOUNTMAP,
        CHANNEL_ID,
        RELATIONSHIP_ID,
        IS_DEFAULT,
        ACCOUNT_ID,
        ACCOUNT_TYPE,
        ACCOUNT_CURRENCY,
        CUSTOMER_ID,
        TRAN_PERM,
        NATURE,
        RELATIONSHIPAUTH_ID,
        PRODUCTID
      )
    SELECT ACCOUNT_REL.SELECTIONTYPE,
      trim(RPAD(ACCOUNT_REL.ACCOUNTMAP,20,' ')), --RPAD(ACCOUNT_REL.ACCOUNTMAP,20,' '),
      ACCOUNT_REL.CHANNEL_ID,
      ACCOUNT_REL.RELATIONSHIP_ID,
      ACCOUNT_REL.IS_DEFAULT,
      UIPKGACCOUNT.fnTrnasformAccount(ACCOUNT_REL.INSTITUTIONID,ACCOUNT_REL.ACCOUNT_ID), --RPAD(ACCOUNT_REL.ACCOUNT_ID,20,' '),
      ACCOUNT_REL.TYPE,
      ACCOUNT_REL.CURRENCY,
      ACCOUNT_REL.CUSTOMER_ID,
      ACCOUNT_REL.TRAN_PERM,
      ACCOUNT_REL.NATURE,
      ACCOUNT_REL.RELATIONSHIPAUTH_ID,
      ACCOUNT_REL.PRODUCTID
    FROM tblimptmpaccount_rel ACCOUNT_REL
    WHERE ACCOUNT_REL.CHANNEL_ID <> '0000'
    AND ACCOUNT_REL.CHANNEL_ID   <> '*'
    AND ACCOUNT_REL.ACTIONFLAG    = '01'
    AND ACCOUNT_REL.FAILED       IS NULL
    UNION
    SELECT ACCOUNT_REL.SELECTIONTYPE,
      trim(RPAD(ACCOUNT_REL.ACCOUNT_ID,20)) AS ACCOUNTMAP, --RPAD(ACCOUNT_REL.ACCOUNT_ID,20) as ACCOUNTMAP,
      B.CHANNEL_ID,
      ACCOUNT_REL.RELATIONSHIP_ID,
      --ACCOUNT_REL.IS_DEFAULT,
      --'0',--for linking default account will not change --this was needed in bicec modified by tanveer
      ACCOUNT_REL.IS_DEFAULT,
      UIPKGACCOUNT.fnTrnasformAccount(ACCOUNT_REL.INSTITUTIONID,ACCOUNT_REL.ACCOUNT_ID), --RPAD(ACCOUNT_REL.ACCOUNT_ID,20) as ACCOUNT_ID,
      ACCOUNT_REL.TYPE,
      ACCOUNT_REL.CURRENCY,
      ACCOUNT_REL.CUSTOMER_ID,
      B.TRAN_PERM,
      ACCOUNT_REL.NATURE,
      B.RELATIONSHIPAUTH_ID,
      B.PRODUCTID
    FROM tblimptmpaccount_rel ACCOUNT_REL,
      (SELECT DISTINCT CHANNEL_ID,
        RELATIONSHIP_ID,
        RELATIONSHIPAUTH_ID,
        TRAN_PERM,
        PRODUCTID
      FROM TBLCUSTCHANNELACCT
      ) B
    WHERE ACCOUNT_REL.CHANNEL_ID    = '0000'
    AND ACCOUNT_REL.RELATIONSHIP_ID = B.RELATIONSHIP_ID
    AND ACCOUNT_REL.ACTIONFLAG      = '01'
    AND ACCOUNT_REL.FAILED         IS NULL;
    outRetVal                      := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spInsertRelation;
  PROCEDURE spUpdateRelation(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inSELECTIONTYPE T_REL_SELECTIONTYPE            := T_REL_SELECTIONTYPE();
    inACCOUNTMAP T_REL_ACCOUNTMAP                  := T_REL_ACCOUNTMAP();
    inCHANNEL_ID T_REL_CHANNEL_ID                  := T_REL_CHANNEL_ID();
    inRELATIONSHIP_ID T_REL_RELATIONSHIP_ID        := T_REL_RELATIONSHIP_ID();
    inIS_DEFAULT T_REL_IS_DEFAULT                  := T_REL_IS_DEFAULT();
    inACCOUNT_ID T_REL_ACCOUNT_ID                  := T_REL_ACCOUNT_ID();
    inACCOUNT_TYPE T_REL_ACCOUNT_TYPE              := T_REL_ACCOUNT_TYPE();
    inACCOUNT_CURRENCY T_REL_ACCOUNT_CURRENCY      := T_REL_ACCOUNT_CURRENCY();
    inCUSTOMER_ID T_REL_CUSTOMER_ID                := T_REL_CUSTOMER_ID();
    inTRAN_PERM T_REL_TRAN_PERM                    := T_REL_TRAN_PERM();
    inNATURE T_REL_NATURE                          := T_REL_NATURE();
    inRELATIONSHIPAUTH_ID T_REL_RELATIONSHIPAUTH_ID:= T_REL_RELATIONSHIPAUTH_ID();
    inPRODUCTID T_REL_PRODUCTID                    := T_REL_PRODUCTID();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SELECT ACCOUNT_REL.SELECTIONTYPE,
      ACCOUNT_REL.ACCOUNTMAP,
      ACCOUNT_REL.CHANNEL_ID,
      ACCOUNT_REL.RELATIONSHIP_ID,
      ACCOUNT_REL.IS_DEFAULT,
      UIPKGACCOUNT.fnTrnasformAccount(ACCOUNT_REL.INSTITUTIONID,ACCOUNT_REL.ACCOUNT_ID), --RPAD(ACCOUNT_REL.ACCOUNT_ID,20),
      ACCOUNT_REL.TYPE,
      ACCOUNT_REL.CURRENCY,
      ACCOUNT_REL.CUSTOMER_ID AS CUSTOMERID,
      ACCOUNT_REL.TRAN_PERM,
      ACCOUNT_REL.NATURE,
      ACCOUNT_REL.RELATIONSHIPAUTH_ID,
      ACCOUNT_REL.PRODUCTID bulk collect
    INTO inSELECTIONTYPE ,
      inACCOUNTMAP ,
      inCHANNEL_ID ,
      inRELATIONSHIP_ID ,
      inIS_DEFAULT ,
      inACCOUNT_ID ,
      inACCOUNT_TYPE ,
      inACCOUNT_CURRENCY ,
      inCUSTOMER_ID ,
      inTRAN_PERM ,
      inNATURE ,
      inRELATIONSHIPAUTH_ID,
      inPRODUCTID
    FROM tblimptmpaccount_rel ACCOUNT_REL
    WHERE ACCOUNT_REL.ACTIONFLAG = '02'
    AND ACCOUNT_REL.FAILED      IS NULL;
    -- Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    FORALL i IN inACCOUNT_ID.FIRST..inACCOUNT_ID.LAST
    UPDATE TBLCUSTCHANNELACCT
    SET SELECTIONTYPE = inSELECTIONTYPE(i),
      ACCOUNTMAP      = inACCOUNTMAP(i),
      IS_DEFAULT      = inIS_DEFAULT(i),
      TRAN_PERM       = inTRAN_PERM(i),
      NATURE          = inNATURE(i)
      --                RELATIONSHIPAUTH_ID = inRELATIONSHIPAUTH_ID(i)
    WHERE CHANNEL_ID     = inCHANNEL_ID(i)
    AND RELATIONSHIP_ID  = inRELATIONSHIP_ID(i)
    AND TRIM(ACCOUNT_ID) = inACCOUNT_ID(i)
    AND ACCOUNT_TYPE     = inACCOUNT_TYPE(i)
    AND ACCOUNT_CURRENCY = inACCOUNT_CURRENCY(i)
    AND CUSTOMER_ID      = inCUSTOMER_ID(i)
    AND PRODUCTID        = inPRODUCTID(i);
    outMsg              := outMsg || ' Relations Updated :[' || SQL%ROWCOUNT || ']';
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    ----commit; --to zero the SQL%ROWCOUNT for next update
    --for default account changed-----------------------------------------------------------------------------------
    SELECT ACCOUNT_REL.CHANNEL_ID,
      ACCOUNT_REL.RELATIONSHIP_ID,
      ACCOUNT_REL.IS_DEFAULT,
      ACCOUNT_REL.ACCOUNT_ID,
      ACCOUNT_REL.TYPE,
      ACCOUNT_REL.CURRENCY,
      ACCOUNT_REL.CUSTOMER_ID bulk collect
    INTO inCHANNEL_ID ,
      inRELATIONSHIP_ID ,
      inIS_DEFAULT ,
      inACCOUNT_ID ,
      inACCOUNT_TYPE ,
      inACCOUNT_CURRENCY ,
      inCUSTOMER_ID
    FROM tblimptmpaccount_rel ACCOUNT_REL
    WHERE IS_DEFAULT           = '1'
    AND ACCOUNT_REL.ACTIONFLAG = '02'
    AND ACCOUNT_REL.FAILED    IS NULL
    GROUP BY ACCOUNT_ID,
      TYPE,
      CURRENCY,
      CUSTOMER_ID,
      CHANNEL_ID,
      IS_DEFAULT,
      RELATIONSHIP_ID;
    FOR i IN 1..inACCOUNT_ID.count
    LOOP
      UPDATE TBLCUSTCHANNELACCT
      SET IS_DEFAULT        = '0'
      WHERE RELATIONSHIP_ID = inRELATIONSHIP_ID(i)
      AND CUSTOMER_ID       = inCUSTOMER_ID(i)
      AND CHANNEL_ID       <> '9999'
      AND inCHANNEL_ID(i)   = '0000';
      UPDATE TBLCUSTCHANNELACCT
      SET IS_DEFAULT        = inIS_DEFAULT(i)
      WHERE RELATIONSHIP_ID = inRELATIONSHIP_ID(i)
      AND TRIM(ACCOUNT_ID)  = inACCOUNT_ID(i)
      AND ACCOUNT_TYPE      = inACCOUNT_TYPE(i)
      AND ACCOUNT_CURRENCY  = inACCOUNT_CURRENCY(i)
      AND CUSTOMER_ID       = inCUSTOMER_ID(i)
      AND CHANNEL_ID       <> '9999'
      AND inCHANNEL_ID(i)   = '0000';
      UPDATE TBLCUSTCHANNELACCT
      SET IS_DEFAULT       = '0'
      WHERE CHANNEL_ID     = inCHANNEL_ID(i)
      AND RELATIONSHIP_ID  = inRELATIONSHIP_ID(i)
      AND CUSTOMER_ID      = inCUSTOMER_ID(i)
      AND CHANNEL_ID      <> '9999'
      AND inCHANNEL_ID(i) <> '0000';
      UPDATE TBLCUSTCHANNELACCT
      SET IS_DEFAULT       = inIS_DEFAULT(i)
      WHERE CHANNEL_ID     = inCHANNEL_ID(i)
      AND RELATIONSHIP_ID  = inRELATIONSHIP_ID(i)
      AND TRIM(ACCOUNT_ID) = inACCOUNT_ID(i)
      AND ACCOUNT_TYPE     = inACCOUNT_TYPE(i)
      AND ACCOUNT_CURRENCY = inACCOUNT_CURRENCY(i)
      AND CUSTOMER_ID      = inCUSTOMER_ID(i)
      AND CHANNEL_ID      <> '9999'
      AND inCHANNEL_ID(i) <> '0000';
    END LOOP;
    -------------------------------------------------------------------------------------------------------------------------
    outRetVal := SQL%ROWCOUNT;
    outMsg    := outMsg || ' Default Accounts Marked :[' || SQL%ROWCOUNT || '] ';
    --Update productID for soft recarding request
    /* update tblcustchannelacct cca
    set productid = (
    select rel.productid
    from tblimptmpaccount_rel rel
    where cca.customer_id = rel.customer_id
    and cca.account_id = rel.account_id
    and failed is null
    and actionflag = '02'
    and channel_id = '0001'
    )
    where channel_id <> '9999'
    and (customer_id, account_id) in (
    select rel.customer_id, rel.account_id
    from tblimptmpaccount_rel rel
    where cca.customer_id = rel.customer_id
    and cca.account_id = rel.account_id
    and failed is null
    and actionflag = '02'
    );*/
    --Added By Rizwan Hussain
    UPDATE tblcustchannelacct cca
    SET productid =
      (SELECT card.productid
      FROM tblimptmpcard card
      WHERE cca.relationship_id = card.existingcardnumber
      AND card.failed          IS NULL
      AND card.actionflag       = '02'
      AND card.regeneration_type='12'
      )
    WHERE channel_id    <> '9999'
    AND relationship_id IN
      (SELECT card.existingcardnumber
      FROM tblimptmpcard card
      WHERE cca.relationship_id = card.existingcardnumber
      AND card.failed          IS NULL
      AND card.actionflag       = '02'
      AND card.regeneration_type='12'
      );
    --Added By Rizwan Hussain
    outMsg := outMsg || ' Product Update for Cardbased Channels - soft recarding: [' || SQL%ROWCOUNT || ']';
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    ---- Jehanzeb
    UPDATE tblcustchannelacct cca
    SET productid =
      (SELECT card.productid
      FROM tblimptmpcard card
      WHERE cca.relationship_id = card.cnic
      AND card.failed          IS NULL
      AND card.actionflag       = '02'
      AND card.regeneration_type='12'
      )
    WHERE channel_id    <> '9999'
    AND relationship_id IN
      (SELECT card.cnic
      FROM tblimptmpcard card
      WHERE cca.relationship_id = card.cnic
      AND card.failed          IS NULL
      AND card.actionflag       = '02'
      AND card.regeneration_type='12'
      );
    Outmsg := Outmsg || ' Product Update for Non Cardbased channels - soft recarding: [' || Sql%Rowcount || ']';
    COMMIT;
    ----  Jehanzeb updated
  END spUpdateRelation;
  PROCEDURE spInsertCard(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --  Set Transaction Read Write;  -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLDEBITCARD
      (
        CARDNUMBER,
        EXPIRYDATE,
        CUSTOMERID,
        ISSUPPLEMENTARYCARD,
        CARDNAME,
        CARDSTATUS,
        SERVICECODE,
        LANGUAGECODE,
        BRANCHCODE,
        CREATIONDATE,
        TRACK1_DATA,
        TRACK2_DATA,
        TRACK3_DATA,
        CVV1,
        CVV2,
        HUBCODE,
        REGIONCODE,
        PRIMARYCARDNUMBER,
        ACTIVATIONDATE,
        PROCESSINGCODE,
        GROUP_ID,
        DATAENTERDATE,
        IS_INDIVIDUAL,
        MODIFICATION_DATE,
        RELATIONSHIP_ID,
        DELIVERYSTATUS,
        EXISTINGCARDNUMBER,
        JOBID,
        CARD_INTERFACING_NO,
        LOCATIONBRANCH,
        REGENERATION_TYPE,
        DESIGNCODE,
        FIRSTCARDNUMBER,
        RENEWAL_STATUS,
        DATA_SOURCE
      )
    SELECT DISTINCT CARD.CARDNUMBER,
      CARD.EXPIRYDATE,
      CARD.CUSTOMERID,
      CARD.ISSUPPLEMENTARYCARD,
      UPPER(CARD.CARDNAME), -- BY SR - Feb 22 - 2011 - Merged from ENBD
      CARD.CARDSTATUS,
      '',
      '',
      CARD.BRANCHID,
      --CARD.CREATIONDATE, --Fariha: Comment as Creation Date should be filled once card has been produced
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      CARD.PRIMARYCARDNUMBER,
      '',
      '',
      CARD.PRODUCTID,
      TO_CHAR(sysdate,'yyyymmdd'),
      '',
      '',
      CARD.CARDNUMBER
      || '='
      || SUBSTR(EXPIRYDATE,3,4),
      CARD.DELIVERYSTATUS,
      CARD.existingcardnumber,
      CARD.JOBID,
      CARD.CARD_INTERFACING_NO,
      CARD.LOCATIONBRANCH,
      CARD.REGENERATION_TYPE,
      CARD.DESIGNCODE,
      CARD.CARDNUMBER AS FIRSTCARDNUMBER,--as first card number will be card number itself
      '0',
      'IMPORT'
    FROM tblimptmpcard CARD
    WHERE CARD.ACTIONFLAG = '01'
    AND CARD.FAILED      IS NULL;
    outRetVal            := SQL%ROWCOUNT;
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    -- --commit;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      UPDATE tblimptmpcard
      SET tblimptmpcard.Failed = '1' ,
        err_code               = errorCode,
        err_description        = errorDesc;
      COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      outRetVal := 0;
    END;
  END spInsertCard;
  PROCEDURE spUpdateCard(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    /*inCustomerID t_cust_id:=t_cust_id();
    inCardNumber t_card_number:=t_card_number();
    inExpiryDate t_expiry_date:=t_expiry_date();
    inCardName t_name_on_card:=t_name_on_card();
    inCardStatus t_card_status:=t_card_status();
    inBranchCode t_branch_code:=t_branch_code();
    inProductId t_group_id:=t_group_id();
    inRelationshipId t_relationship_id:=t_relationship_id();
    inRelationshipauthId T_REL_RELATIONSHIPAUTH_ID:=T_REL_RELATIONSHIPAUTH_ID();*/
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    /* fahad 06/08/2010
    SELECT CARD.CARDNUMBER,
    CARD.EXPIRYDATE,
    CARD.CUSTOMERID,
    CARD.CARDNAME,
    CARD.CARDSTATUS,
    CARD.BRANCHID,
    CARD.PRODUCTID,
    CARD.CARDNUMBER || '=' || SUBSTR(EXPIRYDATE,3,4),
    tblCustChannelAcct.RELATIONSHIPAUTH_ID
    bulk collect into
    inCardNumber,
    inExpiryDate,
    inCustomerId,
    inCardName,
    inCardStatus,
    inBranchCode,
    inProductId,
    inRelationshipId,
    inRelationshipauthId
    from tblimptmpcard CARD, tblCustChannelAcct
    WHERE
    CARD.CARDNUMBER || '=' || SUBSTR(EXPIRYDATE,3,4) = TBLCUSTCHANNELACCT.RELATIONSHIP_ID
    AND channel_id = '0001'
    AND CARD.ACTIONFLAG = '02'
    AND  CARD.FAILED IS NULL;
    Set Transaction Read Write;
    outRetVal := inRelationshipId.count;
    FORALL i in inRelationshipId.FIRST..inRelationshipId.LAST
    UPDATE TBLDEBITCARD SET
    CARDNAME = inCardName(i),
    CARDSTATUS = inCardStatus(i)
    WHERE
    TRIM(TBLDEBITCARD.RELATIONSHIP_ID) = TRIM(inRelationshipId(i));
    FORALL i in inRelationshipId.FIRST..inRelationshipId.LAST
    UPDATE tblrelationshipauth SET
    STATUS = inCardStatus(i),
    --fahad 20/07/2010 reason code update
    REASONCODE=(select reasoncode from tblcfgcardstatusreason where isdefault='1' and STATUSCODE=inCardStatus(i) and rownum<2)
    --fahad 20/07/2010 reason code update
    WHERE
    TRIM(tblrelationshipauth.RELATIONSHIPAUTH_ID) = TRIM(inRelationshipauthId(i));
    */
    -- Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    /*
    update tbldebitcard
    set (cardname,cardstatus)=
    (select cardname, cardstatus from tblimptmpcard where failed is null and ACTIONFLAG = '02' and tbldebitcard.relationship_id = tblimptmpcard.relationship_id)
    where (relationship_id) in
    (select relationship_id from tblimptmpcard where failed is null and ACTIONFLAG = '02');
    update tblrelationshipauth TR
    set (TR.status,TR.reasoncode)=
    (
    select TA.cardstatus,TC.REASONCODE
    from tblimptmpcard TA,
    (select relationshipauth_id,relationship_id,productid from tblcustchannelacct where channel_id in
    (
    select tblcfgproductchannels.CHANNEL_ID
    from tblcfgproductchannels,tblcfgchannel
    where tblcfgproductchannels.CHANNEL_ID = tblcfgchannel.CHANNELID
    and upper(tblcfgchannel.CARDREQUIRED)='Y'
    and tblcfgproductchannels.PRODUCT_ID = TBLCUSTCHANNELACCT.PRODUCTID
    )
    ) TB,
    tblcfgcardstatusreason TC
    where TA.failed is null and TA.ACTIONFLAG = '02'
    and TB.relationship_id = TA.relationship_id
    and TB.productid = TA.productid
    and TB.RELATIONSHIPAUTH_ID=TR.RELATIONSHIPAUTH_ID
    and TC.ISDEFAULT='1'
    and TC.STATUSCODE=TA.cardstatus
    and rownum < 2
    )
    where TR.relationshipauth_id in
    ( select relationshipauth_id
    from tblcustchannelacct
    where channel_id in (
    select tblcfgproductchannels.CHANNEL_ID
    from tblcfgproductchannels,tblcfgchannel
    where tblcfgproductchannels.CHANNEL_ID = tblcfgchannel.CHANNELID
    and upper(tblcfgchannel.CARDREQUIRED)='Y'
    and tblcfgproductchannels.PRODUCT_ID = TBLCUSTCHANNELACCT.PRODUCTID
    )
    and (relationship_id,productid) in
    (select relationship_id,productid from tblimptmpcard where failed is null and ACTIONFLAG = '02')
    );
    outRetVal := SQL%ROWCOUNT;
    commit;
    commit;
    */
    UPDATE tbldebitcard
    SET
      (
        cardname,
        cardstatus,
        ACTIVATIONDATE
      )
      =
      (SELECT cardname,
        cardstatus,
        DECODE(cardstatus,'00',TO_CHAR(sysdate,'yyyymmdd'),TBLDEBITCARD.ACTIVATIONDATE)
      FROM tblimptmpcard
      WHERE failed                    IS NULL
      AND ACTIONFLAG                   = '02'
      AND tbldebitcard.relationship_id = tblimptmpcard.relationship_id
      )
    WHERE (relationship_id) IN
      (SELECT relationship_id
      FROM tblimptmpcard
      WHERE failed  IS NULL
      AND ACTIONFLAG = '02'
      );
    /*
    --Manazir FARMERS CARD
    UPDATE tbldebitcard
    SET
    (
    cardname,
    cardstatus,
    ACTIVATIONDATE,
    card_link
    )
    =
    (SELECT cardname,
    cardstatus,
    DECODE(cardstatus,'00',TO_CHAR(sysdate,'yyyymmdd'),TBLDEBITCARD.ACTIVATIONDATE),
    '1'
    FROM tblimptmpcard_enhanced
    WHERE failed                    IS NULL
    AND ACTIONFLAG                   = '02'
    AND regeneration_type = '04'
    AND tbldebitcard.relationship_id = tblimptmpcard_enhanced.relationship_id
    and rownum =1)
    WHERE (relationship_id) IN
    (SELECT relationship_id
    FROM tblimptmpcard_enhanced
    WHERE failed  IS NULL
    AND regeneration_type = '04'
    AND ACTIONFLAG = '02'
    );
    --Manazir FARMERS CARD
    */
    --Update destination productID in case of soft recarding
    /* update tbldebitcard
    set group_id = (
    select productid from tblimptmpcard
    where failed is null
    and tblimptmpcard.regeneration_type = '12'
    and actionflag = '02'
    and substr(tbldebitcard.relationship_id, 1, 16) = tblimptmpcard.oldpan
    )
    where substr(relationship_id, 1, 16) in (
    select oldpan from tblimptmpcard
    where failed is null
    and regeneration_type = '12'
    and actionflag = '02'
    );*/
    --Added By Rizwan Hussain
    UPDATE tbldebitcard
    SET group_id =
      (SELECT productid
      FROM tblimptmpcard
      WHERE failed                       IS NULL
      AND tblimptmpcard.regeneration_type = '12'
      AND actionflag                      = '02'
      AND tbldebitcard.relationship_id    = tblimptmpcard.existingcardnumber
      )
    WHERE relationship_id IN
      (SELECT existingcardnumber
      FROM tblimptmpcard
      WHERE failed         IS NULL
      AND regeneration_type = '12'
      AND actionflag        = '02'
      );
    --End added by Rizwan Hussain
    --- insert status in activity log ------
    INSERT
    INTO tblactivitylogs
      (
        ACTIVITYLOGID,
        REL_ID,
        ACTIVITIYCODE,
        ALERTSENT,
        STATUS,
        CHANNELID,
        AGENTID,
        ACTIVITYDATETIME,
        OLD_STATUS
      )
    SELECT SEQ_ACTIVITYLOG.nextval,
      b.relationship_id,
      '05',
      '',
      c.cardstatus,
      '0001',
      'Offline',
      TO_CHAR(sysdate,'yyyyMMddHH24MISS'),
      a.status
    FROM tblrelationshipauth a,
      tblcustchannelacct b ,
      tblimptmpcard c
    WHERE a.relationshipauth_id = b.relationshipauth_id
    AND b.channel_id            ='0001'
    AND b.relationship_id       = c.relationship_id
    AND c.failed               IS NULL
    AND c.ACTIONFLAG            = '02';
    /*********************************************/
    UPDATE tblrelationshipauth TR
    SET
      (
        TR.status,
        TR.reasoncode
      )
      =
      (SELECT TA.cardstatus,
        TC.REASONCODE
      FROM tblimptmpcard TA,
        tblrelationshipauth TR,
        (SELECT relationshipauth_id,
          relationship_id,
          productid
        FROM tblcustchannelacct
        WHERE channel_id IN
          (SELECT tblcfgproductchannels.CHANNEL_ID
          FROM tblcfgproductchannels,
            tblcfgchannel
          WHERE tblcfgproductchannels.CHANNEL_ID = tblcfgchannel.CHANNELID
            --and upper(tblcfgchannel.CARDREQUIRED)='Y'
          AND tblcfgproductchannels.PRODUCT_ID = TBLCUSTCHANNELACCT.PRODUCTID
          )
        ) TB,
        tblcfgcardstatusreason TC
      WHERE TA.failed          IS NULL
      AND TA.ACTIONFLAG         = '02'
      AND TB.relationship_id    = TA.relationship_id
      AND TB.productid          = TA.productid
      AND TB.RELATIONSHIPAUTH_ID=TR.RELATIONSHIPAUTH_ID
      AND TC.ISDEFAULT          ='1'
      AND TC.STATUSCODE         =TA.cardstatus
      AND rownum                < 2
      )
    WHERE TR.relationshipauth_id IN
      ( SELECT DISTINCT relationshipauth_id
      FROM tblcustchannelacct
      WHERE channel_id IN
        (SELECT tblcfgproductchannels.CHANNEL_ID
        FROM tblcfgproductchannels,
          tblcfgchannel
        WHERE tblcfgproductchannels.CHANNEL_ID = tblcfgchannel.CHANNELID
          --and upper(tblcfgchannel.CARDREQUIRED)='Y'
        AND tblcfgproductchannels.PRODUCT_ID = TBLCUSTCHANNELACCT.PRODUCTID
        )
      AND (relationship_id,productid) IN
        (SELECT relationship_id,
          productid
        FROM tblimptmpcard
        WHERE failed  IS NULL
        AND ACTIONFLAG = '02'
        UNION
        SELECT cardnumber,
          productid
        FROM tblimptmpcard
        WHERE failed  IS NULL
        AND ACTIONFLAG = '02'
        )
      )
    AND TR.STATUS IN ('00','01','03');
    outRetVal     := SQL%ROWCOUNT;
    COMMIT;
  END spUpdateCard;
  PROCEDURE sprelationshipauthAdd(
      inPIN          IN VARCHAR2,
      inMAXRETRIES   IN VARCHAR2,
      inREMRETRIES   IN VARCHAR2,
      inSTATUS       IN VARCHAR2,
      inPIN_GEN_DATE IN VARCHAR2,
      outRetVal OUT VARCHAR2 )
  IS
    rel_auth_id VARCHAR2(10);
  BEGIN
    SELECT RELATIONSHIP_AUTH_ID.NEXTVAL INTO rel_auth_id FROM dual;
    --        Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO tblrelationshipauth
      (
        PIN,
        MAXRETRIES,
        REMRETRIES,
        STATUS,
        RELATIONSHIPAUTH_ID,
        PIN_GEN_DATE
      )
      VALUES
      (
        inPIN,
        inMAXRETRIES,
        inREMRETRIES,
        inSTATUS,
        rel_auth_id,
        inPIN_GEN_DATE
      );
    outretval := rel_auth_id;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    ----commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END sprelationshipauthAdd;
  PROCEDURE spCustomerProductAdd
    (
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER
    )
  AS --<Add : Saba Anjum , Date: 2017-08-29>--
    IsDPr VARCHAR
    (
      5
    )
    ;
  BEGIN
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    /**********************************************************************************************/
    --this will update the default product on gdc whose priority is less than the new product
    /*
    update tblcustomerproducts A
    set A.IS_DEFAULT_ONGDC = '0'
    where  A.IS_DEFAULT_ONGDC = '1'
    AND A.CUSTOMERID in (  select B.CUSTOMER_ID
    FROM tblimptmpcustomerproducts B
    where ((select priority
    from tblcfgproductdetail
    where tblcfgproductdetail.PRODUCT_ID = A.PRODUCTID) < (select priority
    from tblcfgproductdetail
    where tblcfgproductdetail.PRODUCT_ID = B.PRODUCTID))
    AND B.IS_DEFAULT_ONGDC = '1'
    AND B.ACTIONFLAG = '01'
    AND B.FAILED IS NULL);
    */
    /**********************************************************************************************/
    --Mark existing product's default GDC to 0, so that destination product's will be mark default GDC to 1
    --<Add : Saba Anjum , Date: 2017-08-29>--
    ---If Destination Product is null then do not Run Update Query for existing product to set 0 GDC
    --select count(tblimptmpaccount_rel.CUSTOMER_ID) into IsDPr from tblimptmpaccount_rel where tblimptmpaccount_rel.DESTINATION_PRODUCTID is null and tblimptmpaccount_rel.Customer_ID in (select tblimptmpcustomerproducts.customer_id
    --                      from tblimptmpcustomerproducts
    --                    where failed is null
    --                    and actionflag = '01');
    --<Add by Saba Anjum, 2018-01-12, To get Count of Default Product Existance of Customer>--
    SELECT COUNT(ProductID)
    INTO IsDPr
    FROM TBLCUSTOMERPRODUCTS
    WHERE CUSTOMERID IN
      (SELECT tblimptmpcustomerproducts.customer_id
      FROM tblimptmpcustomerproducts
      WHERE failed  IS NULL
      AND actionflag = '01'
      )
    AND IS_DEFAULT_ONGDC='1';
    IF IsDPr           <=0 THEN --<Add By : Saba Anjum , Date: 2018-01-11>--
      UPDATE tblcustomerproducts
      SET is_default_ongdc = '0'
      WHERE customerid    IN
        (SELECT tblimptmpcustomerproducts.customer_id
        FROM tblimptmpcustomerproducts
        WHERE failed  IS NULL
        AND actionflag = '01'
        ) ;
      --<Add : Saba Anjum , Date: 2017-09-19>--
      --Change defalut status 1 if product already exists against customer
      --update tblcustomerproducts
      --set is_default_ongdc = '1'
      --where customerid in (
      --                    select tblimptmpcustomerproducts.customer_id
      --                 from tblimptmpcustomerproducts
      --               where
      --              failed is null
      --            and
      --          actionflag = '01'
      --     ) and PRODUCTID in (select tblimptmpcustomerproducts.PRODUCTID
      --     from tblimptmpcustomerproducts
      --   where
      -- failed is null
      --and
      --actionflag = '01');
    END IF; --<Add By : Saba Anjum , Date: 2018-01-11>--
    --<Add : Saba Anjum , Date: 2017-09-19>--
    --Check for product existance according to customerid. Run insert query if not exist.
    --select count(ProductID) into IsDPr from TBLCUSTOMERPRODUCTS where CUSTOMERID in ( select tblimptmpcustomerproducts.customer_id
    --                      from tblimptmpcustomerproducts
    --                    where
    --                  failed is null
    --                  and
    --                actionflag = '01') and PRODUCTID in ( select tblimptmpcustomerproducts.PRODUCTID
    --            from tblimptmpcustomerproducts
    --          where
    --        failed is null
    --        and
    --      actionflag = '01');
    --If IsDPr <=0 then --<Add : Saba Anjum , Date: 2017-09-19>--
    INSERT
    INTO TBLCUSTOMERPRODUCTS
    SELECT CUSTOMERPRODUCT.CUSTOMER_ID,
      CUSTOMERPRODUCT.PRODUCTID,
      CUSTOMERPRODUCT.IS_DEFAULT_ONGDC
    FROM tblimptmpcustomerproducts CUSTOMERPRODUCT
    WHERE CUSTOMERPRODUCT.ACTIONFLAG = '01'
    AND CUSTOMERPRODUCT.FAILED      IS NULL;
    --end if; --<Add : Saba Anjum , Date: 2017-09-19>--
    outRetVal := SQL%ROWCOUNT;
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    -- --commit; --THIS --commit END THE SET TRANSACTION READ WRITE
    COMMIT; -- THIS COMMIT COMMITS DATA TO THE DB
  END spCustomerProductAdd;
  PROCEDURE spInsertLimit(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    tmpRelCursor REF_CURSOR;
    tmpRelationshipId      VARCHAR2(30);
    tmpCardNumber          VARCHAR2(30);
    tmpProductId           VARCHAR2(30);
    tmpExpiryDate          VARCHAR2(30);
    tmpCount               NUMBER;
    tmpAccountId           VARCHAR2(100);
    tmpCustomerId          VARCHAR2(100);
    tmpAmount              VARCHAR2(100);
    tmpProdAmountId        VARCHAR2(100);
    tmpFrequencyLength     VARCHAR2(100);
    tmpCycleLength         VARCHAR2(100);
    tmpFrequencyLengthType VARCHAR2(100);
    tmpCycleLengthType     VARCHAR2(100);
    tmpFrequencyQuota      VARCHAR2(100);
    tmpAmountSeqVal        VARCHAR2(100);
    tmpIndAmountId         VARCHAR2(100);
    l_InsertCount          NUMBER;
  BEGIN
    outRetVal     := 0;
    outMsg        := 'Executed Successfully';
    l_InsertCount := 0;
    --Set Transaction Read Write;
    INSERT
    INTO TBLREMAININGCARDLIMIT
      (
        CARD_NUMBER,
        CYCLE_BEGIN_DATE,
        REMAINING_LIMIT,
        AMOUNT_ID,
        EXPIRY_DATE,
        IS_IND_LIMIT,
        RELATIONSHIP_ID,
        REMAINING_FREQUENCY
      )
    SELECT DISTINCT CARDNUMBER,
      TO_CHAR(sysdate,'yyyymmdd'),
      TO_NUMBER(AMOUNT),
      AMOUNT_ID,
      EXPIRYDATE,
      '0',
      RELATIONSHIP_ID,
      FREQUENCY_LENGTH
    FROM
      (SELECT HOSTCARD.CARDNUMBER,
        HOSTCARD.EXPIRYDATE,
        HOSTCARD.RELATIONSHIP_ID,
        TBLCFGLIMIT.CHANNEL_ID ,
        HOSTCARD.ACCOUNT_ID,
        TBLCFGLIMIT.GROUP_ID AS PRODUCTID,
        CUSTOMER_ID,
        TBLCFGLIMIT.TRAN_CODE,
        HOSTCARD.AMOUNT,
        TBLCFGLIMITAMOUNT.AMOUNT_ID,
        TBLCFGLIMITAMOUNT.CYCLE_LENGTH,
        TBLCFGLIMITAMOUNT.CYCLE_LENGTH_TYPE,
        TBLCFGLIMITAMOUNT.FREQUENCY_LENGTH,
        TBLCFGLIMITAMOUNT.FREQUENCY_LENGTH_TYPE,
        TBLCFGLIMITAMOUNT.FREQUENCY_QUOTA
      FROM TBLCFGLIMIT
      INNER JOIN
        (SELECT CARD_NUMBER AS CARDNUMBER,
          EXPIRY_DATE       AS EXPIRYDATE,
          CHANNEL_ID,
          RELATIONSHIP_ID,
          ACCOUNT_ID,
          TRAN_CODE,
          AMOUNT,
          PRODUCTID,
          CUSTOMER_ID
        FROM tblimptmplimits CARD
        ) HOSTCARD
      ON HOSTCARD.PRODUCTID  = TBLCFGLIMIT.GROUP_ID
      AND HOSTCARD.CHANNEL_ID= TBLCFGLIMIT.CHANNEL_ID
      AND HOSTCARD.TRAN_CODE = TBLCFGLIMIT.TRAN_CODE
      INNER JOIN TBLCFGLIMITAMOUNT
      ON TBLCFGLIMITAMOUNT.AMOUNT_ID             = TBLCFGLIMIT.AMOUNT_ID
      WHERE (TO_NUMBER(TBLCFGLIMITAMOUNT.AMOUNT) = TO_NUMBER(HOSTCARD.AMOUNT)) --Either the Amounts are Matched
      OR (TO_NUMBER('+00000000000')              = TO_NUMBER(HOSTCARD.AMOUNT)) --Or Amount is set to Zero
      UNION
      SELECT HOSTCARD.CARDNUMBER,
        HOSTCARD.EXPIRYDATE,
        HOSTCARD.RELATIONSHIP_ID,
        TBLCFGLIMIT.CHANNEL_ID ,
        HOSTCARD.ACCOUNT_ID,
        TBLCFGLIMIT.GROUP_ID AS PRODUCTID,
        CUSTOMER_ID,
        TBLCFGLIMIT.TRAN_CODE,
        TBLCFGLIMITAMOUNT.AMOUNT,
        TBLCFGLIMITAMOUNT.AMOUNT_ID,
        TBLCFGLIMITAMOUNT.CYCLE_LENGTH,
        TBLCFGLIMITAMOUNT.CYCLE_LENGTH_TYPE,
        TBLCFGLIMITAMOUNT.FREQUENCY_LENGTH,
        TBLCFGLIMITAMOUNT.FREQUENCY_LENGTH_TYPE,
        TBLCFGLIMITAMOUNT.FREQUENCY_QUOTA
      FROM TBLCFGLIMIT
      INNER JOIN
        (SELECT CARD_NUMBER AS CARDNUMBER,
          EXPIRY_DATE       AS EXPIRYDATE,
          CHANNEL_ID,
          RELATIONSHIP_ID,
          ACCOUNT_ID,
          TRAN_CODE,
          AMOUNT,
          PRODUCTID,
          CUSTOMER_ID
        FROM tblimptmplimits CARD
        ) HOSTCARD
      ON HOSTCARD.PRODUCTID   = TBLCFGLIMIT.GROUP_ID
      AND HOSTCARD.CHANNEL_ID<> TBLCFGLIMIT.CHANNEL_ID
      AND HOSTCARD.TRAN_CODE <> TBLCFGLIMIT.TRAN_CODE
      INNER JOIN TBLCFGLIMITAMOUNT
      ON TBLCFGLIMITAMOUNT.AMOUNT_ID = TBLCFGLIMIT.AMOUNT_ID
      ORDER BY CHANNEL_ID,
        TRAN_CODE
      );
    outMsg := 'TBLREMAININGCARDLIMIT Rows added['||SQL%ROWCOUNT||']';
    OPEN tmpRelCursor FOR
    SELECT DISTINCT HOSTCARD.CARDNUMBER,
      HOSTCARD.EXPIRYDATE,
      HOSTCARD.RELATIONSHIP_ID,
      HOSTCARD.ACCOUNT_ID,
      TBLCFGLIMIT.GROUP_ID AS PRODUCTID,
      CUSTOMER_ID,
      HOSTCARD.AMOUNT,
      TBLCFGLIMITAMOUNT.AMOUNT_ID,
      TBLCFGLIMITAMOUNT.CYCLE_LENGTH,
      TBLCFGLIMITAMOUNT.CYCLE_LENGTH_TYPE,
      TBLCFGLIMITAMOUNT.FREQUENCY_LENGTH,
      TBLCFGLIMITAMOUNT.FREQUENCY_LENGTH_TYPE,
      TBLCFGLIMITAMOUNT.FREQUENCY_QUOTA
    FROM TBLCFGLIMIT
    INNER JOIN
      (SELECT CARD_NUMBER AS CARDNUMBER,
        EXPIRY_DATE       AS EXPIRYDATE,
        CHANNEL_ID,
        RELATIONSHIP_ID,
        ACCOUNT_ID,
        TRAN_CODE,
        AMOUNT,
        PRODUCTID,
        CUSTOMER_ID
      FROM tblimptmplimits CARD
      ) HOSTCARD
    ON HOSTCARD.PRODUCTID  = TBLCFGLIMIT.GROUP_ID
    AND HOSTCARD.CHANNEL_ID= TBLCFGLIMIT.CHANNEL_ID
    AND HOSTCARD.TRAN_CODE = TBLCFGLIMIT.TRAN_CODE
    INNER JOIN TBLCFGLIMITAMOUNT
    ON TBLCFGLIMITAMOUNT.AMOUNT_ID              = TBLCFGLIMIT.AMOUNT_ID
    WHERE (TO_NUMBER(TBLCFGLIMITAMOUNT.AMOUNT) <> TO_NUMBER(HOSTCARD.AMOUNT))
    AND (TO_NUMBER('+00000000000')             <> TO_NUMBER(HOSTCARD.AMOUNT)) --Or Amount is set to Zero
      ;
    LOOP
      FETCH tmpRelCursor
      INTO tmpCardNumber,
        tmpExpiryDate,
        tmpRelationshipId,
        tmpAccountId,
        tmpProductId,
        tmpCustomerId,
        tmpAmount,
        tmpProdAMountId,
        tmpCycleLength,
        tmpCycleLengthType,
        tmpFrequencyLength,
        tmpFrequencyLengthType,
        tmpFrequencyQuota;
      EXIT
    WHEN tmpRelCursor %NOTFOUND;
      SELECT SEQ_LIMITAMOUNT.NEXTVAL INTO tmpIndAmountId FROM DUAL;
      --INSERT A NEW AMOUNT IN THE DATABASE FOR ALL INDIVIDUAL LIMITS
      --ALSO INSERT ROWS IN TBLCFGLIMIT
      INSERT
      INTO TBLCFGLIMITAMOUNT
        (
          AMOUNT_ID,
          AMOUNT,
          CYCLE_LENGTH,
          FREQUENCY_QUOTA,
          FREQUENCY_LENGTH,
          CYCLE_LENGTH_TYPE,
          FREQUENCY_LENGTH_TYPE
        )
        VALUES
        (
          tmpIndAmountId,
          tmpAmount,
          tmpCycleLength,
          tmpFrequencyQuota,
          tmpFrequencyLength,
          tmpCycleLengthType,
          tmpFrequencyLengthType
        );
      INSERT
      INTO TBLINDLIMITINFO
        (
          LIMIT_INFO_ID,
          TRAN_CODE,
          CHANNEL_ID,
          PRODUCT_ID
        )
      SELECT tmpIndAmountId,
        TBLCFGLIMIT.TRAN_CODE,
        TBLCFGLIMIT.CHANNEL_ID,
        tmpProductId
      FROM TBLCFGLIMIT
      WHERE TBLCFGLIMIT.GROUP_ID = tmpProductId
      AND TBLCFGLIMIT.AMOUNT_ID  = tmpProdAmountId;
      --update the record in tblremainingcardlimit
      UPDATE TBLREMAININGCARDLIMIT
      SET CYCLE_BEGIN_DATE  = TO_CHAR(SYSDATE,'yyyymmdd'),
        REMAINING_LIMIT     = tmpAMOUNT,
        AMOUNT_ID           = tmpIndAmountId,
        IS_IND_LIMIT        = 1,
        REMAINING_FREQUENCY = tmpFrequencyLength
      WHERE RELATIONSHIP_ID = tmpRelationshipId
      AND AMOUNT_ID         = tmpProdAmountId;
      l_InsertCount        := l_InsertCount + 1;
    END LOOP;
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    --COMMIT; --THIS COMMIT END THE SET TRANSACTION READ WRITE
    COMMIT; -- THIS COMMIT COMMITS DATA TO THE DB
    outRetVal := SQL%ROWCOUNT;
    outMsg    := outMsg || 'Rows added in TBLCFGLIMITAMOUNT,TBLINDLIMITINFO['||TO_CHAR(l_InsertCount)||'] Rows Updated in TBLREMAININGCARDLIMIT ['||TO_CHAR(l_InsertCount)||']';
  END spInsertLimit;
  PROCEDURE spUpdateLimit(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    tmpRelCursor REF_CURSOR;
    tmpRelationshipId      VARCHAR2(30);
    tmpCardNumber          VARCHAR2(30);
    tmpProductId           VARCHAR2(30);
    tmpExpiryDate          VARCHAR2(30);
    tmpCount               NUMBER;
    tmpAccountId           VARCHAR2(100);
    tmpCustomerId          VARCHAR2(100);
    tmpAmount              VARCHAR2(100);
    tmpProdAmountId        VARCHAR2(100);
    tmpFrequencyLength     VARCHAR2(100);
    tmpCycleLength         VARCHAR2(100);
    tmpFrequencyLengthType VARCHAR2(100);
    tmpCycleLengthType     VARCHAR2(100);
    tmpFrequencyQuota      VARCHAR2(100);
    tmpAmountSeqVal        VARCHAR2(100);
    tmpIndAmountId         VARCHAR2(100);
    varlimitCount          NUMBER; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  BEGIN
    outRetVal     := 0;
    VarLimitCount := 0; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    outMsg        := 'Executed Successfully';
    --SET TRANSACTION READ WRITE; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    --THE QUERY INSERTS DATA IN A TEMPORARY TABLE
    --THE DATA CONTAINS ALL THE INFORMATION ABOUT THE LIMITS TO BE UPDATED
    --IT ALSO IDENTIFIES THE UPDATE CASE TO BE APPLIED
    --THERE ARE THREE UPDATE CASES
    --PRODUCT TO INDIVIDUAL
    --AMOUNT UPDATE FOR INDIVIDUAL
    --REVERT BACK TO PRODUCT FROM INDIVIDUAL
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    SELECT COUNT(*)
    INTO varLimitCount
    FROM tblimptmplimits CARD
    WHERE card.actionflag = '02';
    IF VarLimitCount      > 0 THEN -- BY SR - Feb 22 - 2011 - Merged from ENBD
      INSERT
      INTO TBLLIMITUPDATE
        (
          CARDNUMBER,
          EXPIRYDATE,
          CHANNEL_ID,
          RELATIONSHIP_ID,
          ACCOUNT_ID,
          TRAN_CODE,
          HOSTAMOUNT,
          PRODUCTID,
          CUSTOMER_ID,
          PRODUCTAMOUNTID,
          PRODUCTAMOUNT,
          INDAMOUNTID,
          INDAMOUNT,
          IS_IND_LIMIT,
          LIMIT_UPDATE_CASE
        )
      SELECT DISTINCT HOSTLIMITS.CARDNUMBER,
        HOSTLIMITS.EXPIRYDATE,
        HOSTLIMITS.CHANNEL_ID,
        HOSTLIMITS.RELATIONSHIP_ID,
        HOSTLIMITS.ACCOUNT_ID,
        HOSTLIMITS.TRAN_CODE,
        HOSTLIMITS.HOSTAMOUNT,
        HOSTLIMITS.PRODUCTID,
        HOSTLIMITS.CUSTOMER_ID,
        PRODUCTLIMITS.PRODUCTAMOUNTID,
        PRODUCTLIMITS.PRODUCTAMOUNT,
        PRODUCTLIMITS.INDAMOUNTID,
        PRODUCTLIMITS.INDAMOUNT,
        PRODUCTLIMITS.IS_IND_LIMIT,
        CASE
          WHEN (IS_IND_LIMIT = 1)
          THEN
            CASE
              WHEN (TO_NUMBER(HOSTAMOUNT) = TO_NUMBER(PRODUCTAMOUNT))
              THEN 'REVERT_TO_PRODUCT'
              WHEN (TO_NUMBER(HOSTAMOUNT) = TO_NUMBER('+00000000000'))
              THEN 'REVERT_TO_PRODUCT' --If Amount is Set to Zero means we have to Revert back.
              WHEN (TO_NUMBER(HOSTAMOUNT) <> TO_NUMBER(INDAMOUNT)
              AND TO_NUMBER(HOSTAMOUNT)   <> TO_NUMBER(PRODUCTAMOUNT)
              AND TO_NUMBER(HOSTAMOUNT)   <> TO_NUMBER('+00000000000'))
              THEN 'IND_AMOUNT_UPDATE'
              WHEN (TO_NUMBER(HOSTAMOUNT) = TO_NUMBER(INDAMOUNT))
              THEN 'NO_UPDATE'
            END
          ELSE
            CASE
              WHEN (TO_NUMBER(HOSTAMOUNT) <> TO_NUMBER(PRODUCTAMOUNT)
              AND TO_NUMBER(HOSTAMOUNT)   <> TO_NUMBER('+00000000000'))
              THEN 'PRODUCT_TO_IND'
              ELSE 'NO_UPDATE'
            END
        END AS LIMIT_UPDATE_CASE
      FROM
        (SELECT TBLREMAININGCARDLIMIT.RELATIONSHIP_ID,
          TBLREMAININGCARDLIMIT.CARD_NUMBER,
          TBLREMAININGCARDLIMIT.EXPIRY_DATE,
          TBLREMAININGCARDLIMIT.IS_IND_LIMIT,
          TBLREMAININGCARDLIMIT.AMOUNT_ID AS PRODUCTAMOUNTID,
          TBLCFGLIMITAMOUNT.AMOUNT        AS PRODUCTAMOUNT,
          ''                              AS INDAMOUNTID,
          ''                              AS INDAMOUNT,
          TBLCFGLIMIT.TRAN_CODE,
          TBLCFGLIMIT.CHANNEL_ID,
          TBLCFGLIMIT.GROUP_ID AS PRODUCT_ID
        FROM TBLREMAININGCARDLIMIT
        INNER JOIN TBLCFGLIMIT
        ON TBLCFGLIMIT.AMOUNT_ID = TBLREMAININGCARDLIMIT.AMOUNT_ID
        INNER JOIN TBLCFGLIMITAMOUNT
        ON TBLCFGLIMITAMOUNT.AMOUNT_ID = TBLREMAININGCARDLIMIT.AMOUNT_ID
          ------------------------- Temporary added -------------------------
        INNER JOIN
          (SELECT CARD.CHANNEL_ID,
            CARD.RELATIONSHIP_ID
          FROM tblimptmplimits CARD
          WHERE card.actionflag = '02' -- BY SR - Feb 22 - 2011 - Merged from ENBD
          ) TempCard
        ON TempCard.RELATIONSHIP_ID = TBLREMAININGCARDLIMIT.RELATIONSHIP_ID
        WHERE TempCard.CHANNEL_ID   = TBLCFGLIMIT.Channel_id
        ------------------------- Temporary added -------------------------
        UNION
        SELECT TBLREMAININGCARDLIMIT.RELATIONSHIP_ID,
          TBLREMAININGCARDLIMIT.CARD_NUMBER,
          TBLREMAININGCARDLIMIT.EXPIRY_DATE,
          TBLREMAININGCARDLIMIT.IS_IND_LIMIT,
          TBLCFGLIMIT.AMOUNT_ID           AS PRODUCTAMOUNTID,
          TBLCFGLIMITAMOUNT2.AMOUNT       AS PRODUCTAMOUNT,
          TBLREMAININGCARDLIMIT.AMOUNT_ID AS INDAMOUNTID,
          TBLCFGLIMITAMOUNT.AMOUNT        AS INDAMOUNT,
          TBLINDLIMITINFO.TRAN_CODE,
          TBLINDLIMITINFO.CHANNEL_ID,
          TBLINDLIMITINFO.PRODUCT_ID
        FROM TBLREMAININGCARDLIMIT
        INNER JOIN TBLINDLIMITINFO
        ON TBLINDLIMITINFO.LIMIT_INFO_ID = TBLREMAININGCARDLIMIT.AMOUNT_ID
        INNER JOIN TBLCFGLIMITAMOUNT
        ON TBLCFGLIMITAMOUNT.AMOUNT_ID = TBLREMAININGCARDLIMIT.AMOUNT_ID
        INNER JOIN TBLCFGLIMIT
        ON TBLINDLIMITINFO.CHANNEL_ID  = TBLCFGLIMIT.CHANNEL_ID
        AND TBLINDLIMITINFO.TRAN_CODE  = TBLCFGLIMIT.TRAN_CODE
        AND TBLINDLIMITINFO.PRODUCT_ID = TBLCFGLIMIT.GROUP_ID
        INNER JOIN TBLCFGLIMITAMOUNT TBLCFGLIMITAMOUNT2
        ON TBLCFGLIMITAMOUNT2.AMOUNT_ID = TBLCFGLIMIT.AMOUNT_ID
          ------------------------- Temporary added -------------------------
        INNER JOIN
          (SELECT CARD.CHANNEL_ID,
            CARD.RELATIONSHIP_ID
          FROM tblimptmplimits CARD
          WHERE CARD.actionflag = '02' -- BY SR - Feb 22 - 2011 - Merged from ENBD
          ) TempCard
        ON TempCard.RELATIONSHIP_ID = TBLREMAININGCARDLIMIT.RELATIONSHIP_ID
        WHERE TempCard.CHANNEL_ID   = TBLCFGLIMIT.Channel_id
          ------------------------- Temporary added -------------------------
        ) PRODUCTLIMITS
      LEFT OUTER JOIN
        (SELECT CARD.CARD_NUMBER AS CARDNUMBER,
          CARD.EXPIRY_DATE       AS EXPIRYDATE,
          CARD.CHANNEL_ID,
          CARD.RELATIONSHIP_ID,
          CARD.ACCOUNT_ID,
          CARD.TRAN_CODE,
          CARD.AMOUNT AS HOSTAMOUNT,
          CARD.PRODUCTID,
          CARD.CUSTOMER_ID
        FROM tblimptmplimits CARD
        ) HOSTLIMITS
      ON HOSTLIMITS.TRAN_CODE        = PRODUCTLIMITS.TRAN_CODE
      AND HOSTLIMITS.CHANNEL_ID      = PRODUCTLIMITS.CHANNEL_ID
      AND HOSTLIMITS.RELATIONSHIP_ID = PRODUCTLIMITS.RELATIONSHIP_ID
      WHERE HOSTLIMITS.CARDNUMBER   IS NOT NULL;
      --APPLYING CASE 1
      --UPDATE INDIVIDUAL LIMIT TO PRODUCT
      --STEP 1- Update amount Id in tblremainingcardlimit to product amountid
      UPDATE TBLREMAININGCARDLIMIT
      SET AMOUNT_ID =
        ( SELECT DISTINCT TBLLIMITUPDATE.PRODUCTAMOUNTID
        FROM TBLLIMITUPDATE
        WHERE TBLLIMITUPDATE.RELATIONSHIP_ID = TBLREMAININGCARDLIMIT.RELATIONSHIP_ID
        AND TBLLIMITUPDATE.INDAMOUNTID       = TBLREMAININGCARDLIMIT.AMOUNT_ID
        AND TBLLIMITUPDATE.LIMIT_UPDATE_CASE = 'REVERT_TO_PRODUCT'
        ),
        IS_IND_LIMIT = 0
      WHERE EXISTS
        (SELECT *
        FROM TBLLIMITUPDATE
        WHERE TBLLIMITUPDATE.RELATIONSHIP_ID = TBLREMAININGCARDLIMIT.RELATIONSHIP_ID
        AND TBLLIMITUPDATE.INDAMOUNTID       = TBLREMAININGCARDLIMIT.AMOUNT_ID
        AND TBLLIMITUPDATE.LIMIT_UPDATE_CASE = 'REVERT_TO_PRODUCT'
        );
      --STEP 2- Delete information from tblindlimitinfo, tblcfglimitamount for the updated limits
      DELETE
      FROM TBLINDLIMITINFO
      WHERE LIMIT_INFO_ID IN
        (SELECT TBLLIMITUPDATE.INDAMOUNTID
        FROM TBLLIMITUPDATE
        WHERE TBLLIMITUPDATE.LIMIT_UPDATE_CASE = 'REVERT_TO_PRODUCT'
        );
      DELETE
      FROM TBLCFGLIMITAMOUNT
      WHERE AMOUNT_ID IN
        (SELECT TBLLIMITUPDATE.INDAMOUNTID
        FROM TBLLIMITUPDATE
        WHERE TBLLIMITUPDATE.LIMIT_UPDATE_CASE = 'REVERT_TO_PRODUCT'
        );
      --CASE 2:- UPDATE AMOUNT FOR AN INDIVIDUAL LIMIT
      UPDATE TBLCFGLIMITAMOUNT
      SET AMOUNT =
        ( SELECT DISTINCT TBLLIMITUPDATE.HOSTAMOUNT
        FROM TBLLIMITUPDATE
        WHERE TBLLIMITUPDATE.INDAMOUNTID     = TBLCFGLIMITAMOUNT.AMOUNT_ID
        AND TBLLIMITUPDATE.LIMIT_UPDATE_CASE = 'IND_AMOUNT_UPDATE'
        )
      WHERE TBLCFGLIMITAMOUNT.AMOUNT_ID =
        (SELECT TBLLIMITUPDATE.INDAMOUNTID
        FROM TBLLIMITUPDATE
        WHERE TBLLIMITUPDATE.LIMIT_UPDATE_CASE = 'IND_AMOUNT_UPDATE'
        );
      --CASE 3:-  PRODUC BASED LIMIT TO INDIVIDUWAL LIMIT
      OPEN tmpRelCursor FOR
      SELECT DISTINCT TBLLIMITUPDATE.CARDNUMBER,
        TBLLIMITUPDATE.EXPIRYDATE,
        TBLLIMITUPDATE.RELATIONSHIP_ID,
        TBLLIMITUPDATE.ACCOUNT_ID,
        TBLLIMITUPDATE.PRODUCTID,
        TBLLIMITUPDATE.CUSTOMER_ID,
        TBLLIMITUPDATE.HOSTAMOUNT,
        TBLLIMITUPDATE.PRODUCTAMOUNTID,
        TBLCFGLIMITAMOUNT.CYCLE_LENGTH,
        TBLCFGLIMITAMOUNT.CYCLE_LENGTH_TYPE,
        TBLCFGLIMITAMOUNT.FREQUENCY_LENGTH,
        TBLCFGLIMITAMOUNT.FREQUENCY_LENGTH_TYPE,
        TBLCFGLIMITAMOUNT.FREQUENCY_QUOTA
      FROM TBLLIMITUPDATE
      INNER JOIN TBLCFGLIMITAMOUNT
      ON TBLLIMITUPDATE.PRODUCTAMOUNTID      = TBLCFGLIMITAMOUNT.AMOUNT_ID
      WHERE TBLLIMITUPDATE.LIMIT_UPDATE_CASE = 'PRODUCT_TO_IND';
      LOOP
        FETCH tmpRelCursor
        INTO tmpCardNumber,
          tmpExpiryDate,
          tmpRelationshipId,
          tmpAccountId,
          tmpProductId,
          tmpCustomerId,
          tmpAmount,
          tmpProdAMountId,
          tmpCycleLength,
          tmpCycleLengthType,
          tmpFrequencyLength,
          tmpFrequencyLengthType,
          tmpFrequencyQuota;
        EXIT
      WHEN tmpRelCursor %NOTFOUND;
        SELECT SEQ_LIMITAMOUNT.NEXTVAL INTO tmpIndAmountId FROM DUAL;
        --INSERT A NEW AMOUNT IN THE DATABASE FOR ALL INDIVIDUAL LIMITS
        --ALSO INSERT ROWS IN TBLCFGLIMIT
        INSERT
        INTO TBLCFGLIMITAMOUNT
          (
            AMOUNT_ID,
            AMOUNT,
            CYCLE_LENGTH,
            FREQUENCY_QUOTA,
            FREQUENCY_LENGTH,
            CYCLE_LENGTH_TYPE,
            FREQUENCY_LENGTH_TYPE
          )
          VALUES
          (
            tmpIndAmountId,
            tmpAmount,
            tmpCycleLength,
            tmpFrequencyQuota,
            tmpFrequencyLength,
            tmpCycleLengthType,
            tmpFrequencyLengthType
          );
        INSERT
        INTO TBLINDLIMITINFO
          (
            LIMIT_INFO_ID,
            TRAN_CODE,
            CHANNEL_ID,
            PRODUCT_ID
          )
        SELECT tmpIndAmountId,
          TBLCFGLIMIT.TRAN_CODE,
          TBLCFGLIMIT.CHANNEL_ID,
          tmpProductId
        FROM TBLCFGLIMIT
        WHERE TBLCFGLIMIT.GROUP_ID = tmpProductId
        AND TBLCFGLIMIT.AMOUNT_ID  = tmpProdAmountId;
        --update the record in tblremainingcardlimit
        UPDATE TBLREMAININGCARDLIMIT
        SET CYCLE_BEGIN_DATE  = TO_CHAR(SYSDATE,'yyyymmdd'),
          REMAINING_LIMIT     = tmpAMOUNT,
          AMOUNT_ID           = tmpIndAmountId,
          IS_IND_LIMIT        = 1,
          REMAINING_FREQUENCY = tmpFrequencyLength
        WHERE RELATIONSHIP_ID = tmpRelationshipId
        AND AMOUNT_ID         = tmpProdAmountId;
      END LOOP;
      -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --COMMIT; --THIS COMMIT END THE SET TRANSACTION READ WRITE
      COMMIT; -- THIS COMMIT COMMITS DATA TO THE DB
      outRetVal := 1;
    END IF; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    outRetVal := SQL%ROWCOUNT;
    --commit;
    COMMIT;
  END spUpdateLimit;
  PROCEDURE spInsertCurrency(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
  BEGIN
    --SET TRANSACTION READ WRITE; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    INSERT
    INTO TBLCFGCURRENCY
      (
        CODE,
        DESCRIPTION,
        SYMBOL,
        DECIMALS,
        BUY_RATE_CASH,
        IS_BASE_CURR,
        SELL_RATE_CASH,
        MODIFICATION_DATE,
        BUY_RATE_XFER,
        SELL_RATE_XFER,
        IS_ATM_CURR,
        institutionid,
        currencyid
      )
    SELECT CODE,
      DESCRIPTION,
      SYMBOL,
      DECIMALS,
      BUY_RATE_CASH,
      0,
      SELL_RATE_CASH,
      TO_CHAR(sysdate,'yyyymmdd'),
      BUY_RATE_XFER,
      SELL_RATE_XFER,
      0,
      CURRENCY.INSTITUTIONID,
      SEQ_CURRENCYID.NEXTVAL
    FROM tblimptmpcurrency_object CURRENCY
    WHERE CURRENCY.ACTIONFLAG = '02';
    outRetVal                := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    --  commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spInsertCurrency;
  PROCEDURE spUpdateCurrency(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inIS_ATM_CURR t_is_atm_curr             := t_is_atm_curr();
    inMODIFICATION_DATE t_modification_date := t_modification_date();
    inBUY_RATE_XFER t_buy_rate_xfer         := t_buy_rate_xfer();
    inSELL_RATE_XFER t_sell_rate_xfer       := t_sell_rate_xfer();
    inCODE t_code                           := t_code();
    inDESCRIPTION t_description             := t_description();
    inSYMBOL t_symbol                       := t_symbol();
    inDECIMALS t_decimals                   := t_decimals();
    inBUY_RATE_CASH t_buy_rate_cash         := t_buy_rate_cash();
    inSELL_RATE_CASH t_sell_rate_cash       := t_sell_rate_cash();
    inIS_BASE_CURR t_is_base_curr           := t_is_base_curr();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --  SET TRANSACTION READ WRITE; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    SELECT TO_CHAR(sysdate,'yyyymmdd'),
      BUY_RATE_XFER,
      SELL_RATE_XFER,
      CODE,
      DESCRIPTION,
      SYMBOL,
      DECIMALS,
      BUY_RATE_CASH,
      SELL_RATE_CASH BULK COLLECT
    INTO inMODIFICATION_DATE,
      inBUY_RATE_XFER,
      inSELL_RATE_XFER,
      inCODE,
      inDESCRIPTION,
      inSYMBOL,
      inDECIMALS,
      inBUY_RATE_CASH,
      inSELL_RATE_CASH
    FROM tblimptmpcurrency_object CURRENCY
    WHERE CURRENCY.ACTIONFLAG = '02';
    outRetVal                := inCODE.count;
    FORALL i IN inCODE.FIRST..inCODE.LAST
    UPDATE TBLCFGCURRENCY
    SET MODIFICATION_DATE     = inMODIFICATION_DATE(i),
      BUY_RATE_XFER           = inBUY_RATE_XFER(i),
      SELL_RATE_XFER          = inSELL_RATE_XFER(i),
      DECIMALS                = inDECIMALS(i),
      BUY_RATE_CASH           = inBUY_RATE_CASH(i),
      SELL_RATE_CASH          = inSELL_RATE_CASH(i)
    WHERE TBLCFGCURRENCY.CODE = inCODE(i);
    outRetVal                := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spUpdateCurrency;
  PROCEDURE spDeleteCustomer(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inCUSTOMERID T_CUST_CUSTOMERID:= T_CUST_CUSTOMERID();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SELECT CUSTOMER.CUSTOMERID bulk collect
    INTO inCUSTOMERID
    FROM tblimptmpcustomer CUSTOMER
    WHERE CUSTOMER.ACTIONFLAG = '03'
    AND CUSTOMER.FAILED      IS NULL;
    outRetVal                := inCUSTOMERID.count;
    FORALL i IN inCUSTOMERID.FIRST..inCUSTOMERID.LAST
    UPDATE TBLCUSTOMER
    SET STATUS                         = INACTIVE_CUSTOMER
    WHERE TRIM(TBLCUSTOMER.CUSTOMERID) = TRIM(inCUSTOMERID(i));
    outRetVal                         := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spDeleteCustomer;
  PROCEDURE spDeleteAccount(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inACCOUNT_ID T_ACCT_ACCOUNT_ID             := T_ACCT_ACCOUNT_ID();
    inACCOUNT_TYPE T_ACCT_ACCOUNT_TYPE         := T_ACCT_ACCOUNT_TYPE();
    inACCOUNT_CURRENCY T_ACCT_ACCOUNT_CURRENCY := T_ACCT_ACCOUNT_CURRENCY();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SELECT ACCOUNT."ACCOUNT_ID",
      ACCOUNT."ACCOUNT_TYPE" ,
      ACCOUNT."ACCOUNT_CURRENCY" BULK COLLECT
    INTO inACCOUNT_ID,
      inACCOUNT_TYPE,
      inACCOUNT_CURRENCY
    FROM tblimptmpaccount ACCOUNT
    WHERE ACCOUNT.ACTIONFLAG = '03'
    AND ACCOUNT.FAILED      IS NULL;
    FORALL i IN inACCOUNT_ID.FIRST..inACCOUNT_ID.LAST
    UPDATE TBLACCOUNT
    SET STATUS                        = INACTIVE_ACCOUNT
    WHERE TRIM(TBLACCOUNT.ACCOUNT_ID) = inACCOUNT_ID(i)
    AND ACCOUNT_TYPE                  = inACCOUNT_TYPE (i)
    AND ACCOUNT_CURRENCY              = inACCOUNT_CURRENCY (i);
    outRetVal                        := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spDeleteAccount;
  PROCEDURE spDeleteCard(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inRelationshipId t_relationship_id:=t_relationship_id();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SELECT CARD.CARDNUMBER
      || '='
      || SUBSTR(EXPIRYDATE,3,4) bulk collect
    INTO inRelationshipId
    FROM tblimptmpcard CARD
    WHERE CARD.ACTIONFLAG = '03'
    AND CARD.FAILED      IS NULL;
    outRetVal            := inRelationshipId.count;
    FORALL i IN inRelationshipId.FIRST..inRelationshipId.LAST
    UPDATE TBLRELATIONSHIPAUTH
    SET STATUS                 = HOT_CARD
    WHERE RELATIONSHIPAUTH_ID IN
      (SELECT RELATIONSHIPAUTH_ID
      FROM TBLCUSTCHANNELACCT
      INNER JOIN TBLCFGCHANNEL
      ON TBLCUSTCHANNELACCT.CHANNEL_ID         = TBLCFGCHANNEL.CHANNELID
      WHERE TBLCUSTCHANNELACCT.RELATIONSHIP_ID = inRelationshipId(i)
      AND TBLCFGCHANNEL.CARDREQUIRED           = 'Y'
      );
    outRetVal := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spDeleteCard;
  PROCEDURE spDeleteRelation(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inCHANNEL_ID T_REL_CHANNEL_ID             := T_REL_CHANNEL_ID();
    inRELATIONSHIP_ID T_REL_RELATIONSHIP_ID   := T_REL_RELATIONSHIP_ID();
    inACCOUNT_ID T_REL_ACCOUNT_ID             := T_REL_ACCOUNT_ID();
    inACCOUNT_TYPE T_REL_ACCOUNT_TYPE         := T_REL_ACCOUNT_TYPE();
    inACCOUNT_CURRENCY T_REL_ACCOUNT_CURRENCY := T_REL_ACCOUNT_CURRENCY();
    inCUSTOMER_ID T_REL_CUSTOMER_ID           := T_REL_CUSTOMER_ID();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    -------------Account Delinking --------------------------------------------------------------------------------------
    SELECT ACCOUNT_REL.CHANNEL_ID,
      ACCOUNT_REL.RELATIONSHIP_ID,
      ACCOUNT_REL.ACCOUNT_ID,
      ACCOUNT_REL.TYPE,
      ACCOUNT_REL.CURRENCY,
      ACCOUNT_REL.CUSTOMER_ID bulk collect
    INTO inCHANNEL_ID ,
      inRELATIONSHIP_ID ,
      inACCOUNT_ID ,
      inACCOUNT_TYPE ,
      inACCOUNT_CURRENCY ,
      inCUSTOMER_ID
    FROM tblimptmpaccount_rel ACCOUNT_REL
    WHERE ACCOUNT_REL.ACTIONFLAG = '03'
    AND ACCOUNT_REL.FAILED      IS NULL
    GROUP BY ACCOUNT_ID,
      TYPE,
      CURRENCY,
      CUSTOMER_ID,
      CHANNEL_ID,
      RELATIONSHIP_ID;
    FOR i IN 1..inACCOUNT_ID.COUNT
    LOOP
      --if channel is 0000 then delete from all the channels
      DELETE TBLCUSTCHANNELACCT
      WHERE RELATIONSHIP_ID = inRELATIONSHIP_ID(i)
      AND CUSTOMER_ID       = inCUSTOMER_ID(i)
      AND TRIM(ACCOUNT_ID)  = inACCOUNT_ID(i)
      AND ACCOUNT_TYPE      = inACCOUNT_TYPE(i)
      AND ACCOUNT_CURRENCY  = inACCOUNT_CURRENCY(i)
      AND CHANNEL_ID       <> '9999'
      AND inCHANNEL_ID(i)   = '0000';
      outRetVal            := outRetVal + SQL%ROWCOUNT;
      --otherwise on that particular channel only
      DELETE TBLCUSTCHANNELACCT
      WHERE RELATIONSHIP_ID = inRELATIONSHIP_ID(i)
      AND CUSTOMER_ID       = inCUSTOMER_ID(i)
      AND TRIM(ACCOUNT_ID)  = inACCOUNT_ID(i)
      AND ACCOUNT_TYPE      = inACCOUNT_TYPE(i)
      AND ACCOUNT_CURRENCY  = inACCOUNT_CURRENCY(i)
      AND CHANNEL_ID        = inCHANNEL_ID(i)
      AND CHANNEL_ID       <> '9999'
      AND inCHANNEL_ID(i)  <> '0000';
      outRetVal            := outRetVal + SQL%ROWCOUNT;
    END LOOP;
    -------------------------------------------------------------------------------------------------------------------
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    --commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spDeleteRelation;
  PROCEDURE spInsertAccountLimit(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
  BEGIN
    --SET TRANSACTION READ WRITE; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    INSERT
    INTO TBLREMAININGACCOUNTLIMIT
      (
        ACCOUNT_ID ,
        ACCOUNT_TYPE ,
        ACCOUNT_CURRENCY,
        CYCLE_BEGIN_DATE,
        REMAINING_LIMIT ,
        AMOUNT_ID ,
        IS_INDIVIDUAL
      )
    SELECT UIPKGACCOUNT.fnTrnasformAccount(ACCOUNTLIMIT.INSTITUTIONID, ACCOUNTLIMIT.ACCOUNT_ID), --fahad RPAD(ACCOUNTLIMIT.ACCOUNT_ID,20)      ,
      ACCOUNTLIMIT.ACCOUNT_TYPE ,
      ACCOUNTLIMIT.ACCOUNT_CURRENCY,
      ACCOUNTLIMIT.CYCLE_BEGIN_DATE,
      ACCOUNTLIMIT.REMAINING_LIMIT ,
      ACCOUNTLIMIT.AMOUNT_ID ,
      ACCOUNTLIMIT.IS_INDIVIDUAL
    FROM tblimptmpaccountlimit ACCOUNTLIMIT
    WHERE ACCOUNTLIMIT.ACTIONFLAG = '01'
    AND ACCOUNTLIMIT.FAILED      IS NULL;
    outRetVal                    := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spInsertAccountLimit;
  PROCEDURE spInsertCardLimit(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    -- SET TRANSACTION READ WRITE; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLREMAININGCARDLIMIT
      (
        CARD_NUMBER,
        EXPIRY_DATE,
        AMOUNT_ID,
        CYCLE_BEGIN_DATE,
        REMAINING_LIMIT,
        IS_IND_LIMIT,
        RELATIONSHIP_ID,
        REMAINING_FREQUENCY,
        frequency_begin_date
      )
    SELECT DISTINCT LIMITS.CARD_NUMBER,
      LIMITS.EXPIRY_DATE,
      LIMITS.AMOUNT_ID,
      LIMITS.CYCLE_BEGIN_DATE,
      LIMITS.REMAINING_LIMIT,
      LIMITS.IS_IND_LIMIT,
      LIMITS.RELATIONSHIP_ID,
      LIMITS.REMAINING_FREQUENCY,
      TO_CHAR(sysdate,'YYYYMMDD')
    FROM tblimptmplimits LIMITS
    WHERE LIMITS.ACTIONFLAG = '01'
    AND LIMITS.FAILED      IS NULL;
    outRetVal              := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spInsertCardLimit;
  PROCEDURE spInsertProductionCycle(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
  BEGIN
    --SET TRANSACTION READ WRITE; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    INSERT
    INTO TBLPRODUCTION
      (
        RELATIONSHIP_ID,
        CHANNEL_ID,
        ROW_ID,
        STAGE,
        ISFORCED
      )
    SELECT PRODUCTIONSTAGE.RELATIONSHIP_ID,
      PRODUCTIONSTAGE.CHANNEL_ID,
      SEQCARDPRODUCTION.NEXTVAL,
      PRODUCTIONSTAGE.STAGE,
      PRODUCTIONSTAGE.ISFORCED
    FROM tblimptmpproductionstage PRODUCTIONSTAGE
    WHERE PRODUCTIONSTAGE.ACTIONFLAG = '01'
    AND PRODUCTIONSTAGE.FAILED      IS NULL;
    outRetVal                       := SQL%ROWCOUNT;
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    COMMIT;
    --commit;
  END spInsertProductionCycle;
  PROCEDURE spInsertCustomerLimit(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --SET TRANSACTION READ WRITE;
    INSERT
    INTO TBLREMAININGCUSTOMERLIMIT
      (
        CUSTOMER_ID,
        AMOUNT_ID,
        CYCLE_BEGIN_DATE,
        REMAINING_LIMIT,
        IS_IND_LIMIT,
        REMAINING_FREQUENCY
      )
    SELECT CUSTOMERLIMIT.CUSTOMER_ID,
      CUSTOMERLIMIT.AMOUNT_ID,
      CUSTOMERLIMIT.CYCLE_BEGIN_DATE,
      CUSTOMERLIMIT.REMAINING_LIMIT,
      CUSTOMERLIMIT.IS_IND_LIMIT,
      CUSTOMERLIMIT.REMAINING_FREQUENCY
    FROM tblimptmpcustomerlimit CUSTOMERLIMIT
    WHERE CUSTOMERLIMIT.ACTIONFLAG = '01'
    AND CUSTOMERLIMIT.FAILED      IS NULL;
    outRetVal                     := SQL%ROWCOUNT;
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    COMMIT;
    --commit;
  END spInsertCustomerLimit;
  PROCEDURE spInsertRelAuth(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --SET TRANSACTION READ WRITE; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLRELATIONSHIPAUTH
      (
        RELATIONSHIPAUTH_ID,
        PIN ,
        MAXRETRIES ,
        REMRETRIES ,
        STATUS ,
        PIN_GEN_DATE,
        REASONCODE --fahad 20100721 for reason code
      )
    SELECT DISTINCT(RELAUTH.RELATIONSHIPAUTH_ID),
      NVL(RELAUTH.PIN,'    ') ,
      RELAUTH.MAXRETRIES ,
      RELAUTH.REMRETRIES ,
      RELAUTH.STATUS ,
      RELAUTH.PIN_GEN_DATE, --fahad 20100721 for reason code
      (SELECT reasoncode
      FROM tblcfgcardstatusreason
      WHERE isdefault='1'
      AND statuscode =RELAUTH.STATUS
      AND rownum     <2
      ) AS REASONCODE
    FROM TBLIMPTMPREL_AUTH RELAUTH
    WHERE NVL(RELAUTH.ACTIONFLAG,'01') = '01' ---Fariha 20101029 To select only records that need to be added
      --RELAUTH.ACTIONFLAG = '01' --in bicec/bci relauth dont have 01 in this and this is commented there
    AND RELAUTH.FAILED IS NULL;
    outRetVal          := SQL%ROWCOUNT;
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    COMMIT;
    --commit;
  END spInsertRelAuth;
/*
***************************************************************************
Created By  : Fariha Akhtar
Dated       : 26-Oct-2010
Description : To update PIN and PIN_GEN_DATE in tblrelationshipauth from
tblimptmppinoffset
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spUpdateRelAuth(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    -- SET TRANSACTION READ WRITE;
    /* UPDATE TBLRELATIONSHIPAUTH ra
    SET
    (
    PIN ,
    MAXRETRIES ,
    REMRETRIES ,
    STATUS ,
    PIN_GEN_DATE,
    REASONCODE --fahad 20100721 for reason code
    )
    =
    (SELECT NVL(RELAUTH.PIN,'    ') ,
    RELAUTH.MAXRETRIES ,
    RELAUTH.REMRETRIES ,
    RELAUTH.STATUS ,
    RELAUTH.PIN_GEN_DATE, --fahad 20100721 for reason code
    (SELECT reasoncode
    FROM tblcfgcardstatusreason
    WHERE isdefault='1'
    AND statuscode =RELAUTH.STATUS
    AND rownum     <2
    ) AS REASONCODE
    FROM tblimptmprel_auth RELAUTH
    WHERE RELAUTH.ACTIONFLAG   = '02'
    AND RELAUTH.FAILED        IS NULL
    AND ra.RELATIONSHIPAUTH_ID = RELAUTH.relationshipauth_ID
    )
    WHERE ra.relationshipauth_id IN
    (select RELATIONSHIPAUTH_ID from TBLIMPTMPREL_AUTH
    --    --</Merge Author: Zainab TrackerID: bug1876><ADD Binish 27-09-2012 BRAC Phoenix Migration>
    ----FARIHA: Uncommenting brac change as it sets status and retries to null in case of new card insertion
    where TBLIMPTMPREL_AUTH.ACTIONFLAG   = '02'
    and TBLIMPTMPREL_AUTH.failed        is null
    --    --</ADD></Merge>
    );
    outRetVal := SQL%ROWCOUNT;
    COMMIT; */
    ---- Aadil to cater softrecarding
    UPDATE TBLRELATIONSHIPAUTH ra
    SET
      (
        PIN ,
        MAXRETRIES ,
        REMRETRIES ,
        STATUS ,
        PIN_GEN_DATE,
        REASONCODE --fahad 20100721 for reason code
      )
      =
      (SELECT NVL(RELAUTH.PIN,'    ') ,
        RELAUTH.MAXRETRIES ,
        RELAUTH.REMRETRIES ,
        RELAUTH.STATUS ,
        RELAUTH.PIN_GEN_DATE, --fahad 20100721 for reason code
        (SELECT reasoncode
        FROM tblcfgcardstatusreason
        WHERE isdefault='1'
        AND statuscode =RELAUTH.STATUS
        AND rownum     <2
        ) AS REASONCODE
      FROM tblimptmprel_auth RELAUTH,
        tblimptmpcard CARD
      WHERE CARD.ACTIONFLAG       = '02'
      AND RELAUTH.ACTIONFLAG      = '02'
      AND CARD.FAILED            IS NULL
      AND RELAUTH.FAILED         IS NULL
      AND CARD.relationship_id    =RELAUTH.relationship_id
      AND ra.RELATIONSHIPAUTH_ID  = RELAUTH.relationshipauth_ID
      AND CARD.regeneration_type != '12'
        /*Non Soft Recarding cases added by Adil*/
      AND CARD.destination_productid IS NULL
        /*Non Soft Recarding cases added by Adil*/
      )
    WHERE ra.relationshipauth_id IN
      (SELECT TBLIMPTMPREL_AUTH.RELATIONSHIPAUTH_ID
      FROM TBLIMPTMPREL_AUTH,
        tblimptmpcard
        --    --</Merge Author: Zainab TrackerID: bug1876><ADD Binish 27-09-2012 BRAC Phoenix Migration>
        ----FARIHA: Uncommenting brac change as it sets status and retries to null in case of new card insertion
      WHERE TBLIMPTMPREL_AUTH.ACTIONFLAG   = '02'
      AND tblimptmpcard.ACTIONFLAG         = '02'
      AND TBLIMPTMPREL_AUTH.failed        IS NULL
      AND tblimptmpcard.failed            IS NULL
      AND tblimptmpcard.relationship_id    =TBLIMPTMPREL_AUTH.relationship_id
      AND tblimptmpcard.regeneration_type != '12'
        /*Non Soft Recarding cases added by Adil*/
      AND tblimptmpcard.destination_productid IS NULL
        /*Non Soft Recarding cases added by Adil*/
      );
    UPDATE TBLRELATIONSHIPAUTH ra
    SET
      (
        STATUS ,
        REASONCODE
      )
      =
      (SELECT RELAUTH.STATUS ,
        (SELECT reasoncode
        FROM tblcfgcardstatusreason
        WHERE isdefault='1'
        AND statuscode =RELAUTH.STATUS
        AND rownum     <2
        ) AS REASONCODE
      FROM tblimptmprel_auth RELAUTH,
        tblimptmpcard CARD
      WHERE CARD.ACTIONFLAG           = '02'
      AND RELAUTH.ACTIONFLAG          = '02'
      AND CARD.FAILED                IS NULL
      AND RELAUTH.FAILED             IS NULL
      AND CARD.existingcardnumber     =RELAUTH.relationship_id
      AND ra.RELATIONSHIPAUTH_ID      = RELAUTH.relationshipauth_ID
      AND CARD.regeneration_type      = '12'
      AND CARD.destination_productid IS NOT NULL
      AND rownum                      = 1
        /*Added by Adil*/
      )
    WHERE ra.relationshipauth_id IN
      (SELECT TBLIMPTMPREL_AUTH.RELATIONSHIPAUTH_ID
      FROM TBLIMPTMPREL_AUTH,
        tblimptmpcard
      WHERE TBLIMPTMPREL_AUTH.ACTIONFLAG       = '02'
      AND tblimptmpcard.ACTIONFLAG             = '02'
      AND TBLIMPTMPREL_AUTH.failed            IS NULL
      AND tblimptmpcard.failed                IS NULL
      AND tblimptmpcard.existingcardnumber     =TBLIMPTMPREL_AUTH.relationship_id
      AND tblimptmpcard.regeneration_type      = '12'
      AND tblimptmpcard.destination_productid IS NOT NULL
      );
    Outretval := Sql%Rowcount;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK; --removed by Mx
      --Test update error code
      errorCode := SQLCODE;
      errorDesc := SQLERRM;
      UPDATE tblimptmprel_auth
      SET tblimptmprel_auth.FAILED = '1',
        err_code                   = errorCode,
        err_description            = errorDesc;
      COMMIT;
      outRetVal := 0;
    END;
  END spUpdateRelAuth;
  PROCEDURE spInsertCorporate(
      inXML IN CLOB,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    DELETE
    FROM XML_DOCUMENT_TABLE
    WHERE XML_DOCUMENT_TABLE.FILENAME = 'CorporateData.xml';
    COMMIT;
    INSERT INTO XML_DOCUMENT_TABLE VALUES
      ('CorporateData.xml',xmltype(inXML)
      );
    COMMIT;
    INSERT INTO TBLCORPORATE
    SELECT CORPORATE."CORPORATE_ID",
      CORPORATE."NAME",
      CORPORATE."STATUS",
      TO_CHAR(sysdate,'yyyymmddhh24miss')
    FROM XML_DOCUMENT_TABLE,
      XMLTABLE('/NewDataSet/CORPORATE' PASSING XML_DOCUMENT_TABLE.XML_DOCUMENT COLUMNS "CORPORATE_ID" VARCHAR(100) PATH '/CORPORATE/CORPORATE_ID', "NAME" VARCHAR(100) PATH '/CORPORATE/NAME', "STATUS" VARCHAR(100) PATH '/CORPORATE/STATUS' ) CORPORATE
    WHERE XML_DOCUMENT_TABLE.FILENAME = 'CorporateData.xml' ;
    outRetVal                        := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spInsertCorporate;
  PROCEDURE spUpdateCorporate(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inCORPORATE_ID T_CORP_CORPORATEID :=T_CORP_CORPORATEID();
    inNAME T_CORP_NAME                :=T_CORP_NAME();
    inSTATUS T_CORP_STATUS            :=T_CORP_STATUS();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SELECT CORPORATE."CORPORATE_ID",
      CORPORATE."NAME",
      CORPORATE."STATUS" bulk collect
    INTO inCORPORATE_ID ,
      inNAME ,
      inSTATUS
    FROM TBLIMPTMPCORPORATE CORPORATE;
    FORALL i IN inCORPORATE_ID.FIRST..inCORPORATE_ID.LAST
    UPDATE TBLCORPORATE
    SET STATUS                     = inSTATUS (i),
      NAME                         = inNAME (i),
      LASTUPDATEDATE               =TO_CHAR(sysdate,'yyyymmddhh24miss')
    WHERE TBLCORPORATE.CORPORATE_ID= inCORPORATE_ID(i);
    outRetVal                     := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spUpdateCorporate;
  PROCEDURE spUpdateAccountBalance(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inTITLE T_ACCT_TITLE                        := T_ACCT_TITLE();
    inSTATUS T_ACCT_STATUS                      := T_ACCT_STATUS();
    inACTUAL_BALANCE T_ACCT_ACTUAL_BALANCE      := T_ACCT_ACTUAL_BALANCE();
    inACCOUNT_ID T_ACCT_ACCOUNT_ID              := T_ACCT_ACCOUNT_ID();
    inACCOUNT_TYPE T_ACCT_ACCOUNT_TYPE          := T_ACCT_ACCOUNT_TYPE();
    inACCOUNT_CURRENCY T_ACCT_ACCOUNT_CURRENCY  := T_ACCT_ACCOUNT_CURRENCY();
    inLAST_UPDATED T_ACCT_LAST_UPDATED          := T_ACCT_LAST_UPDATED();
    inBRANCHID T_ACCT_BRANCHID                  := T_ACCT_BRANCHID();
    inAVAILABLE_BALANCE T_ACCT_AVAILABLE_BALANCE:= T_ACCT_AVAILABLE_BALANCE();
    inOLDACCOUNT_ID T_ACCT_OLDACCOUNT_ID        := T_ACCT_OLDACCOUNT_ID();
    inINTERNAL_BRANCH_ID T_INTERNAL_BRANCH_ID   := T_INTERNAL_BRANCH_ID();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SELECT ACCOUNT_BALANCE."STATUS" ,
      ACCOUNT_BALANCE."ACCOUNTID" , --ACCOUNT_BALANCE."ACCOUNT_ID"       ,
      ACCOUNT_BALANCE."TYPE" ,      --ACCOUNT_BALANCE."ACCOUNT_TYPE"     ,
      ACCOUNT_BALANCE."CURRENCY" ,  --ACCOUNT_BALANCE."ACCOUNT_CURRENCY" ,
      ACCOUNT_BALANCE."ACTUAL_BALANCE" ,
      ACCOUNT_BALANCE."AVAILABLE_BALANCE" bulk collect
    INTO inSTATUS ,
      inACCOUNT_ID ,
      inACCOUNT_TYPE ,
      inACCOUNT_CURRENCY ,
      inACTUAL_BALANCE ,
      inAVAILABLE_BALANCE
    FROM tblimptmpaccount_balance ACCOUNT_BALANCE
    WHERE ACCOUNT_BALANCE.ACTIONFLAG = '02'
    AND ACCOUNT_BALANCE.FAILED      IS NULL;
    FORALL i IN 1..inACCOUNT_ID.COUNT
    UPDATE TBLACCOUNT
    SET STATUS          = inSTATUS (i),
      ACTUAL_BALANCE    = TO_CHAR( TO_NUMBER(inACTUAL_BALANCE (i)) ),-- - NVL(TO_NUMBER(amt_tran_sum),0) ),
      LAST_UPDATED      = TO_CHAR(sysdate,'yyyymmdd'),
      AVAILABLE_BALANCE = TO_CHAR( TO_NUMBER(inAVAILABLE_BALANCE(i)) )-- - NVL(TO_NUMBER(amt_tran_sum),0) ),
      --is_settled        = '1',
      --amt_tran_sum      = '0'
    WHERE (TBLACCOUNT.ACCOUNT_ID) = (inACCOUNT_ID(i)) -- trim removed due to performance as all balances comes at once, it is transformed in datacopy
    AND ACCOUNT_TYPE              = inACCOUNT_TYPE (i)
    AND ACCOUNT_CURRENCY          = inACCOUNT_CURRENCY (i);
    outRetVal                    := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spUpdateAccountBalance;
  PROCEDURE spInsertALFromMultiLO(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    tmpRelCursor REF_CURSOR;
    tmpTranCode            VARCHAR2(100);
    tmpProductId           VARCHAR2(100);
    tmpCycleLength         VARCHAR2(100);
    tmpFrequencyLengthType VARCHAR2(100);
    tmpFrequencyLength     VARCHAR2(100);
    tmpCycleLengthType     VARCHAR2(100);
    tmpFrequencyQuota      VARCHAR2(100);
    tmpAmount              VARCHAR2(100);
    tmpProdAmountId        VARCHAR2(100);
    tmpImpAmount           VARCHAR2(100);
    tmpAmountSeqVal        VARCHAR2(100);
    tmpIndAmountId         VARCHAR2(100);
    tmpAccountId           VARCHAR2(100);
    tmpAccountType         VARCHAR2(100);
    tmpAccountCurrency     VARCHAR2(100);
    tmpInstitutionId       VARCHAR2(100);
    tmpActionFlag          VARCHAR2(100);
    l_InsertCount          NUMBER;
    l_InsertIndCount       NUMBER;
  BEGIN
    outRetVal        := 0;
    outMsg           := 'Executed Successfully';
    l_InsertCount    :=0;
    l_InsertIndCount :=0;
    OPEN tmpRelCursor FOR SELECT
    --              ACCOUNTLIMIT.EXPIRY_DATE    ,
    ACCOUNTLIMIT.TRAN_CODE,
    ACCOUNTLIMIT.PRODUCT_ID,
    --              ACCOUNTLIMIT.LIMITTYPE ,
    ACCOUNTLIMIT.CYCLE_LENGTH ,
    ACCOUNTLIMIT.FREQUENCY_QUOTA ,
    ACCOUNTLIMIT.FREQUENCY_LENGTH ,
    ACCOUNTLIMIT.CYCLE_LENGTH_TYPE ,
    ACCOUNTLIMIT.FREQUENCY_LENGTH_TYPE ,
    ACCOUNTLIMIT.IMPORTAMOUNT ,
    ACCOUNTLIMIT.AMOUNT ,
    ACCOUNTLIMIT.ACCOUNT_ID ,
    ACCOUNTLIMIT.ACCOUNT_TYPE ,
    ACCOUNTLIMIT.ACCOUNT_CURRENCY ,
    --              ACCOUNTLIMIT.CUSTOMER_ID ,
    ACCOUNTLIMIT.AMOUNT_ID ,
    ACCOUNTLIMIT.ACTIONFLAG ,
    ACCOUNTLIMIT.INSTITUTIONID FROM tblimptmpmultilimitsobj ACCOUNTLIMIT WHERE ACCOUNTLIMIT.ACTIONFLAG = '01' AND ACCOUNTLIMIT.FAILED IS NULL;
    LOOP
      FETCH tmpRelCursor
      INTO tmpTranCode,
        tmpProductId,
        tmpCycleLength,
        tmpFrequencyQuota,
        tmpFrequencyLength,
        tmpCycleLengthType,
        tmpFrequencyLengthType,
        tmpImpAmount,
        tmpAmount,
        tmpAccountId,
        tmpAccountType,
        tmpAccountCurrency,
        tmpProdAmountId,
        tmpActionFlag,
        tmpInstitutionId;
      EXIT
    WHEN tmpRelCursor %NOTFOUND;
      IF To_Number(tmpImpAmount) <> 0 THEN
        SELECT SEQ_LIMITAMOUNT.NEXTVAL INTO tmpIndAmountId FROM DUAL;
        INSERT
        INTO TBLCFGLIMITAMOUNT
          (
            AMOUNT_ID,
            AMOUNT,
            CYCLE_LENGTH,
            FREQUENCY_QUOTA,
            FREQUENCY_LENGTH,
            CYCLE_LENGTH_TYPE,
            FREQUENCY_LENGTH_TYPE
          )
          VALUES
          (
            tmpIndAmountId,
            tmpImpAmount,
            tmpCycleLength,
            tmpFrequencyQuota,
            tmpFrequencyLength,
            tmpCycleLengthType,
            tmpFrequencyLengthType
          );
        INSERT
        INTO TBLINDLIMITINFO
          (
            LIMIT_INFO_ID,
            TRAN_CODE,
            CHANNEL_ID,
            PRODUCT_ID
          )
        SELECT tmpIndAmountId,
          TBLCFGLIMIT.TRAN_CODE,
          TBLCFGLIMIT.CHANNEL_ID,
          tmpProductId
        FROM TBLCFGLIMIT
        WHERE TBLCFGLIMIT.GROUP_ID = tmpProductId
        AND TBLCFGLIMIT.AMOUNT_ID  = tmpProdAmountId;
        INSERT
        INTO TBLREMAININGACCOUNTLIMIT
          (
            CYCLE_BEGIN_DATE ,
            REMAINING_LIMIT ,
            ACCOUNT_ID ,
            ACCOUNT_TYPE ,
            ACCOUNT_CURRENCY ,
            AMOUNT_ID ,
            IS_INDIVIDUAL ,
            REMAINING_FREQUENCY
          )
          VALUES
          (
            TO_CHAR(SYSDATE,'yyyymmdd'),
            tmpImpAmount,
            RPAD(tmpAccountId,20),
            tmpAccountType,
            tmpAccountCurrency,
            tmpIndAmountId,
            '1',
            tmpFrequencyQuota
          );
        COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
        l_InsertIndCount := l_InsertIndCount + 1;
      ELSE
        INSERT
        INTO TBLREMAININGACCOUNTLIMIT
          (
            CYCLE_BEGIN_DATE ,
            REMAINING_LIMIT ,
            ACCOUNT_ID ,
            ACCOUNT_TYPE ,
            ACCOUNT_CURRENCY ,
            AMOUNT_ID ,
            IS_INDIVIDUAL ,
            REMAINING_FREQUENCY
          )
          VALUES
          (
            TO_CHAR(SYSDATE,'yyyymmdd'),
            tmpImpAmount,
            RPAD(tmpAccountId,20),
            tmpAccountType,
            tmpAccountCurrency,
            tmpProdAmountId,
            '0',
            tmpFrequencyQuota
          );
        COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
        l_InsertCount := l_InsertCount + 1;
      END IF;
    END LOOP;
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    --COMMIT; --THIS COMMIT END THE SET TRANSACTION READ WRITE
    outRetVal := l_InsertCount;
    outMsg    := outMsg || 'Rows added in TBLCFGLIMITAMOUNT,TBLINDLIMITINFO['||TO_CHAR(l_InsertIndCount)||'] Rows Insert in TBLREMAININGACCOUNTLIMIT ['||TO_CHAR(l_InsertCount)||']';
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spInsertALFromMultiLO;
/*
***************************************************************************
Created By  : Salman Aziz
Dated        : 25-Nov-09
Description :  Insert Rows in tblproduction for Force
Pin-Regeneration.
***************************************************************************
S#  Who    Date    Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spInsertCardForcePinGeneration
    (
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER
    )
  IS
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --'PIN_GEN','1'
    --SET TRANSACTION READ WRITE;
    INSERT
    INTO tblproduction
      (
        ROW_ID,
        RELATIONSHIP_ID,
        CHANNEL_ID,
        STAGE,
        ISFORCED
      )
    SELECT SEQCARDPRODUCTION.NEXTVAL,
      Debit_Table.relID,
      Debit_Table.chalID,
      Debit_Table.STAGE,
      Debit_Table.ISFORCED
    FROM
      (SELECT tbldebitcard.relationship_id AS relID,
        '0001'                             AS chalID,
        'PIN_GEN'                          AS STAGE,
        '1'                                AS ISFORCED
      FROM TBLDEBITCARD
      INNER JOIN
        (SELECT CARD_RESP.CARDCONTRACTNUMBER
        FROM TBLIMPTMPCARD_OPS CARD_RESP
        WHERE CARD_RESP.FAILED IS NULL
        ) CARD_RESP
      ON CARD_RESP.CARDCONTRACTNUMBER = tbldebitcard.card_interfacing_no
      ) Debit_Table
    WHERE NOT EXISTS
      (SELECT *
      FROM tblproduction
      WHERE tblproduction.RELATIONSHIP_ID = Debit_Table.relID
      AND tblproduction.CHANNEL_ID        = Debit_Table.chalID
      );
    outRetVal := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spInsertCardForcePinGeneration;
--added by tanveer 5 march 2010 for mucodec limit update
  PROCEDURE spUpdateALFromMultiLO(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    tmpRelCursor REF_CURSOR;
    --tmpExpiryDate  VARCHAR2(100);
    tmpTranCode  VARCHAR2(100);
    tmpProductId VARCHAR2(100);
    --tmpLimitType  VARCHAR2(100);
    tmpCycleLength         VARCHAR2(100);
    tmpFrequencyLengthType VARCHAR2(100);
    tmpFrequencyLength     VARCHAR2(100);
    tmpCycleLengthType     VARCHAR2(100);
    tmpFrequencyQuota      VARCHAR2(100);
    tmpAmount              VARCHAR2(100);
    tmpProdAmountId        VARCHAR2(100);
    tmpImpAmount           VARCHAR2(100);
    tmpAmountSeqVal        VARCHAR2(100);
    tmpIndAmountId         VARCHAR2(100);
    tmpAccountId           VARCHAR2(100);
    tmpAccountType         VARCHAR2(100);
    tmpAccountCurrency     VARCHAR2(100);
    --tmpCustomerId VARCHAR2(100);
    tmpInstitutionId VARCHAR2(100);
    tmpActionFlag    VARCHAR2(100);
    tmpIs_Individual VARCHAR2(100);
    l_InsertCount    NUMBER;
  BEGIN
    outRetVal    := 0;
    outMsg       := 'Executed Successfully';
    l_InsertCount:=0;
    OPEN tmpRelCursor FOR SELECT
    --ACCOUNTLIMIT.EXPIRY_DATE    ,
    ACCOUNTLIMIT.TRAN_CODE,
    ACCOUNTLIMIT.PRODUCT_ID,
    --              ACCOUNTLIMIT.LIMITTYPE ,
    ACCOUNTLIMIT.CYCLE_LENGTH ,
    ACCOUNTLIMIT.FREQUENCY_QUOTA ,
    ACCOUNTLIMIT.FREQUENCY_LENGTH ,
    ACCOUNTLIMIT.CYCLE_LENGTH_TYPE ,
    ACCOUNTLIMIT.FREQUENCY_LENGTH_TYPE ,
    ACCOUNTLIMIT.IMPORTAMOUNT ,
    ACCOUNTLIMIT.AMOUNT ,
    ACCOUNTLIMIT.ACCOUNT_ID ,
    ACCOUNTLIMIT.ACCOUNT_TYPE ,
    ACCOUNTLIMIT.ACCOUNT_CURRENCY ,
    --              ACCOUNTLIMIT.CUSTOMER_ID ,
    ACCOUNTLIMIT.AMOUNT_ID ,
    ACCOUNTLIMIT.ACTIONFLAG ,
    ACCOUNTLIMIT.INSTITUTIONID,
    ACCOUNTLIMIT.IS_INDIVIDUAL FROM tblimptmpmultilimitsobj ACCOUNTLIMIT WHERE ACCOUNTLIMIT.ACTIONFLAG = '02' AND ACCOUNTLIMIT.FAILED IS NULL;
    LOOP
      FETCH tmpRelCursor
      INTO tmpTranCode,
        tmpProductId,
        tmpCycleLength,
        tmpFrequencyQuota,
        tmpFrequencyLength,
        tmpCycleLengthType,
        tmpFrequencyLengthType,
        tmpImpAmount,
        tmpAmount,
        tmpAccountId,
        tmpAccountType,
        tmpAccountCurrency,
        tmpProdAmountId,
        tmpActionFlag,
        tmpInstitutionId,
        tmpIs_Individual;
      EXIT
    WHEN tmpRelCursor %NOTFOUND;
      --1st case product to individual limit
      IF (tmpIs_Individual) = '0' AND To_Number(tmpImpAmount) <> 0 THEN
        DELETE
        FROM TBLREMAININGACCOUNTLIMIT
        WHERE TRIM(ACCOUNT_ID) = tmpAccountId
        AND ACCOUNT_TYPE       = tmpAccountType
        AND ACCOUNT_CURRENCY   = tmpAccountCurrency;
        SELECT SEQ_LIMITAMOUNT.NEXTVAL INTO tmpIndAmountId FROM DUAL;
        INSERT
        INTO TBLCFGLIMITAMOUNT
          (
            AMOUNT_ID,
            AMOUNT,
            CYCLE_LENGTH,
            FREQUENCY_QUOTA,
            FREQUENCY_LENGTH,
            CYCLE_LENGTH_TYPE,
            FREQUENCY_LENGTH_TYPE
          )
          VALUES
          (
            tmpIndAmountId,
            tmpImpAmount,
            tmpCycleLength,
            tmpFrequencyQuota,
            tmpFrequencyLength,
            tmpCycleLengthType,
            tmpFrequencyLengthType
          );
        INSERT
        INTO TBLINDLIMITINFO
          (
            LIMIT_INFO_ID,
            TRAN_CODE,
            CHANNEL_ID,
            PRODUCT_ID
          )
        SELECT tmpIndAmountId,
          TBLCFGLIMIT.TRAN_CODE,
          TBLCFGLIMIT.CHANNEL_ID,
          tmpProductId
        FROM TBLCFGLIMIT
        WHERE TBLCFGLIMIT.GROUP_ID = tmpProductId
        AND TBLCFGLIMIT.AMOUNT_ID  = tmpProdAmountId;
        INSERT
        INTO TBLREMAININGACCOUNTLIMIT
          (
            CYCLE_BEGIN_DATE ,
            REMAINING_LIMIT ,
            ACCOUNT_ID ,
            ACCOUNT_TYPE ,
            ACCOUNT_CURRENCY ,
            AMOUNT_ID ,
            IS_INDIVIDUAL ,
            remaining_frequency
          )
          VALUES
          (
            TO_CHAR(SYSDATE,'yyyymmdd'),
            tmpImpAmount,
            RPAD(tmpAccountId,20),
            tmpAccountType,
            tmpAccountCurrency,
            tmpIndAmountId,
            '1',
            tmpFrequencyQuota
          );
        COMMIT;
        --2nd case individual to product based limit
      ELSIF (tmpIs_Individual) = '1' AND To_Number(tmpImpAmount) = 0 THEN
        DELETE
        FROM TBLCFGLIMITAMOUNT
        WHERE AMOUNT_ID IN
          (SELECT AMOUNT_ID
          FROM TBLREMAININGACCOUNTLIMIT
          WHERE TRIM(ACCOUNT_ID) = tmpAccountId
          AND ACCOUNT_TYPE       = tmpAccountType
          AND ACCOUNT_CURRENCY   = tmpAccountCurrency
          );
        DELETE
        FROM TBLINDLIMITINFO
        WHERE LIMIT_INFO_ID IN
          (SELECT AMOUNT_ID
          FROM TBLREMAININGACCOUNTLIMIT
          WHERE TRIM(ACCOUNT_ID) = tmpAccountId
          AND ACCOUNT_TYPE       = tmpAccountType
          AND ACCOUNT_CURRENCY   = tmpAccountCurrency
          );
        DELETE
        FROM TBLREMAININGACCOUNTLIMIT
        WHERE TRIM(ACCOUNT_ID) = tmpAccountId
        AND ACCOUNT_TYPE       = tmpAccountType
        AND ACCOUNT_CURRENCY   = tmpAccountCurrency;
        INSERT
        INTO TBLREMAININGACCOUNTLIMIT
          (
            CYCLE_BEGIN_DATE ,
            REMAINING_LIMIT ,
            ACCOUNT_ID ,
            ACCOUNT_TYPE ,
            ACCOUNT_CURRENCY ,
            AMOUNT_ID ,
            IS_INDIVIDUAL ,
            remaining_frequency
          )
          VALUES
          (
            TO_CHAR(SYSDATE,'yyyymmdd'),
            tmpAmount,
            RPAD(tmpAccountId,20),
            tmpAccountType,
            tmpAccountCurrency,
            tmpProdAmountId,
            '0',
            tmpFrequencyQuota
          );
        COMMIT;
        --3rd case individual limit to individual amount changed
      ELSE
        UPDATE TBLCFGLIMITAMOUNT
        SET amount       = tmpImpAmount
        WHERE AMOUNT_ID IN
          (SELECT AMOUNT_ID
          FROM TBLREMAININGACCOUNTLIMIT
          WHERE TRIM(ACCOUNT_ID) = tmpAccountId
          AND ACCOUNT_TYPE       = tmpAccountType
          AND ACCOUNT_CURRENCY   = tmpAccountCurrency
          );
        UPDATE TBLREMAININGACCOUNTLIMIT
        SET remaining_limit    = tmpImpAmount
        WHERE TRIM(ACCOUNT_ID) = tmpAccountId
        AND ACCOUNT_TYPE       = tmpAccountType
        AND ACCOUNT_CURRENCY   = tmpAccountCurrency ;
        COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      END IF;
      l_InsertCount := l_InsertCount + 1;
    END LOOP;
    COMMIT; --THIS COMMIT END THE SET TRANSACTION READ WRITE
    COMMIT; -- THIS COMMIT COMMITS DATA TO THE DB
    outRetVal := l_InsertCount;
    outMsg    := outMsg || 'Rows added in TBLCFGLIMITAMOUNT,TBLINDLIMITINFO['||TO_CHAR(l_InsertCount)||'] Rows Insert in TBLREMAININGACCOUNTLIMIT ['||TO_CHAR(l_InsertCount)||']';
    COMMIT;
  END spUpdateALFromMultiLO;
/*
***************************************************************************
Created By  : Salman Aziz
Dated        : 06-April-2010
Description :  Insert Rows in tblcustomerbeneficiary from tblimptmpcustbeneficiary
***************************************************************************
S#  Who    Date    Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spInsertCustomerBeneficiary(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --'PIN_GEN','1'
    --SET TRANSACTION READ WRITE; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    --Added by Musfar for Bulk Card Operation
    INSERT
    INTO TBLIMPBULKCARDDATA
      (
        CARDNUMBER,
        STATUS,
        MEMO,
        USER_ID,
        DATETIME,
        INSTITUTIONID,
        OLDCARDSTATUS
      )
    SELECT CARDNUM,
      STATUS,
      MEMO,
      USER_ID,
      TO_CHAR(SYSDATE,'yyyyMMddHH24MiSS'),
      INSTITUTIONID,
      OLDCARDSTATUS
    FROM TBLIMPTEMPBULKCARDDATA
    WHERE ERR_CODE IS NULL;
    COMMIT;
    INSERT
    INTO TBLIMPBULKCARDISSUANCE
      (
        CARDNUM,
        EXPIRY,
        SOURCE_PRODUCT,
        DESTINATION_PRODUCT,
        DATETIME,
        INSTITUTIONID,
        NEW_CARDNUM
      )
    SELECT CARDNUM,
      EXPIRY,
      SOURCE_PRODUCT,
      DESTINATION_PRODUCT,
      (SELECT TO_CHAR(SYSDATE,'yyyyMMddHH24MiSS') FROM DUAL
      ),
      '0030',
      NEWCARDNUM
    FROM TBLIMPTEMPBULKCARDISSUANCE
    WHERE ERR_CODE IS NULL;
    COMMIT;
    --Added by Musfar for Bulk Card Operation
    INSERT
    INTO tblcustomerbeneficiary
      (
        short_name,
        beneficiaryid,
        customer_id,
        Mobile_number, -- BY SR - Feb 22 - 2011 - Merged from ENBD
        first_name,
        last_name,
        email_address,
        telephone_number,
        mailing_address,
        bank_name,
        bank_address,
        account_number,
        swift_code,
        country_code,
        -- BY SR - Feb 22 - 2011 - Merged from ENBD
        country_currency_code,
        status,
        CREATION_DATE,
        LAST_UPDATE
      )
    SELECT tblimptmpcustbeneficiary.short_name,
      tblimptmpcustbeneficiary.beneficiaryid,
      tblimptmpcustbeneficiary.customer_id,
      tblimptmpcustbeneficiary.mobile_number, -- BY SR - Feb 22 - 2011 - Merged from ENBD
      tblimptmpcustbeneficiary.first_name,
      tblimptmpcustbeneficiary.last_name,
      tblimptmpcustbeneficiary.email_address,
      tblimptmpcustbeneficiary.telephone_number,
      tblimptmpcustbeneficiary.mailing_address,
      tblimptmpcustbeneficiary.bank_name,
      tblimptmpcustbeneficiary.bank_address,
      tblimptmpcustbeneficiary.account_number,
      tblimptmpcustbeneficiary.swift_code,
      tblimptmpcustbeneficiary.country_code,
      tblimptmpcustbeneficiary.country_currency_code,
      '01',
      TO_CHAR(sysdate,'yyyyMMdd'),
      TO_CHAR(sysdate,'yyyyMMdd') -- BY SR - Feb 22 - 2011 - Merged from ENBD
    FROM tblimptmpcustbeneficiary
    WHERE tblimptmpcustbeneficiary.FAILED  IS NULL
    AND tblimptmpcustbeneficiary.ACTIONFLAG = '01';
    outRetVal                              := SQL%ROWCOUNT;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      UPDATE tblimptmpcustbeneficiary
      SET tblimptmpcustbeneficiary.Failed = '1' ,
        err_code                          = errorCode,
        err_description                   = errorDesc;
      COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      outRetVal := -1;
    END;
  END spInsertCustomerBeneficiary;
/*
***************************************************************************
Created By  : Osama Siraj Siddiqui
Dated        : 17-June-2010
Description :  Updating Rows, in tblcustomerbeneficiary from tblimptmpcustbeneficiary
***************************************************************************
S#  Who    Date    Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spUpdateCustomerBeneficiary(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inBeneficiaryId T_BENEFICIARY_ID                           :=T_BENEFICIARY_ID();
    inBeneficiaryShortName T_BENEFICIARY_SHORT_NAME            :=T_BENEFICIARY_SHORT_NAME();
    inCustomerId T_CUSTOMER_ID                                 :=T_CUSTOMER_ID();
    inMobileNumber T_MOBILE_NUMBER                             :=T_MOBILE_NUMBER(); -- BY SR - Feb 22 - 2011 - Merged from ENBD
    inBeneficiaryFirstName T_FIRST_NAME                        :=T_FIRST_NAME();
    inBeneficiaryLastName T_LAST_NAME                          :=T_LAST_NAME();
    inBeneficiaryMail T_BENEFICIARY_EMAIL                      :=T_BENEFICIARY_EMAIL();
    inBeneficiaryPhoneNumber T_BENEFICIARY_PHONENUMBER         :=T_BENEFICIARY_PHONENUMBER();
    inBeneficiaryAddress T_BENEFICIARY_ADDRESS                 :=T_BENEFICIARY_ADDRESS();
    inBeneficiaryBankName T_BENEFICIARY_BANKNAME               :=T_BENEFICIARY_BANKNAME();
    inBeneficiaryBankAddress T_BENEFICIARY_BANK_ADDRESS        :=T_BENEFICIARY_BANK_ADDRESS();
    inBeneficiaryAccountNumber T_BENEFICIARY_ACCOUNTNUMBER     :=T_BENEFICIARY_ACCOUNTNUMBER();
    inBeneficiarySwiftCode T_BENEFICIARY_SWIFT_CODE            :=T_BENEFICIARY_SWIFT_CODE();
    inBeneficiaryCountryCode T_BENEFICIARY_COUNTRY_CODE        :=T_BENEFICIARY_COUNTRY_CODE();
    inBeneficiaryCoutryCurrCode T_BENEFICIARY_COUNTRY_CUR_CODE :=T_BENEFICIARY_COUNTRY_CUR_CODE();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SELECT BENEFICIARYID,
      short_name,
      customer_id,
      mobile_number, -- BY SR - Feb 22 - 2011 - Merged from ENBD
      first_name,
      last_name,
      email_address,
      telephone_number,
      mailing_address,
      bank_name,
      bank_address,
      account_number,
      swift_code,
      country_code,
      country_currency_code bulk collect
    INTO inBeneficiaryId,
      inBeneficiaryShortName,
      inCustomerId,
      inMobileNumber, -- BY SR - Feb 22 - 2011 - Merged from ENBD
      inBeneficiaryFirstName,
      inbeneficiarylastname,
      inbeneficiarymail,
      inbeneficiaryphonenumber,
      inbeneficiaryaddress,
      inbeneficiarybankname,
      inbeneficiarybankaddress,
      inbeneficiaryaccountnumber,
      inbeneficiaryswiftcode,
      inbeneficiarycountrycode,
      inbeneficiarycoutrycurrcode
    FROM tblimptmpcustbeneficiary
    WHERE actionflag                     ='02'
    AND tblimptmpcustbeneficiary.FAILED IS NULL;
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    FORALL i IN inCUSTOMERID.FIRST..inCUSTOMERID.LAST
    UPDATE tblcustomerbeneficiary
    SET mobile_number      =inMobileNumber(i), -- BY SR - Feb 22 - 2011 - Merged from ENBD
      first_name           =inbeneficiaryfirstname(i),
      last_name            =inbeneficiarylastname (i),
      email_address        =inbeneficiarymail (i),
      telephone_number     =inbeneficiaryphonenumber(i),
      mailing_address      =inbeneficiaryaddress(i),
      bank_name            =inbeneficiarybankname(i),
      bank_address         =inbeneficiarybankaddress(i),
      account_number       =inbeneficiaryaccountnumber(i),
      swift_code           =inbeneficiaryswiftcode(i),
      country_code         =inbeneficiarycountrycode(i),
      country_currency_code=inbeneficiarycoutrycurrcode(i),
      LAST_UPDATE          = sysdate -- BY SR - Feb 22 - 2011 - Merged from ENBD
    WHERE beneficiaryid    =inbeneficiaryid(i)
    AND customer_id        =incustomerid(i)
    AND short_name         =inbeneficiaryshortname(i);
    outRetVal             := SQL%ROWCOUNT;
    --commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spUpdateCustomerBeneficiary;
/*
***************************************************************************
Created By  : Osama Siraj Siddiqui
Dated        : 17-June-2010
Description :  Deleting Rows, in tblcustomerbeneficiary from tblimptmpcustbeneficiary
***************************************************************************
S#  Who    Date    Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spDeleteCustomerBeneficiary(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inBeneficiaryId T_BENEFICIARY_ID                :=T_BENEFICIARY_ID();
    inBeneficiaryShortName T_BENEFICIARY_SHORT_NAME :=T_BENEFICIARY_SHORT_NAME();
    inCustomerId T_CUSTOMER_ID                      :=T_CUSTOMER_ID();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SELECT BENEFICIARYID,
      short_name,
      customer_id bulk collect
    INTO inBeneficiaryId,
      inBeneficiaryShortName,
      inCustomerId
    FROM tblimptmpcustbeneficiary
    WHERE actionflag                     ='03'
    AND tblimptmpcustbeneficiary.FAILED IS NULL;
    FORALL i IN inCUSTOMERID.FIRST..inCUSTOMERID.LAST
    DELETE tblcustomerbeneficiary
    WHERE beneficiaryid=inbeneficiaryid(i) -- BY SR - Feb 22 - 2011 - Merged from ENBD
    AND customer_id    =incustomerid(i)
    AND short_name     =inbeneficiaryshortname(i);
    outRetVal         := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  END spDeleteCustomerBeneficiary;
/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIILOG
***************************************************************************
S#  Who    Date    Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spInsertBASEIILOG(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --'PIN_GEN','1'
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    DELETE
    FROM TBLBASEIILOG;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLBASEIILOG
      (
        TRANCODE,
        TRANCODEQUAL,
        TRANCODESEQ,
        PAN,
        PANSEQNO,
        FLOORLIMITIND,
        CRBIND,
        PCASIND,
        ARN,
        ACQBUSINESSID,
        PURCHASEDATE,
        DESTINATIONAMOUNT,
        DESTINATIONCURRENCY,
        SOURCEAMOUNT,
        SOURCECURRENCYCODE,
        MERCHANTNAME,
        MERCHANTCITY,
        MCOUNTRYCODE,
        MCATEGORYCODE,
        MERCHANTZIPCODE,
        MERCHANTPROVINCECODE,
        REQUESTEDPAYMENTSERVICE,
        RESERVED,
        USAGECODE,
        REASONCODE,
        SETTLEMENTFLAG,
        AUTHCHARIND,
        AUTHCODE,
        POSTERMCAP,
        INTLFEEIND,
        CARDHOLDERIDMETHOD,
        COLLECTIONFLAG,
        POSENTMODE,
        CPD,
        REIMBURSEATT,
        PROCESSINGDATE,
        INSTITUTIONID
      )
    SELECT TRANCODE,
      TRANCODEQUAL,
      TRANCODESEQ,
      PAN,
      PANSEQNO,
      FLOORLIMITIND,
      CRBIND,
      PCASIND,
      ARN,
      ACQBUSINESSID,
      PURCHASEDATE,
      DESTINATIONAMOUNT,
      DESTINATIONCURRENCY,
      SOURCEAMOUNT,
      SOURCECURRENCYCODE,
      MERCHANTNAME,
      MERCHANTCITY,
      MCOUNTRYCODE,
      MCATEGORYCODE,
      MERCHANTZIPCODE,
      MERCHANTPROVINCECODE,
      REQUESTEDPAYMENTSERVICE,
      RESERVED,
      USAGECODE,
      REASONCODE,
      SETTLEMENTFLAG,
      AUTHCHARIND,
      AUTHCODE,
      POSTERMCAP,
      INTLFEEIND,
      CARDHOLDERIDMETHOD,
      COLLECTIONFLAG,
      POSENTMODE,
      CPD,
      REIMBURSEATT,
      TO_CHAR(SYSDATE, 'YYYYMMDD'),
      INSTITUTIONID
    FROM TBLIMPTMPBASEIILOG;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      UPDATE TBLIMPTMPBASEIILOG
      SET Failed        = '1' ,
        err_code        = errorCode,
        err_description = errorDesc;
      COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --
      outRetVal := 0;
    END;
  END spInsertBASEIILOG;
/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIILOG
***************************************************************************
S#  Who    Date    Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spInsertBASEIILOG01(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --'PIN_GEN','1'
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLBASEIIADDITIONALDATA01
      (
        TRANSACTIONCODE,
        PAN,
        ARN,
        MESSAGE,
        PROCESSINGDATE,
        INSTITUTIONID
      )
    SELECT DISTINCT RECORDCATEGORY,
      PAN,
      ARN,
      MESSAGE,
      TO_CHAR(SYSDATE, 'YYYYMMDD'),
      INSTITUTIONID
    FROM TBLIMPTMPBASEIILOGADDITIONAL01
    WHERE FAILED IS NULL;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      UPDATE TBLIMPTMPBASEIILOGADDITIONAL01
      SET Failed        = '1' ,
        err_code        = errorCode,
        err_description = errorDesc;
      COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --
      outRetVal := 0;
    END;
  END spInsertBASEIILOG01;
--<Add Author='Tabish Habib' Date='14/03/2013' Comments='Visa Mandate 2013'>
  PROCEDURE spInsertBASEIILOG03(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    INSERT
    INTO TBLBASEIIADDITIONALDATA03
      (
        TRANSACTIONCODE,
        PAN,
        ARN,
        MESSAGE,
        PROCESSINGDATE,
        INSTITUTIONID
      )
    SELECT RECORDCATEGORY,
      PAN,
      ARN,
      MESSAGE,
      TO_CHAR(SYSDATE, 'YYYYMMDD'),
      INSTITUTIONID
    FROM TBLIMPTMPBASEIILOGADDITIONAL03
    WHERE FAILED IS NULL;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      UPDATE TBLIMPTMPBASEIILOGADDITIONAL03
      SET Failed        = '1' ,
        err_code        = errorCode,
        err_description = errorDesc;
      COMMIT;
      outRetVal := 0;
    END;
  END spInsertBASEIILOG03;
--</Add>
/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIILOG
***************************************************************************
S#  Who    Date    Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spInsertBASEIILOG05(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --'PIN_GEN','1'
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLBASEIIADDITIONALDATA05
      (
        TRANSACTIONCODE,
        PAN,
        ARN,
        MESSAGE,
        PROCESSINGDATE,
        INSTITUTIONID
      )
    SELECT RECORDCATEGORY,
      PAN,
      ARN,
      MESSAGE,
      TO_CHAR(SYSDATE, 'YYYYMMDD'),
      INSTITUTIONID
    FROM TBLIMPTMPBASEIILOGADDITIONAL05
    WHERE FAILED IS NULL;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      UPDATE TBLIMPTMPBASEIILOGADDITIONAL05
      SET Failed        = '1' ,
        err_code        = errorCode,
        err_description = errorDesc;
      COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --
      outRetVal := 0;
    END;
  END spInsertBASEIILOG05;
/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIILOG
***************************************************************************
S#  Who    Date    Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spInsertBASEIILOG07(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --'PIN_GEN','1'
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLBASEIIADDITIONALDATA07
      (
        TRANSACTIONCODE,
        PAN,
        ARN,
        MESSAGE,
        PROCESSINGDATE,
        INSTITUTIONID
      )
    SELECT RECORDCATEGORY,
      PAN,
      ARN,
      MESSAGE,
      TO_CHAR(SYSDATE, 'YYYYMMDD'),
      INSTITUTIONID
    FROM TBLIMPTMPBASEIILOGADDITIONAL07
    WHERE FAILED IS NULL;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      UPDATE TBLIMPTMPBASEIILOGADDITIONAL07
      SET Failed        = '1' ,
        err_code        = errorCode,
        err_description = errorDesc;
      COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --
      outRetVal := 0;
    END;
  END spInsertBASEIILOG07;
/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIICREDITLOG
***************************************************************************
S#  Who    Date    Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spInsertBASEIICREDITLOG(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --'PIN_GEN','1'
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLBASEIICREDITLOG
      (
        TRANCODE,
        TRANCODEQUAL,
        TRANCODESEQ,
        PAN,
        PANSEQNO,
        FLOORLIMITIND,
        CRBIND,
        PCASIND,
        ARN,
        ACQBUSINESSID,
        PURCHASEDATE,
        DESTINATIONAMOUNT,
        DESTINATIONCURRENCY,
        SOURCEAMOUNT,
        SOURCECURRENCYCODE,
        MERCHANTNAME,
        MERCHANTCITY,
        MCOUNTRYCODE,
        MCATEGORYCODE,
        MERCHANTZIPCODE,
        MERCHANTPROVINCECODE,
        REQUESTEDPAYMENTSERVICE,
        RESERVED,
        USAGECODE,
        REASONCODE,
        SETTLEMENTFLAG,
        AUTHCHARIND,
        AUTHCODE,
        POSTERMCAP,
        INTLFEEIND ,
        CARDHOLDERIDMETHOD,
        COLLECTIONFLAG,
        POSENTMODE,
        CPD,
        REIMBURSEATT,
        PROCESSINGDATE,
        INSTITUTIONID
      )
    SELECT TRANCODE,
      TRANCODEQUAL,
      TRANCODESEQ,
      PAN,
      PANSEQNO,
      FLOORLIMITIND,
      CRBIND,
      PCASIND,
      ARN,
      ACQBUSINESSID,
      PURCHASEDATE,
      DESTINATIONAMOUNT,
      DESTINATIONCURRENCY,
      SOURCEAMOUNT,
      SOURCECURRENCYCODE,
      MERCHANTNAME,
      MERCHANTCITY,
      MCOUNTRYCODE,
      MCATEGORYCODE,
      MERCHANTZIPCODE,
      MERCHANTPROVINCECODE,
      REQUESTEDPAYMENTSERVICE,
      RESERVED,
      USAGECODE,
      REASONCODE,
      SETTLEMENTFLAG,
      AUTHCHARIND,
      AUTHCODE,
      POSTERMCAP,
      INTLFEEIND,
      CARDHOLDERIDMETHOD,
      COLLECTIONFLAG,
      POSENTMODE,
      CPD,
      REIMBURSEATT,
      TO_CHAR(SYSDATE, 'YYYYMMDD'),
      INSTITUTIONID
    FROM TBLIMPTMPBASEIICREDITLOG
    WHERE TBLIMPTMPBASEIICREDITLOG.FAILED IS NULL;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      UPDATE TBLIMPTMPBASEIICREDITLOG
      SET Failed        = '1' ,
        err_code        = errorCode,
        err_description = errorDesc;
      COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --
      outRetVal := 0;
    END;
  END spInsertBASEIICREDITLOG;
/*
***************************************************************************
Created By  : Haris Habib
Dated        : 13-May-2010
Description :  Insert Rows in TBLBASEIIFEECOLLECTION
***************************************************************************
S#  Who    Date    Change Description
***************************************************************************
***************************************************************************
*/
  PROCEDURE spInsertBASEIIFEECOLL(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --        --'PIN_GEN','1'
    --SET TRANSACTION READ WRITE;
    --insert into TBLBASEIIFEECOLLECTION(
    --TRANCODE,
    --TRANCODEQUAL,
    --TRANCODESEQ,
    --DESTINATIONBIN,
    --SOURCEBIN,
    --REASONCODE,
    --COUNTRYCODE,
    --EVENTDATE,
    --ACCOUNTNO,
    --ACCOUNTNO_EXT,
    --DESTAMOUNT,
    --DESTCURR,
    --SRCAMOUNT,
    --SOURCECURRENCYCODE,
    --MESSAGETEXT,
    --SETTLEMENTFLAG,
    --TRAN_IDEN,
    --RESERVED,
    --CPD,
    --REIMBURSEATT,
    --PROCESSINGDATE,
    --INSTITUTIONID
    --)
    --SELECT TRANCODE,
    --TRANCODEQUAL,
    --TRANCODESEQ,
    --DESTINATIONBIN,
    --SOURCEBIN,
    --REASONCODE,
    --COUNTRYCODE,
    --EVENTDATE,
    --ACCOUNTNO,
    --ACCOUNTNO_EXT,
    --DESTAMOUNT,
    --DESTCURR,
    --SRCAMOUNT,
    --SOURCECURRENCYCODE,
    --MESSAGETEXT,
    --SETTLEMENTFLAG,
    --TRAN_IDEN,
    --RESERVED,
    --CPD,
    --REIMBURSEATT,
    --to_char(SYSDATE, 'YYYYMMDD'),
    --INSTITUTIONID
    --FROM   TBLIMPTMPBASEIIFEECOLLECTION
    --where
    --TBLIMPTMPBASEIIFEECOLLECTION.FAILED is null;
    --commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      UPDATE TBLIMPTMPBASEIIFEECOLLECTION
      SET Failed        = '1' ,
        err_code        = errorCode,
        err_description = errorDesc;
      --commit; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --
      outRetVal := 0;
    END;
  END spInsertBASEIIFEECOLL;
  PROCEDURE spInsertRelCharges(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    --Set Transaction Read Write; -- BY SR - Feb 22 - 2011 - Merged from ENBD
    INSERT
    INTO TBLRELATIONSHIPCHARGES
      (
        RELATIONSHIP_ID,
        CHANNEL_ID,
        CARDFEE_ID,
        NEXT_EXECUTION_DATE,
        IS_LOGGED,
        REL_CHARGE_ID,
        OCCURENCE_NUMBER
      )
    SELECT RELATIONSHIP_ID,
      CHANNEL_ID,
      CARDFEE_ID,
      NEXT_EXECUTION_DATE,
      IS_LOGGED,
      SEQ_RELCHARGE.nextval,
      OCCURENCE_NUMBER
    FROM TBLIMPTMPRELCHARGE
    WHERE failed IS NULL;
    outRetVal    := SQL%ROWCOUNT;
    COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc := SQLERRM;
      UPDATE TBLIMPTMPRELCHARGE
      SET Failed        = '1' ,
        err_code        = errorCode,
        err_description = errorDesc;
      COMMIT; -- BY SR - Feb 22 - 2011 - Merged from ENBD
      --
      outRetVal := 0;
    END;
  END spInsertRelCharges;
  PROCEDURE spUpdatePin(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    UPDATE tblrelationshipauth a
    SET
      (
        PIN,
        PIN_GEN_DATE
      )
      =
      (SELECT b.PINOFFSET,
        TO_CHAR(sysdate,'yyyymmdd')
      FROM TBLIMPTMPPINOFFSET b
      WHERE a.RELATIONSHIPAUTH_ID = b.RELAUTHID
      )
    WHERE a.RELATIONSHIPAUTH_ID IN
      (SELECT RELAUTHID FROM tblimptmppinoffset
      );
    COMMIT;
  END spUpdatePin;
/*
***************************************************************************
Created By  : Sajjad Rizvi
Dated       : 11-Nov-2010
Description :  Update in ProductionCycle using Oberthur Import
***************************************************************************
S# Who  Date  Change Description
***************************************************************************
***************************************************************************
*/
--By SR - Nov 11 - 2010 - For Oberthur Import
  PROCEDURE spInsertOberthurImport(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    --Cursors
    CURSOR curMain
    IS
      SELECT a.mdata,
        a.log_feedback_id
      FROM tblimptmpoberthur a
        --select a.mdata,a.log_feedback_id from TBLIMPTMPOBERTHUR2 a
      ORDER BY a.log_feedback_id ASC;
    --Get Relationship iD
    CURSOR curGetRelid(pCardno VARCHAR)
    IS
      SELECT a.relationship_id
      FROM tbldebitcard a,
        tblproduction b
      WHERE a.cardnumber    = pCardno
      AND a.relationship_id = b.relationship_id;
    --Get Product id
    CURSOR curGetProductID(pProductCode VARCHAR)
    IS
      SELECT a.product_id
      FROM tblcfgproductdetail a
      WHERE a.productcode = pProductCode;
    --Get Next Stage of Production Cycle
    CURSOR curGetNextProductionCycleStage(pProductID VARCHAR,pCurrentStage VARCHAR)
    IS
      SELECT a.stage_code
      FROM tblcfgproductproductioncycle a
      WHERE a.product_id = pProductID
      AND a.isincluded   = 'Y'
      AND a.sequenceno   =
        (SELECT MIN (t.sequenceno)
        FROM tblcfgproductproductioncycle t
        WHERE t.product_id= pProductID
        AND t.isincluded  = 'Y'
        AND t.sequenceno  > NVL(
          (SELECT b.sequenceno
          FROM tblcfgproductproductioncycle b
          WHERE b.product_id = pProductID
          AND b.stage_code   = pCurrentStage
          ),0)
        );
      -- Variables
      errorCode            VARCHAR2(1024);
      errorDesc            VARCHAR2(1024);
      mData                VARCHAR2(4000);
      mStatus              VARCHAR2(10);
      mLogFeedbackid       VARCHAR2(10);
      mCardno              VARCHAR2(30);
      mRelid               VARCHAR2(30);
      mProductCode         VARCHAR2(30);
      mProductID           VARCHAR2(30);
      mNextStage           VARCHAR2(30);
      mCurrentStage        VARCHAR2(30);
      mInstitutionID       VARCHAR2(10);
      mStatusCode          VARCHAR2(10);
      mPin                 VARCHAR2(30);
      mType                VARCHAR2(30);
      mFinalStatus         VARCHAR2(30);
      mFlag                VARCHAR2(10);
      mRC_ProductionLog    INT;
      mRC_Production       INT;
      mRC_DebitCard        INT;
      mRC_RelationshipAuth INT;
    BEGIN
      --SET TRANSACTION READ WRITE;
      /* UPdate tblimplogoberthur a
      set a.err_code = '1';
      commit;*/
      outRetVal := 0;
      outMsg    := 'Executed Successfully';
      -- Logic
      OPEN curMain;
      LOOP
        FETCH curMain INTO mData,mLogFeedbackid;
        EXIT
      WHEN curMain%NOTFOUND;
        mData     := REPLACE (mData,'"','');
        mStatus   := SUBSTR(mData,234,1);
        IF mStatus = 'A' OR mStatus = 'R' THEN
          --Get Card Number
          mCardno := SUBSTR(mData,194,16);
          --
          mFlag := SUBSTR(mData,172,2);
          --Get Rel ID
          OPEN curGetRelid(mCardno);
          FETCH curGetRelid INTO mRelid;
          CLOSE curGetRelid;
          --Get Type (C_PROD / PIN_GEN)
          SELECT a.stage
          INTO mType
          FROM tblproduction a
          WHERE a.relationship_id = mRelid;
          IF mType                = 'C_PROD' THEN
            mType                := 'C';
          ELSIF mType             = 'PIN_GEN' THEN
            mType                := 'P';
          ELSE
            mType := 'X';
          END IF;
          IF mStatus = 'A' THEN
            --Get Product Code
            --mProductCode :=substr(mData,213,5);
            --mProductCode := trim(leading '0' from mProductCode);
            --mProductCode :=substr(mData,214,4); -- Get only 4 Character of product code
            --Get Pin
            mPin :=trim(SUBSTR(mData,218,16)); -- Get PinOffset
            --Get ProductID
            OPEN curGetProductID(mProductCode);
            FETCH curGetProductID INTO mProductID;
            CLOSE curGetProductID;
            --Get Institution id
            SELECT a.institutionid
            INTO mInstitutionID
            FROM tblimplogoberthur a
            WHERE a.log_feedback_id = mLogFeedbackid;
            --Get StatusCode
            SELECT a.value
            INTO mStatusCode
            FROM tblcfgparam a
            WHERE a.entity      = 'OBERTHUR_IMPORT'
            AND a.name          = 'IMPORT_CARD_STATUS'
            AND a.institutionid = mInstitutionID;
            --Insert into tblProductionlog
            INSERT
            INTO tblproductionlog
              (
                ROW_ID,
                LOGDate,
                RELATIONSHIP_ID,
                CHANNEL_ID,
                STAGE,
                ISFORCED,
                EXPORT_STATUS,
                CUSTOMERID,
                productid
              )
            SELECT SEQ_TBLPRODUCTIONLOG.NextVal AS ROW_ID,
              TO_CHAR(sysdate, 'yyyyMMdd')      AS LOGDate,
              tc.RELATIONSHIP_ID,
              tb.CHANNEL_ID,
              tb.STAGE,
              NVL(tb.ISFORCED,'0'),
              tb.EXPORT_STATUS,
              tc.customerid,
              tc.group_id
            FROM TBLPRODUCTION tb,
              tbldebitcard tc
            WHERE tb.RELATIONSHIP_ID = mRelid
            AND tc.RELATIONSHIP_ID   = mRelid;
            mRC_ProductionLog       := SQL%ROWCOUNT;
            IF mRC_ProductionLog     = 1 THEN
              --Delete from tblproduction
              DELETE
              FROM tblproduction a
              WHERE a.relationship_id = mRelid;
              mRC_Production         := SQL%ROWCOUNT;
              --Update status in DebitCard
              UPDATE tbldebitcard a
              SET a.cardstatus        = mStatusCode
              WHERE a.relationship_id = mRelid;
              mRC_DebitCard          := SQL%ROWCOUNT;
              --For Renewal Only
              IF mFlag = '01' THEN
                SELECT b.pin
                INTO mPin
                FROM tblrelationshipauth b
                WHERE b.relationshipauth_id =
                  (SELECT MAX(a.relationshipauth_id)
                  FROM tblcustchannelacct a
                  WHERE a.relationship_id =
                    (SELECT t.existingcardnumber
                    FROM tbldebitcard t
                    WHERE t.relationship_id = mRelid
                    )
                  );
              END IF;
              --Update Status in tblrelationshipAuth
              UPDATE tblrelationshipauth a
              SET a.pin      = mPin,
                a.status     = mStatusCode,
                a.reasoncode = mStatusCode
                || '31'
              WHERE a.relationshipauth_id =
                (SELECT DISTINCT b.relationshipauth_id
                FROM tblcustchannelacct b
                WHERE b.relationship_id = mRelid
                );
              mRC_RelationshipAuth := SQL%ROWCOUNT;
            END IF;
            --Update Final Status
            IF mRC_ProductionLog =1 AND mRC_Production = 1 AND mRC_DebitCard = 1 AND mRC_RelationshipAuth = 1 THEN
              mFinalStatus      := 1;
            ELSE
              mFinalStatus := 0;
            END IF;
            --Update Log
            UPDATE tblimplogoberthur a
            SET a.err_description = 'Status='
              || mStatus
              || ';Cardno='
              || mCardno
              || ';Relid='
              || mRelid
              || ';TYPE='
              || mType
              || ';FLAG='
              || mFlag
              || ';PL='
              || mRC_ProductionLog
              || ';P='
              || mRC_Production
              || ';DC='
              || mRC_DebitCard
              || ';RA='
              || mRC_RelationshipAuth
              || ';S='
              || mFinalStatus
            WHERE a.log_feedback_id = mLogFeedbackid;
          END IF;
          IF mStatus = 'R' THEN
            --Update tblproduction
            UPDATE tblproduction a
            SET a.export_status     = '0'
            WHERE a.relationship_id = mRelid;
            mRC_Production         := SQL%ROWCOUNT;
            --Update status in DebitCard
            UPDATE tbldebitcard a
            SET a.cardstatus        = '11'
            WHERE a.relationship_id = mRelid;
            mRC_DebitCard          := SQL%ROWCOUNT;
            --Update Status in tblrelationshipAuth
            UPDATE tblrelationshipauth a
            SET a.status                = '11',
              a.reasoncode              = '1100'
            WHERE a.relationshipauth_id =
              (SELECT DISTINCT b.relationshipauth_id
              FROM tblcustchannelacct b
              WHERE b.relationship_id = mRelid
              );
            mRC_RelationshipAuth := SQL%ROWCOUNT;
            --Update Final Status
            IF mRC_Production = 1 AND mRC_DebitCard = 1 AND mRC_RelationshipAuth = 1 THEN
              mFinalStatus   := 1;
            ELSE
              mFinalStatus := 0;
            END IF;
            --Update Log
            UPDATE tblimplogoberthur a
            SET a.err_description = 'Status='
              || mStatus
              || ';Cardno='
              || mCardno
              || ';Relid='
              || mRelid
              || ';TYPE='
              || mType
              || ';FLAG='
              || mFlag
              || ';P='
              || mRC_Production
              || ';DC='
              || mRC_DebitCard
              || ';RA='
              || mRC_RelationshipAuth
              || ';S='
              || mFinalStatus
            WHERE a.log_feedback_id = mLogFeedbackid;
          END IF;
        ELSE
          UPDATE tblimplogoberthur a
          SET a.err_description = 'Status='
            || mStatus
            || ';NONE'
          WHERE a.log_feedback_id = mLogFeedbackid;
        END IF;
      END LOOP;
      CLOSE curMain;
      --'PIN_GEN','1'
      outRetVal := SQL%ROWCOUNT;
      COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
      BEGIN
        outMsg := SQLCODE||' '|| SQLERRM;
        ROLLBACK;
        --Test update error code
        errorCode := SQLCODE;
        errorDesc :=SQLERRM;
        UPDATE TBLIMPTMPOBERTHUR
        SET TBLIMPTMPOBERTHUR.Failed = '1' ,
          err_code                   = errorCode,
          err_description            = errorDesc;
        /*       UPdate tblimplogoberthur a
        set a.err_code = errorCode,
        a.err_description = errorDesc;*/
        COMMIT;
        outRetVal := -1;
      END;
    END spInsertOberthurImport;
    /*
    PROCEDURE spMarkRejectOnInsertion
    (
    inErrorCode in VARCHAR2,
    inErrorDesc in varchar2,
    outMsg OUT VARCHAR2,
    outRetVal  OUT NUMBER
    )
    IS
    BEGIN
    Feedback_id varchar2(1024);
    Update TBLIMPLOGENBDEMPINFORMATION set LOG_STATUS = '01';
    --commit;
    END spMarkRejectOnInsertion;
    */
    PROCEDURE SPINSERTIMD(
        outMsg OUT VARCHAR2,
        outRetVal OUT NUMBER )
    IS
      errorCode VARCHAR2(1024);
      errorDesc VARCHAR2(1024);
    BEGIN
      outRetVal := 0;
      outMsg    := 'Executed Successfully';
      /* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
      INSERT
      INTO tblcfgimd
      (
      imd,
      description,
      routingtype,
      trackindex,
      is_local,
      fkpanformat,
      channelid,
      imdtitle,
      imdexpiry,
      pangenscheme,
      servicecode,
      languagecode,
      processingcode,
      cardstatus,
      cardincreamenttype,
      cardtype,
      is_cvv_reqd,
      IS_VISA_IMD,
      institutionid,
      ISS_NETWORK,
      BANK_ACRO,
      IS_MDK_REQD
      )
      SELECT DISTINCT IMD,
      DECODE(description,NULL,'IMD ['
      ||IMD
      ||']',Description), --to facilitate CUP Import | Tabish Habib 14/12/10
      --'IMD ['||IMD||']',
      'C',
      '2',
      'N',
      '0001',
      ISS_NETWORK,
      DECODE(imdtitle,NULL,'IMD Title',imdtitle), --to facilitate CUP Import | Tabish Habib 14/12/10
      --'IMD Title',
      'FY3',
      '1',
      '0001',
      '0001',
      '0001',
      '00',
      '0',
      '01',
      '0',
      '0',
      INSTITUTIONID,
      ISS_NETWORK,
      'IMD['
      ||IMD
      ||']',
      '0'
      FROM TBLIMPTMPIMD ; */
      COMMIT;
      /* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
      INSERT
      INTO TBLCFGTMIMD
      (
      INSTITUTIONID,
      APPINDEX,
      IMD,
      BANKACR,
      TRACK,
      IMDOFFSET,
      IMDLENGTH,
      PANTRACK,
      PANOFFSET,
      TRANSET,
      IMDTYPE,
      TRANSETDESCRIPTION,
      ISLOCAL
      )
      SELECT DISTINCT CFGTM.INSTITUTIONID,
      CFGTM.APPINDEX,
      I.IMD,
      'IMP',
      CFGTM.TRACK,
      CFGTM.IMDOFFSET,
      CFGTM.IMDLENGTH,
      CFGTM.PANTRACK,
      CFGTM.PANOFFSET,
      CFGTM.TRANSET,
      CFGTM.IMDTYPE,
      CFGTM.TRANSETDESCRIPTION,
      CFGTM.ISLOCAL
      FROM TBLCFGTMIMD CFGTM,
      TBLIMPTMPIMD I ,
      TBLCFGIMDCONFIGURATION C
      WHERE CFGTM.IMD     = C.refr_imd
      AND C.IMD_TYPE      = I.IMD_TYPE
      AND C.is_local      = 'N'
      AND C.institutionid = I.INSTITUTIONID
      AND C.entity        = 'TBLCFGTMIMD'; */
      COMMIT;
      /* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
      INSERT
      INTO TBLCFGIMDROUTING
      (
      IMD,
      SRC_CHANNEL,
      INSTITUTIONID,
      TRAN_CODE,
      ROUTING_CHANNEL,
      SORT_INDEX,
      ROUTING_INST
      )
      SELECT DISTINCT I.IMD,
      CFGROUT.SRC_CHANNEL,
      CFGROUT.INSTITUTIONID,
      CFGROUT.TRAN_CODE,
      CFGROUT.ROUTING_CHANNEL,
      CFGROUT.SORT_INDEX,
      CFGROUT.ROUTING_INST
      FROM TBLCFGIMDROUTING CFGROUT,
      TBLIMPTMPIMD I ,
      TBLCFGIMDCONFIGURATION C
      WHERE CFGROUT.IMD   = C.refr_imd
      AND C.iss_network   = I.iss_network
      AND C.is_local      = 'N'
      AND C.institutionid = I.INSTITUTIONID
      AND C.entity        = 'TBLCFGIMDROUTING'; */
      COMMIT;
      outRetVal := SQL%ROWCOUNT;
      --           Exception
      --        WHEN OTHERS THEN
      --          begin
      --            outMsg := SQLCODE||' '|| SQLERRM;
      --            rollback;
      --            errorCode := SQLCODE;
      --            errorDesc :=SQLERRM;
      --           update TBLIMPTMPIMD set
      --                  err_code = errorCode,
      --                  err_description = errorDesc;
      --
      --        outRetVal := 0;
    END SPINSERTIMD;
  PROCEDURE spUpdateMucodecAccountBalance(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    inTITLE T_ACCT_TITLE                        := T_ACCT_TITLE();
    inSTATUS T_ACCT_STATUS                      := T_ACCT_STATUS();
    inACTUAL_BALANCE T_ACCT_ACTUAL_BALANCE      := T_ACCT_ACTUAL_BALANCE();
    inACCOUNT_ID T_ACCT_ACCOUNT_ID              := T_ACCT_ACCOUNT_ID();
    inACCOUNT_TYPE T_ACCT_ACCOUNT_TYPE          := T_ACCT_ACCOUNT_TYPE();
    inACCOUNT_CURRENCY T_ACCT_ACCOUNT_CURRENCY  := T_ACCT_ACCOUNT_CURRENCY();
    inLAST_UPDATED T_ACCT_LAST_UPDATED          := T_ACCT_LAST_UPDATED();
    inBRANCHID T_ACCT_BRANCHID                  := T_ACCT_BRANCHID();
    inAVAILABLE_BALANCE T_ACCT_AVAILABLE_BALANCE:= T_ACCT_AVAILABLE_BALANCE();
    inOLDACCOUNT_ID T_ACCT_OLDACCOUNT_ID        := T_ACCT_OLDACCOUNT_ID();
    inINTERNAL_BRANCH_ID T_INTERNAL_BRANCH_ID   := T_INTERNAL_BRANCH_ID();
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SELECT ACCOUNT_BALANCE."STATUS" ,
      ACCOUNT_BALANCE."ACCOUNTID" , --ACCOUNT_BALANCE."ACCOUNT_ID"       ,
      ACCOUNT_BALANCE."TYPE" ,      --ACCOUNT_BALANCE."ACCOUNT_TYPE"     ,
      ACCOUNT_BALANCE."CURRENCY" ,  --ACCOUNT_BALANCE."ACCOUNT_CURRENCY" ,
      ACCOUNT_BALANCE."ACTUAL_BALANCE" ,
      ACCOUNT_BALANCE."AVAILABLE_BALANCE" bulk collect
    INTO inSTATUS ,
      inACCOUNT_ID ,
      inACCOUNT_TYPE ,
      inACCOUNT_CURRENCY ,
      inACTUAL_BALANCE ,
      inAVAILABLE_BALANCE
    FROM TBLIMPTMPMUCODEC_BALANCE ACCOUNT_BALANCE
    WHERE ACCOUNT_BALANCE.ACTIONFLAG = '02'
    AND ACCOUNT_BALANCE.FAILED      IS NULL;
    FORALL i IN 1..inACCOUNT_ID.COUNT
    UPDATE TBLACCOUNT
    SET STATUS                        = inSTATUS (i),
      ACTUAL_BALANCE                  = TO_CHAR( TO_NUMBER(inACTUAL_BALANCE (i)) - NVL(TO_NUMBER(amt_tran_sum),0) ),
      LAST_UPDATED                    = TO_CHAR(sysdate,'yyyymmdd'),
      AVAILABLE_BALANCE               = TO_CHAR( TO_NUMBER(inAVAILABLE_BALANCE(i)) - NVL(TO_NUMBER(amt_tran_sum),0) ),
      is_settled                      = '1',
      amt_tran_sum                    = '0'
    WHERE TRIM(TBLACCOUNT.ACCOUNT_ID) = (inACCOUNT_ID(i)) -- trim removed due to performance as all balances comes at once, it is transformed in datacopy
    AND ACCOUNT_TYPE                  = inACCOUNT_TYPE (i)
    AND ACCOUNT_CURRENCY              = inACCOUNT_CURRENCY (i);
    outRetVal                        := SQL%ROWCOUNT;
    COMMIT;
  END spUpdateMucodecAccountBalance;
  PROCEDURE spUpdateHBLWatan(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
    tmpRelCursor REF_CURSOR;
    tmpcnic        VARCHAR2(100);
    tmplocation    VARCHAR2(100);
    tmpfirstname   VARCHAR2(100);
    tmpmiddlename  VARCHAR2(100);
    tmplastname    VARCHAR2(100);
    tmpmothersname VARCHAR2(100);
    tmpdob         VARCHAR2(100);
    tmpcustomerid  VARCHAR2(100);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    /* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
    OPEN tmpRelCursor FOR SELECT tblimptmphbl_watan.cnic
    AS
    cnic,
    tblimptmphbl_watan.location
    AS
    loc,
    tblimptmphbl_watan.firstname
    AS
    fname,
    tblimptmphbl_watan.middlename
    AS
    mname,
    tblimptmphbl_watan.lastname
    AS
    lname,
    tblimptmphbl_watan.mothersname
    AS
    mother,
    tblimptmphbl_watan.dob
    AS
    dob,
    tblcustChannelacct.customer_id
    AS
    customerid FROM tblimptmphbl_watan,
    tblcustchannelacct WHERE tblcustchannelacct.relationship_id = tblimptmphbl_watan.rel_id AND tblcustchannelacct.account_id = tblimptmphbl_watan.account_id AND NVL(tblimptmphbl_watan.failed, 0) <> '1';
    LOOP
    FETCH tmpRelCursor
    INTO tmpcnic,
    tmplocation,
    tmpfirstname,
    tmpmiddlename,
    tmplastname,
    tmpmothersname,
    tmpdob,
    tmpcustomerid;
    EXIT
    WHEN tmpRelCursor %NOTFOUND;
    UPDATE TBLCUSTOMER
    SET cnic                     = TMPCNIC,
    homeaddress1               = TMPLOCATION,
    firstname                  = TMPFIRSTNAME,
    middlename                 = TMPMIDDLENAME,
    lastname                   = TMPLASTNAME,
    mothersname                = TMPMOTHERSNAME,
    dateofbirth                = TMPDOB
    WHERE TBLCUSTOMER.CUSTOMERID = TMPCUSTOMERID;
    END LOOP;
    COMMIT;*/
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      /* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
      UPDATE tblimptmphbl_watan
      SET Failed        = '1' ,
      err_code        = errorCode,
      err_description = errorDesc;
      outRetVal        := 0; */
    END;
  END spUpdateHBLWatan;
  PROCEDURE spUpdateHBLTCS(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    errorCode VARCHAR2(1024);
    errorDesc VARCHAR2(1024);
    tmpRelCursor REF_CURSOR;
    tmpcnic        VARCHAR2(100);
    tmplocation    VARCHAR2(100);
    tmpfirstname   VARCHAR2(100);
    tmpmiddlename  VARCHAR2(100);
    tmplastname    VARCHAR2(100);
    tmpmothersname VARCHAR2(100);
    tmpdob         VARCHAR2(100);
    tmpcustomerid  VARCHAR2(100);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    /* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
    INSERT
    INTO tblhbltcs
    (
    TCSCN,
    city,
    delivery_date,
    pickup_date,
    reason_recvd,
    ref_cardnumber,
    status,
    TIME,
    imp_history_id,
    imp_date_time
    )
    SELECT TCSCN,
    CITY,
    DELIVERY_DATE,
    PICKUP_DATE,
    REASON_RECVD,
    REF_CARDNUMBER,
    STATUS,
    TIME,
    HISTORY_ID,
    TO_CHAR(SYSDATE, 'yyyyMMddhhmmss')
    FROM tblimptmphbl_tcs
    WHERE NVL(tblimptmphbl_tcs.failed, 0) <> '1'; */
    /* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
    UPDATE tbldebitcard
    SET deliverystatus = 'Y'
    WHERE EXISTS
    (SELECT ref_cardnumber
    FROM tblimptmphbl_tcs
    WHERE tblimptmphbl_tcs.ref_cardnumber = tbldebitcard.card_interfacing_no
    AND NVL(tblimptmphbl_tcs.failed, 0)  <> '1'
    AND tblimptmphbl_tcs.status           = 'DELIVERED'
    );
    COMMIT; */
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      --Test update error code
      errorCode := SQLCODE;
      errorDesc :=SQLERRM;
      /* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
      UPDATE tblimptmphbl_tcs
      SET Failed        = '1' ,
      err_code        = errorCode,
      err_description = errorDesc;
      outRetVal        := 0; */
    END;
  END spUpdateHBLTCS;
----CUP IMD Import | Tabish Habib | 11/15/2011 | Temperory To be moved to UIPKGIMPDCFBL
/* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
PROCEDURE spPopulateCUPIMD(
inFormatID VARCHAR2 )
AS
BEGIN */
-----Delete null entries
/* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
DELETE
FROM TBLIMPLOGIMD
WHERE trim(SUBSTR(remaining_data,114,12)) IS NULL;
----Set Action Flag
UPDATE tblimplogimd
SET actionflag         ='01'
WHERE log_process_code = '00' -- not processed
AND actionflag        IS NULL
AND FORMAT_ID          = inFormatID; */
----Extract Fields from each Record
/* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
UPDATE tblimplogimd
SET IMD       = trim(SUBSTR(remaining_data,114,12)),
imdtitle    = trim(SUBSTR(remaining_data,11,60)),
description = trim(SUBSTR(remaining_data,1,11)),
iss_network =
(SELECT channelid FROM tblcfgchannel WHERE channelname LIKE '%CUP%'
),
imd_type             = 'CUP'
WHERE log_process_code = '00' -- not processed
AND FORMAT_ID          = inFormatID; */
----Mark allready present IMD's
/* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
UPDATE tblimplogimd
SET log_process_code = '02',
err_code           ='00',
log_status         ='03',
err_description    ='IMD Code ['
||IMD
||'] Already Exist'
WHERE IMD IN
(SELECT IMD FROM TBLCFGIMD
)
AND log_process_code = '00' -- not processed
AND FORMAT_ID        = inFormatID;
COMMIT; */
----Copy Data from Log to Temperory Table
/* commented to avoid package compilation errors while running BaseII import (by Mx, 2nd May 2012)
INSERT
INTO TBLIMPTMPIMD
(
LOG_FEEDBACK_ID,
LOG_PROCESS_CODE,
LOG_STATUS,
HISTORY_ID,
FORMAT_ID,
RECORDCATEGORY,
REMAINING_DATA,
ACTIONFLAG,
INSTITUTIONID,
IMD,
ERR_CODE,
ERR_DESCRIPTION,
IMD_TYPE,
ISS_NETWORK,
TYPE_CHECKER,
DESCRIPTION,
IMDTITLE
)
SELECT a.LOG_FEEDBACK_ID,
a.LOG_PROCESS_CODE,
a.LOG_STATUS,
a.HISTORY_ID,
a.FORMAT_ID,
a.RECORDCATEGORY,
a.REMAINING_DATA,
a.ACTIONFLAG,
a.INSTITUTIONID,
a.IMD,
a.ERR_CODE,
a.ERR_DESCRIPTION,
a.IMD_TYPE,
a.ISS_NETWORK,
a.TYPE_CHECKER,
a.DESCRIPTION,
a.IMDTITLE
FROM TBLIMPLOGIMD a
WHERE a.log_process_code = '00' --not processed
AND a.FORMAT_ID          = inFormatID;
COMMIT; */
--END spPopulateCUPIMD;
-----
  PROCEDURE spUpdateDeliveryStatus(
      outMsg OUT VARCHAR2,
      OUTRETVAL OUT NUMBER)
  AS
    historyID VARCHAR2(100);
    SPNAME    VARCHAR2(100);
    spDesc    VARCHAR2(500);
  BEGIN
    outRetVal := 0;
    OUTMSG    := 'Executed Successfully';
    SPNAME    := 'spUpdateDeliveryStatus';
    SPDESC    := 'SP to UPDATE DELIVERY STATUS IN TBLDEBITCARD from TBLIMPTMPABL_CARDTRACK FOR CARD TRACKING IMP';
    SELECT MAX(HISTORY_ID)
    INTO HISTORYID
    FROM TBLIMPFORMATHISTORY
    WHERE format_id='994';
    UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
    --YOUSUF OPTIMIZATION
    -- UPDATE TBLDEBITCARD SET TBLDEBITCARD.DELIVERYSTATUS = (SELECT TBLIMPTMPABL_CARDTRACK.STATUS FROM TBLIMPTMPABL_CARDTRACK
    --                                                                WHERE TBLIMPTMPABL_CARDTRACK.RELATIONSHIP_ID = TBLDEBITCARD.RELATIONSHIP_ID
    --                                                                  AND TBLIMPTMPABL_CARDTRACK.FAILED IS NULL
    --                                                                  AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00')
    --    WHERE EXISTS(
    --                  SELECT TBLIMPTMPABL_CARDTRACK.RELATIONSHIP_ID FROM TBLIMPTMPABL_CARDTRACK
    --                                                    WHERE TBLDEBITCARD.RELATIONSHIP_ID = TBLIMPTMPABL_CARDTRACK.RELATIONSHIP_ID
    --                                                      AND TBLIMPTMPABL_CARDTRACK.FAILED IS NULL
    --                                                                  AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00');
    --YOUSUF OPTIMIZATION
    EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    MERGE INTO TBLDEBITCARD CARD USING
    (SELECT
      /*+ parallel(6) */
      STATUS,
      RELATIONSHIP_ID
    FROM TBLIMPTMPABL_CARDTRACK
    WHERE LOG_PROCESS_CODE            = '00'
    AND FAILED                       IS NULL
    ) TRACK ON ( CARD.RELATIONSHIP_ID = TRACK.RELATIONSHIP_ID )
  WHEN MATCHED THEN
    UPDATE SET CARD.DELIVERYSTATUS = TRACK.STATUS;
    UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      outRetVal := -1;
    END;
  END spUpdateDeliveryStatus;
  PROCEDURE spInsertCustomerDet(
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER )
  AS
    historyID VARCHAR2(100);
    SPNAME    VARCHAR2(100);
    spDesc    VARCHAR2(500);
  BEGIN
    outRetVal := 0;
    outMsg    := 'Executed Successfully';
    SPNAME    := 'spInsertCustomerDet';
    SPDESC    := 'SP to UPDATE AND INSERT CUSTOMER DETAILS FOR CARD TRACK IMP';
    SELECT MAX(HISTORY_ID)
    INTO HISTORYID
    FROM TBLIMPFORMATHISTORY
    WHERE format_id='994';
    UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
    -- UPDATE DEL STATUS
    UPDATE TBLCUSTOMERDETAIL
    SET TBLCUSTOMERDETAIL.PARAMVALUE =
      (SELECT TBLIMPTMPABL_CARDTRACK.STATUS
      FROM TBLIMPTMPABL_CARDTRACK
      WHERE TBLCUSTOMERDETAIL.CUSTOMERID          = TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID
      AND TBLIMPTMPABL_CARDTRACK.FAILED          IS NULL
      AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
      AND TBLCUSTOMERDETAIL.IDENTFIER             = TBLIMPTMPABL_CARDTRACK.CARDNUMBER
      AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '1'
      )
    WHERE PARAMID = '57'
    AND EXISTS
      (SELECT TBLIMPTMPABL_CARDTRACK.STATUS
      FROM TBLIMPTMPABL_CARDTRACK
      WHERE TBLCUSTOMERDETAIL.CUSTOMERID          = TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID
      AND TBLIMPTMPABL_CARDTRACK.FAILED          IS NULL
      AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
      AND TBLCUSTOMERDETAIL.IDENTFIER             = TBLIMPTMPABL_CARDTRACK.CARDNUMBER
      AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '1'
      );
    -- UPDATE CONSIGNMENT_NUM
    UPDATE TBLCUSTOMERDETAIL
    SET TBLCUSTOMERDETAIL.PARAMVALUE =
      (SELECT TBLIMPTMPABL_CARDTRACK.CONSIGNMENT_NUM
      FROM TBLIMPTMPABL_CARDTRACK
      WHERE TBLCUSTOMERDETAIL.CUSTOMERID          = TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID
      AND TBLIMPTMPABL_CARDTRACK.FAILED          IS NULL
      AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
      AND TBLCUSTOMERDETAIL.IDENTFIER             = TBLIMPTMPABL_CARDTRACK.CARDNUMBER
      AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '1'
      )
    WHERE PARAMID = '58'
    AND EXISTS
      (SELECT TBLIMPTMPABL_CARDTRACK.CONSIGNMENT_NUM
      FROM TBLIMPTMPABL_CARDTRACK
      WHERE TBLCUSTOMERDETAIL.CUSTOMERID          = TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID
      AND TBLIMPTMPABL_CARDTRACK.FAILED          IS NULL
      AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
      AND TBLCUSTOMERDETAIL.IDENTFIER             = TBLIMPTMPABL_CARDTRACK.CARDNUMBER
      AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '1'
      );
    -- UPDATE RECV_NAME
    UPDATE TBLCUSTOMERDETAIL
    SET TBLCUSTOMERDETAIL.PARAMVALUE =
      (SELECT TBLIMPTMPABL_CARDTRACK.RECV_NAME
      FROM TBLIMPTMPABL_CARDTRACK
      WHERE TBLCUSTOMERDETAIL.CUSTOMERID          = TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID
      AND TBLIMPTMPABL_CARDTRACK.FAILED          IS NULL
      AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
      AND TBLCUSTOMERDETAIL.IDENTFIER             = TBLIMPTMPABL_CARDTRACK.CARDNUMBER
      AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '1'
      )
    WHERE PARAMID = '59'
    AND EXISTS
      (SELECT TBLIMPTMPABL_CARDTRACK.RECV_NAME
      FROM TBLIMPTMPABL_CARDTRACK
      WHERE TBLCUSTOMERDETAIL.CUSTOMERID          = TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID
      AND TBLIMPTMPABL_CARDTRACK.FAILED          IS NULL
      AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
      AND TBLCUSTOMERDETAIL.IDENTFIER             = TBLIMPTMPABL_CARDTRACK.CARDNUMBER
      AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '1'
      );
    -- UPDATE DELIVERY_DATE
    UPDATE TBLCUSTOMERDETAIL
    SET TBLCUSTOMERDETAIL.PARAMVALUE =
      (SELECT TBLIMPTMPABL_CARDTRACK.DELIVERY_DATE
      FROM TBLIMPTMPABL_CARDTRACK
      WHERE TBLCUSTOMERDETAIL.CUSTOMERID          = TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID
      AND TBLIMPTMPABL_CARDTRACK.FAILED          IS NULL
      AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
      AND TBLCUSTOMERDETAIL.IDENTFIER             = TBLIMPTMPABL_CARDTRACK.CARDNUMBER
      AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '1'
      )
    WHERE PARAMID = '60'
    AND EXISTS
      (SELECT TBLIMPTMPABL_CARDTRACK.DELIVERY_DATE
      FROM TBLIMPTMPABL_CARDTRACK
      WHERE TBLCUSTOMERDETAIL.CUSTOMERID          = TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID
      AND TBLIMPTMPABL_CARDTRACK.FAILED          IS NULL
      AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
      AND TBLCUSTOMERDETAIL.IDENTFIER             = TBLIMPTMPABL_CARDTRACK.CARDNUMBER
      AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '1'
      );
    -- INSERT INTO TBLCUSTOMERDETAILS FOR THOSE CUSTOMERS WHOSE DETAILS ARE NOT PRESENT IN IRIS
    -- INSERT DEL STATUS
    INSERT
    INTO TBLCUSTOMERDETAIL
      (
        CUSTOMERID,
        PARAMID,
        PARAMVALUE,
        IDENTFIER
      )
    SELECT TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID,
      '57' PARAMID,
      TBLIMPTMPABL_CARDTRACK.STATUS PARAMVALUE,
      TBLIMPTMPABL_CARDTRACK.CARDNUMBER IDENTFIER
    FROM TBLIMPTMPABL_CARDTRACK
    WHERE TBLIMPTMPABL_CARDTRACK.FAILED        IS NULL
    AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
    AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '0';
    -- INSERT CONSIGNMENT_NUM
    INSERT
    INTO TBLCUSTOMERDETAIL
      (
        CUSTOMERID,
        PARAMID,
        PARAMVALUE,
        IDENTFIER
      )
    SELECT TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID,
      '58' PARAMID,
      TBLIMPTMPABL_CARDTRACK.CONSIGNMENT_NUM PARAMVALUE,
      TBLIMPTMPABL_CARDTRACK.CARDNUMBER IDENTFIER
    FROM TBLIMPTMPABL_CARDTRACK
    WHERE TBLIMPTMPABL_CARDTRACK.FAILED        IS NULL
    AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
    AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '0';
    -- INSERT RECV_NAME
    INSERT
    INTO TBLCUSTOMERDETAIL
      (
        CUSTOMERID,
        PARAMID,
        PARAMVALUE,
        IDENTFIER
      )
    SELECT TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID,
      '59' PARAMID,
      TBLIMPTMPABL_CARDTRACK.RECV_NAME PARAMVALUE,
      TBLIMPTMPABL_CARDTRACK.CARDNUMBER IDENTFIER
    FROM TBLIMPTMPABL_CARDTRACK
    WHERE TBLIMPTMPABL_CARDTRACK.FAILED        IS NULL
    AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
    AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '0';
    -- INSERT DELIVERY_DATE
    INSERT
    INTO TBLCUSTOMERDETAIL
      (
        CUSTOMERID,
        PARAMID,
        PARAMVALUE,
        IDENTFIER
      )
    SELECT TBLIMPTMPABL_CARDTRACK.CUSTOMER_ID,
      '60' PARAMID,
      TBLIMPTMPABL_CARDTRACK.DELIVERY_DATE PARAMVALUE,
      TBLIMPTMPABL_CARDTRACK.CARDNUMBER IDENTFIER
    FROM TBLIMPTMPABL_CARDTRACK
    WHERE TBLIMPTMPABL_CARDTRACK.FAILED        IS NULL
    AND TBLIMPTMPABL_CARDTRACK.LOG_PROCESS_CODE = '00'
    AND TBLIMPTMPABL_CARDTRACK.ISCUSTDETUPDATE  = '0';
    UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      outRetVal := -1;
    END;
  END spInsertCustomerDet;
  PROCEDURE spInsertPreGenCardData(
      outMsg OUT VARCHAR2,
      OUTRETVAL OUT NUMBER)
  AS
    historyID VARCHAR2(100);
    SPNAME    VARCHAR2(100);
    spDesc    VARCHAR2(500);
  BEGIN
    outRetVal := 0;
    OUTMSG    := 'Executed Successfully';
    INSERT
    INTO TBLPREGENERATEDCARDDATA
      (
        DATA_ENTRY_DATE,
        RELATIONSHIP_ID,
        RECORD_TYPE,
        TRACK_1_DATA,
        TRACK_2_DATA,
        CVV,
        CVV2,
        ICVV,
        PIN_BLOCK
      )
    SELECT DATA_ENTRY_DATE,
      RELATIONSHIP_ID,
      RECORD_TYPE,
      TRACK_1_DATA,
      TRACK_2_DATA,
      CVV,
      CVV2,
      ICVV,
      PIN_BLOCK
    FROM TBLIMPPREGENERATEDCARDDATA tmp
      --Rizwan Hussain for stop duplicate data
    WHERE (tmp.relationship_id,tmp.record_type) NOT IN
      (SELECT pre.relationship_id,pre.record_type FROM TBLPREGENERATEDCARDDATA pre
      );
    --Rizwan Hussain for stop duplicate data
    -- where ACTIONFLAG='01';
    outRetVal := SQL%ROWCOUNT;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      outMsg := SQLCODE||' '|| SQLERRM;
      ROLLBACK;
      outRetVal := -1;
    END;
  END spInsertPreGenCardData;
END UIPKGIMPORTINSERTION;
/
