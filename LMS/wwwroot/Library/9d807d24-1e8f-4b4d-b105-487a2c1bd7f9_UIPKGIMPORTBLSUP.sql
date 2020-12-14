CREATE OR REPLACE PACKAGE "UIPKGIMPORTBL"
AS
TYPE REF_CURSOR
IS
  REF
  CURSOR;
  PROCEDURE spBL_UpdateCustomerId(
      outRetVal OUT NUMBER );
  PROCEDURE spGeneratePANforImport(
      inProduct_ID     IN VARCHAR2,
      inCustomer_ID    IN VARCHAR2,
      inAccount_Number IN VARCHAR2,
    --  inCustomerStaff  IN VARCHAR2,
    --  inBranchCode     IN VARCHAR2,
      outPAN OUT VARCHAR2,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_CustomerAccountLinking(
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_PrepareCustomerData(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );

  PROCEDURE spBL_PrepareAccountData(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER);

  PROCEDURE spBL_PrepareCardData(
      inFormatID VARCHAR2,
     outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER
      );

  PROCEDURE spBL_CheckAccountExistance(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );

  PROCEDURE SPBL_CHECKFORCUSTCARDEXISTANCE(
      OUTRETVAL OUT NUMBER );

  PROCEDURE spBL_CheckBranchExistance(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );


  PROCEDURE spBL_CheckCustomerExistance(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_CheckCardExistance(
      outRetVal OUT NUMBER );
  PROCEDURE spBLGetDefaultCTLAcct(
      inINSTITUTIONID IN VARCHAR2,
      outCursor OUT REF_CURSOR );
  PROCEDURE spBL_MarkProductDefaultOnGDCI(
      outRetVal OUT NUMBER );

  PROCEDURE spBL_AddCustomerInternalBranch(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );

  PROCEDURE spBL_AddAccountInternalBranch(
      outRetVal OUT NUMBER );
  PROCEDURE spGetInternalBranchId(
      inBranchId      IN VARCHAR2,
      inInstitutionID IN VARCHAR2,
      outInternalBranchId OUT VARCHAR2 );
  PROCEDURE spCheckCardBasedProduct(
      inProductID IN VARCHAR2,
      outCardBasedProduct OUT VARCHAR2 );
  PROCEDURE spBL_GetDistinctProducts(
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spGetImportChannelsbyProduct(
      inProductID IN VARCHAR2,
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_GetRelationsForChannel(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_GetExistRelForChannel(
      outRetVal OUT NUMBER );
    /*
    ***************************************************************************
    Created By  :  Salman Aziz
    Dated       : 01 April 2010
    Description : PrepareCustomerProducts with IsDefaultOnGDC = 1
    ***************************************************************************
    S#     Who           Date          Change Description
    ***************************************************************************
    ***************************************************************************
    */
  PROCEDURE spBL_AddCustomerProductsOnGDCI(
      outRetVal OUT NUMBER );
  PROCEDURE spTranListByProdChanCurr(
      inPRODUCTID     IN VARCHAR2,
      inChannelID     IN VARCHAR2,
      inAcctCurrency  IN VARCHAR2,
      inInstitutionID IN VARCHAR2,
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spGetBaseCurrecny(
      inInstitutionID IN VARCHAR2,
      outBaseCurrecncy OUT VARCHAR2,
      outRetVal OUT NUMBER );
  PROCEDURE spGetPinSharingCategory(
      inChannelID IN VARCHAR2,
      outPinSharingCategory OUT VARCHAR2,
      outRetVal OUT NUMBER );
  PROCEDURE spGetATMDefaultAccount(
      inCustomerID IN VARCHAR2,
      outAccountNumber OUT VARCHAR2 );
  PROCEDURE spBL_GetLimitRelationsByProd(
      inProductID IN VARCHAR,
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_PrepareRemainingLimits(
      inLimitType IN VARCHAR2,
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_FilterRelationsbyChannel(
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_PrepareProductionEntries(
      inStageCode IN VARCHAR2,
      inProductID IN VARCHAR2,
      inChannelID IN VARCHAR2,
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_PrepareRelationshipAuth(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_SetPrimaryPAN --MCB Specific Function
    (
      outProductID OUT VARCHAR2,
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_CheckMaxSupplyAllowed(
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_GetCustomerWithNewProduct(
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spCheckDefaultAlreadyExists(
      inChannelId      IN VARCHAR2,
      inRelationshipId IN VARCHAR2,
      inProductId      IN VARCHAR2,
      outRetVal OUT NUMBER );
  PROCEDURE spCheckAccountAlreadyLinked(
      inChannelId IN VARCHAR2,
      inAccountId IN VARCHAR2,
      outRetVal OUT NUMBER );

  PROCEDURE spBL_GetCardsWithPAN(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );

  PROCEDURE spBL_UpdateAccountBalance(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_SetRelationShipAuth(
      outcursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spInsert(
      p_input IN REF_CURSOR );
  PROCEDURE spBL_SetCardProductByIMD(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_SetRelationProductByIMD(
      outRetVal OUT NUMBER );

  PROCEDURE spBL_SetTranPermission(
       inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );

  PROCEDURE spBL_PrepareCustomerProducts(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );

  PROCEDURE spBL_SetLimitProductByIMD(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_GenerateLimitRows(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_setAccountRelFields(
      inXML IN CLOB,
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_setORIGINAL_AcctRelFields(
      inXML IN CLOB,
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_makeFinalAccountRel(
      inXML IN CLOB,
      outCursor OUT REF_CURSOR,
      outRetVal OUT NUMBER );

  PROCEDURE spBL_RegisterProductionCycle(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );

  PROCEDURE spBL_ApplyProductBasedLimits(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );

  PROCEDURE spBL_UpdateCardDetailsPAN(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_UpdateCustomerType(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_UpdateCustomerBranch(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_UpdateCardBranch(
      inFormatID VARCHAR2,
      outMsg OUT VARCHAR2,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_UpdateAccountRelProduct(
      outRetVal OUT NUMBER );
    --added by tanveer used in mucodec
  PROCEDURE spBL_ImportRecordIfBranchExist(
      inFormatId IN VARCHAR2,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_MarkFirstAcctDefOnChan(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_SetRelationShipAuth(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_MarkFailed(
      inTableName       IN VARCHAR2,
      inLogFeedBackId   IN VARCHAR2,
      inErr_code        IN VARCHAR2,
      inErr_description IN VARCHAR2,
      outRetVal OUT NUMBER );
  PROCEDURE spBL_GetTempTable(
      inTableName IN VARCHAR2,
      OUTCURSOR OUT REF_CURSOR );
    /***************************************************************************
    Created By  : Salman Aziz
    Dated       : 28-April-2010
    Description : Force Pin Generation performed by using
    TBLIMPTMPCARDOPS ( new Temp table for operation)
    ***************************************************************************
    S#     Who           Date          Change Description
    ***************************************************************************
    ***************************************************************************/
  PROCEDURE spInsertCardForcePinGeneration(
      outRetVal OUT NUMBER );
  PROCEDURE spBL_AssignPrimaryPAN(
      outRetVal OUT NUMBER );
    FUNCTION fnGetPrimaryPAN(
        inRelationshipID VARCHAR2 )
      RETURN VARCHAR2;
    FUNCTION fnIsBranchExist(
        inBranchId      IN VARCHAR2,
        inInstitutionID IN VARCHAR2 )
      RETURN VARCHAR2;
      -- Added by Waqas Ahmed
    FUNCTION fnIsIMDExist(
        inIMD           IN VARCHAR2,
        inInstitutionID IN VARCHAR2 )
      RETURN VARCHAR2;
      -- Added by Waqas Ahmed
    PROCEDURE spBL_AssignInstitutionAcctRel(
        outRetVal OUT NUMBER );
      -- Added by Waqas Ahmed
    PROCEDURE spBL_CheckIMDExistance(
        outRetVal OUT NUMBER );
    PROCEDURE spBL_ApplyProductCharge(
        inFormatID VARCHAR2,
        outMsg OUT VARCHAR2,
        outRetVal OUT NUMBER );
      --<ENBD MERGE: AUBY [28-NOV-2011]>
    PROCEDURE spBL_AddMeshTranLog(
        outRetVal OUT NUMBER );
      --</ENBD MERGE: AUBY [28-NOV-2011]>
    PROCEDURE SPBL_INVALIDACTIONCARDADD(
        OUTRETVAL OUT NUMBER );

END UIPKGIMPORTBL;
/


CREATE OR REPLACE PACKAGE BODY      "UIPKGIMPORTBL"
AS
  PROCEDURE spBL_UpdateCustomerId(
      outRetVal OUT NUMBER )
  AS
  BEGIN
    /* TODO implementation required */
    --update customerid from customer for updates
    UPDATE tblimptmpcustomer tc
    SET CUSTOMERID =
      (SELECT MIN(CustomerId) FROM tblcustomer cust WHERE tc.cnic = cust.cnic
      )
    WHERE failed  IS NULL
    AND actionflag = '02';
    --update customerid from customer for updates of foreign customer
    UPDATE tblimptmpcustomer tc
    SET
      (
        CUSTOMERID
      )
      = --cnic will contain pan
      (SELECT MIN(CustomerId)
      FROM tblcustomer cust
      WHERE tc.cnic = cust.passport_no
      )
    WHERE failed                    IS NULL
    AND tc.customerid               IS NULL
    AND actionflag                   = '02'
    AND trim(upper(tc.nationality)) != 'PAKISTANI';
    --update existing customer cnic for primary products only when customer exists and is sent as for adddition
    UPDATE tblimptmpcustomer tc
    SET actionflag = '02',
      CUSTOMERID   =
      (SELECT MIN(c.CustomerId) FROM tblcustomer c WHERE c.cnic = tc.cnic
      )
    WHERE failed  IS NULL
    AND actionflag = '01'
    AND cnic      IN
      (SELECT cnic FROM tblcustomer
      )
    AND (cnic, recordnumber) IN
      (SELECT cnic,
        recordnumber
      FROM tblimptmpcard c
      WHERE tc.cnic                                                  = c.cnic
      AND UIPKGIMPDCABL.fnIsPrimaryProduct(c.format_id, c.productid) = 'true'
      );
    --update existing customer cnic for primary products only when customer exists and is sent as for adddition
    UPDATE tblimptmpcustomer tc
    SET
      (
        actionflag,
        CUSTOMERID
      )
      =
      (SELECT '02',
        MIN(c.CUSTOMERID)
      FROM tblcustomer c
      WHERE c.passport_no = tc.cnic
      )
    WHERE failed  IS NULL
    AND actionflag = '01'
    AND cnic      IN
      (SELECT passport_no FROM tblcustomer
      )
    AND (cnic, recordnumber) IN
      (SELECT cnic,
        recordnumber
      FROM tblimptmpcard c
      WHERE tc.cnic                                                  = c.cnic
      AND UIPKGIMPDCABL.fnIsPrimaryProduct(c.format_id, c.productid) = 'true'
      )
    AND trim(upper(tc.nationality)) != 'PAKISTANI';
    --add new auto customer id for customers that are new
    UPDATE tblimptmpcustomer tc
    SET CUSTOMERID  = seq_customerid.nextval
    WHERE failed   IS NULL
    AND customerid IS NULL ;
    UPDATE tblimptmpcustomer
    SET failed        = 1,
      err_description = 'Customer failed. Customer Id not generated'
    WHERE failed     IS NULL
    AND CUSTOMERID   IS NULL;
    /*update customerid from customer. joining on the basis of record number because of supplementary
    customers will have a different customer id but cnic of primary
    */
    UPDATE TBLIMPTMPCARD c
    SET CUSTOMERID =
      (SELECT CustomerId
      FROM TBLIMPTMPCUSTOMER cust
      WHERE c.cnic       = cust.cnic
      AND c.recordnumber = cust.recordnumber
      AND cust.failed   IS NULL
      )
    WHERE failed IS NULL;
    /*in case of multiple primary product cards on a customer, customer will be one
    but multiple rows for cards so joining on record number will miss those and thererfore
    updating the null ones which have primary cards
    */
    UPDATE TBLIMPTMPCARD c
    SET CUSTOMERID =
      (SELECT CustomerId
      FROM TBLIMPTMPCARD cust
      WHERE c.cnic                                                         = cust.cnic
      AND cust.failed                                                     IS NULL
      AND UIPKGIMPDCABL.fnIsPrimaryProduct(cust.format_id, cust.productid) = 'true'
      AND cust.customerid                                                 IS NOT NULL
      )
    WHERE CUSTOMERID IS NULL
    AND failed       IS NULL;
    UPDATE TBLIMPTMPCARD
    SET failed        = 1,
      err_description = 'Customer failed. Customer Id not generated'
    WHERE failed     IS NULL
    AND CUSTOMERID   IS NULL;
    --update customerid from card. since card data will always be present and its linking to account.
    UPDATE TBLIMPTMPACCOUNT acc
    SET CUSTOMERID =
      (SELECT CustomerId
      FROM TBLIMPTMPCARD cust
      WHERE acc.cnic       = cust.cnic
      AND acc.recordnumber = cust.recordnumber
      AND cust.failed     IS NULL
      )
    WHERE failed IS NULL
      --AND actionflag = '01'
      ;
    UPDATE TBLIMPTMPACCOUNT
    SET failed        = 1,
      err_description = 'Customer failed. Customer Id not generated'
    WHERE failed     IS NULL
    AND CUSTOMERID   IS NULL;
    UPDATE TBLIMPTMPACCOUNT_REL accrel
    SET
      (
        RELATIONSHIP_ID,
        CUSTOMER_ID
      )
      =
      (SELECT CustomerId,
        CustomerId
      FROM TBLIMPTMPCARD acc
      WHERE accrel.recordnumber = acc.recordnumber
      AND accrel.cnic           =acc.cnic
      )
    WHERE failed IS NULL
      --AND actionflag = '01'
      ;
    UPDATE TBLIMPTMPACCOUNT_REL
    SET failed           = 1,
      err_description    = 'Duplicate record/Matching record not found in customer.'
    WHERE failed        IS NULL
    AND relationship_id IS NULL;
    outRetVal           := 1;
    COMMIT;
  END spBL_UpdateCustomerId;
/*
***************************************************************************
Created By  :
Dated      :
Description :
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.    Fahad Ali     28-Feb-10     added field start index for substring support
2.    Tanveer Ali   26-nov-10     modify sp with uipkgprsrelationship spgeneratepan for pan range
3.    Fariha        2-Dec-13      Modified SP to sync it with spgeneratePAN from UIPKGPRSRELATIONSHIP
and updated logic to add branch code in PAN where applicable
***************************************************************************
*/
  PROCEDURE spGeneratePANforImport(
      inProduct_ID     IN VARCHAR2,
      inCustomer_ID    IN VARCHAR2,
      inAccount_Number IN VARCHAR2,
      -- inCustomerStaff  IN VARCHAR2,
      -- inBranchCode     IN VARCHAR2,
      outPAN OUT VARCHAR2,
      outRetVal OUT NUMBER )
  IS
    -------DATA DECLARATIONS---------------------------------------------------
    l_IMD             VARCHAR2(50);
    l_BranchCode      VARCHAR2(50);
    l_ProductCode     VARCHAR2(50);
    l_ProductType     VARCHAR2(50);
    l_CustomerStaff   VARCHAR2(50);
    l_Modulus10       VARCHAR2(50);
    l_Constant        VARCHAR2(50);
    l_PAN             VARCHAR2(50);
    l_Field           VARCHAR2(50);
    l_FieldStartIndex NUMBER;
    l_Sequence        NUMBER;
    l_CustomerCount   NUMBER;
    l_Range           VARCHAR2(20);
    l_HighRange       VARCHAR2(20);
    l_NextRange       VARCHAR2(20);
    l_count           NUMBER;
    -- Fahad - 28/11/2011 - Merged from ENBD
    l_IsProductPanRange VARCHAR2(20);
    l_RangeMiss         VARCHAR2(20); -- For missing the low pan range
    l_OrigSeq           VARCHAR2(20);
    -- Fahad - 28/11/2011 - Merged from ENBD
    -------CURSOR DECLARATIONS-------------------------------------------------
    /* Create the cursor type. */
  TYPE l_CursorType
IS
  REF
  CURSOR
    RETURN tblCFGPanFormatDetail%ROWTYPE;
    /* Declare a cursor variable of that type. */
    l_CurPinMailerDetail l_CursorType;
    /* Declare a record with same structure as cursor variable. */
    l_RecPinMailerDetail tblCFGPanFormatDetail%ROWTYPE;
    ------------------------------------------------------------------------------
  BEGIN
    outRetval      := 0;
    l_PAN          :='';
    l_CustomerCount:=0;
    ---------RETRIEVING DATA--------------------------------------------------------
    SELECT COUNT(*)
    INTO l_CustomerCount
    FROM TblimptmpCustomer
    WHERE CustomerID =inCustomer_ID;
  IF l_CustomerCount > 0 THEN
    SELECT Branch_Code,
      CustomerType
    INTO l_BranchCode,
      l_CustomerStaff
    FROM TblimptmpCustomer
    WHERE CustomerID=inCustomer_ID;
  ELSE
    l_BranchCode   :='';
    l_CustomerStaff:='';
  END IF;
SELECT TBLCFGPRODUCTDETAIL.PRODUCTCODE,
  IMD,
  NVL(ISPANRANGE,'0') --product pan range flag populated here  18/07/11   fahad
INTO l_ProductCode,
  l_IMD,
  l_IsProductPanRange
FROM TBLCFGProduct,
  TBLCFGPRODUCTDETAIL
WHERE TBLCFGProduct.PRODUCT_ID = TBLCFGPRODUCTDETAIL.PRODUCT_ID
AND TBLCFGProduct.Product_ID   = inProduct_ID;
---------------------------------------------------------------------------------
/* Open the cursor variable, associating with it a SQL statement. */
OPEN l_CurPinMailerDetail FOR SELECT tblcfgpanformatdetail.* FROM tblcfgProductDetail,
tblcfgpanformat,
tblcfgpanformatdetail WHERE tblcfgProductDetail.PANFORMAT_ID = tblcfgpanformat.PANFORMATID AND tblcfgpanformat.PANFORMATID = tblcfgpanformatdetail.FKPANFORMATID AND tblcfgProductDetail.PRODUCT_ID=inProduct_ID Order by tblcfgpanformat.PANFORMATID,
to_number(StartIndex);
LOOP
  /* Fetch from the cursor variable. */
  FETCH l_CurPinMailerDetail
  INTO l_RecPinMailerDetail;
  EXIT
WHEN l_CurPinMailerDetail %NOTFOUND;
  --Loading Field Start Index variable
  IF l_RecPinMailerDetail.FieldStartIndex              IS NULL THEN
    l_FieldStartIndex                                  := 0;
  ELSIF to_number(l_RecPinMailerDetail.FieldStartIndex) > 0 THEN
    l_FieldStartIndex                                  := to_number(l_RecPinMailerDetail.FieldStartIndex);
  ELSE
    l_FieldStartIndex := 0;
  END IF;
  --REPLACING FIELDS
  IF TRIM(UPPER(l_RecPinMailerDetail.FieldName))<> 'SEQUENCE' AND TRIM(UPPER(l_RecPinMailerDetail.FieldName))<> 'MODULUS-10 CHECK DIGIT' THEN
    l_Field                                     :=
    CASE TRIM(UPPER(l_RecPinMailerDetail.FieldName))
    WHEN 'IMD' THEN
      SUBSTR(l_IMD,l_FieldStartIndex, l_RecPinMailerDetail.Length) -- l_IMD
    WHEN 'BRANCHCODE' THEN
      SUBSTR(l_BranchCode,l_FieldStartIndex, l_RecPinMailerDetail.Length) --l_BranchCode
    WHEN 'PRODUCT CODE' THEN
      SUBSTR(l_ProductCode,l_FieldStartIndex, l_RecPinMailerDetail.Length) --l_ProductCode
    WHEN 'CUSTOMER/STAFF' THEN
      l_CustomerStaff
    WHEN 'ACCOUNT NUMBER' THEN
      SUBSTR(NVL(inAccount_Number,''),l_FieldStartIndex, l_RecPinMailerDetail.Length) --NVL(inAccount_Number,'')
    WHEN 'CONSTANT' THEN
      TRIM(UPPER(l_RecPinMailerDetail.VALUE))
    END;
    IF LENGTH(l_Field) <> l_RecPinMailerDetail.Length THEN
      outRetVal        :=-1055;
      RETURN;
    END IF;
    --GENERATING SEQUENCE
  ELSE
    -- Fahad - 28/11/2011 - Merged from ENBD
    IF TRIM(UPPER(L_RECPINMAILERDETAIL.FIELDNAME))= 'SEQUENCE' THEN
      -- Get Active Range for PREFIX
      INSERT
      INTO TBLPANLOG
        (
          PREFIX,
          COUNTER,
          RANGE_ID,
          STATUS
        )
      SELECT l_PAN,
        LOW_RANGE,
        RANGE_ID,
        STATUS
      FROM TBLPANRANGE
      WHERE IMD         = l_IMD
      AND STATUS        = '0'
      AND RANGE_ID NOT IN
        (SELECT RANGE_ID FROM TBLPANLOG WHERE PREFIX = l_PAN
        );
      COMMIT;
      IF l_IsProductPanRange = '1' THEN
        SELECT COUNT(TA.Counter),
          MIN(TA.Counter)
        INTO l_Count,
          l_Sequence
        FROM TBLPANLOG TA,
          TBLPRODUCTPANRANGE TB
        WHERE TA.RANGE_ID = TB.RANGE_ID
        AND TB.PRODUCT_ID = inProduct_ID
        AND TA.PREFIX     =l_PAN
        AND TA.STATUS     = '0';
      ELSE
        SELECT COUNT(*),
          MIN(COUNTER)
        INTO l_Count,
          l_Sequence
        FROM TBLPANLOG
        WHERE PREFIX =l_PAN
        AND STATUS   = '0';
      END IF;
      IF l_Count   = 0 THEN -- return error range not found
        OUTRETVAL :=-1118;
        RETURN;
      END IF;
      IF LENGTH(TO_CHAR(L_SEQUENCE)) > L_RECPINMAILERDETAIL.LENGTH THEN
        outRetVal                   :=-1055; -- return error length exceeds
        RETURN;
      END IF;
      IF l_IsProductPanRange = '1' THEN
        SELECT TA.RANGE_ID
        INTO l_Range
        FROM TBLPANLOG TA,
          TBLPRODUCTPANRANGE TB
        WHERE TA.RANGE_ID = TB.RANGE_ID
        AND TB.PRODUCT_ID = inProduct_ID
        AND TA.PREFIX     =l_PAN
        AND TA.STATUS     = '0'
        AND TA.COUNTER    = l_Sequence;
      ELSE
        SELECT RANGE_ID
        INTO l_Range
        FROM TBLPANLOG
        WHERE PREFIX =l_PAN
        AND STATUS   = '0'
        AND COUNTER  = l_Sequence;
      END IF;
      SELECT high_range
      INTO l_HighRange
      FROM tblpanrange
      WHERE imd    = l_IMD
      AND RANGE_ID = l_Range;
      SELECT low_range
      INTO l_RangeMiss
      FROM tblpanrange
      WHERE imd        = l_IMD
      AND RANGE_ID     = l_Range;
      l_OrigSeq       := l_Sequence;
      IF ( l_RangeMiss = l_Sequence ) THEN -- I do this to missing the low range card number.
        l_Sequence    := l_Sequence- 1;
      ELSE
        l_Sequence := l_Sequence-1;
      END IF;
      --        -- check if COUNTER+1 = HIGH RANGE
      IF TO_NUMBER(l_OrigSeq+1) > TO_NUMBER(l_HighRange) THEN
        UPDATE TBLPANLOG SET STATUS = '2' WHERE RANGE_ID = l_Range AND PREFIX = l_PAN;
      ELSE
        UPDATE TBLPANLOG
        SET COUNTER  =l_OrigSeq+1
        WHERE PREFIX =l_PAN
        AND STATUS   = '0'
        AND RANGE_ID = l_Range;
      END IF;
      COMMIT;
      l_Sequence:=l_Sequence+1;
      --Padding with Zeros
      l_Field:=LPAD(TO_CHAR(l_Sequence),l_RecPinMailerDetail.Length,'0');
      -- Fahad - 28/11/2011 - Merged from ENBD
    ELSE
      --GENERATING Check Digit
      IF TRIM(UPPER(l_RecPinMailerDetail.FieldName))= 'MODULUS-10 CHECK DIGIT' THEN
        l_Field                                    :=UIPKGPRSRELATIONSHIP.fnGetCheckDigit(l_PAN);
      END IF;
    END IF;
  END IF;
  l_PAN:=l_PAN||l_Field;
END LOOP;
outPAN:=l_PAN;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    outPAN := SQLCODE||' '|| SQLERRM;
    ROLLBACK;
    outRetVal := -1;
  END;
END spGeneratePANforImport;
/* ####### Fariha:  Old SP
PROCEDURE spGeneratePANforImport(
inProduct_ID     IN VARCHAR2,
inCustomer_ID    IN VARCHAR2,
inAccount_Number IN VARCHAR2,
inCustomerStaff  IN VARCHAR2,
inBranchCode     IN VARCHAR2,
outPAN OUT VARCHAR2,
outRetVal OUT NUMBER )
IS
-------DATA DECLARATIONS---------------------------------------------------
l_IMD             VARCHAR2 ( 50 ) ;
l_BranchCode      VARCHAR2 ( 50 ) ;
l_ProductCode     VARCHAR2 ( 50 ) ;
l_ProductType     VARCHAR2 ( 50 ) ;
l_CustomerStaff   VARCHAR2 ( 50 ) ;
l_Modulus10       VARCHAR2 ( 50 ) ;
l_Constant        VARCHAR2 ( 50 ) ;
l_PAN             VARCHAR2 ( 50 ) ;
l_Field           VARCHAR2 ( 50 ) ;
l_FieldStartIndex NUMBER;
l_Sequence        NUMBER;
l_CustomerCount   NUMBER;
l_Range           VARCHAR2(20);
l_HighRange       VARCHAR2(20);
l_NextRange       VARCHAR2(20);
l_Count           NUMBER;
-------CURSOR DECLARATIONS-------------------------------------------------
-- Create the cursor type.
TYPE l_CursorType
IS
REF
CURSOR
RETURN tblCFGPanFormatDetail%ROWTYPE;
-- Declare a cursor variable of that type.
l_CurPinMailerDetail l_CursorType;
-- Declare a record with same structure as cursor variable.
l_RecPinMailerDetail tblCFGPanFormatDetail%ROWTYPE;
------------------------------------------------------------------------------
BEGIN
outRetval      := 0;
l_PAN          :='';
l_CustomerCount:=0;
---------RETRIEVING DATA--------------------------------------------------------
SELECT COUNT(*)
INTO l_CustomerCount
FROM TblCustomer
WHERE CustomerID=inCustomer_ID;
l_BranchCode     :=inBranchCode;
l_CustomerStaff  :=inCustomerStaff;
SELECT TBLCFGPRODUCTDETAIL.PRODUCTCODE,
IMD
INTO l_ProductCode,
l_IMD
FROM TBLCFGProduct,
TBLCFGPRODUCTDETAIL
WHERE TBLCFGProduct.PRODUCT_ID = TBLCFGPRODUCTDETAIL.PRODUCT_ID
AND TBLCFGProduct.Product_ID   = inProduct_ID;
---------------------------------------------------------------------------------
-- Open the cursor variable, associating with it a SQL statement.
OPEN l_CurPinMailerDetail FOR SELECT tblcfgpanformatdetail.* FROM tblcfgProductDetail,
tblcfgpanformat,
tblcfgpanformatdetail WHERE tblcfgProductDetail.PANFORMAT_ID = tblcfgpanformat.PANFORMATID AND tblcfgpanformat.PANFORMATID = tblcfgpanformatdetail.FKPANFORMATID AND tblcfgProductDetail.PRODUCT_ID=inProduct_ID Order by tblcfgpanformat.PANFORMATID,
to_number(StartIndex);
LOOP
-- Fetch from the cursor variable.
FETCH l_CurPinMailerDetail
INTO l_RecPinMailerDetail;
EXIT
WHEN l_CurPinMailerDetail %NOTFOUND;
--Loading Field Start Index variable
IF l_RecPinMailerDetail.FieldStartIndex              IS NULL THEN
l_FieldStartIndex                                  := 0;
ELSIF to_number(l_RecPinMailerDetail.FieldStartIndex) > 0 THEN
l_FieldStartIndex                                  := to_number(l_RecPinMailerDetail.FieldStartIndex);
ELSE
l_FieldStartIndex := 0;
END IF;
--REPLACING FIELDS
IF TRIM(UPPER(l_RecPinMailerDetail.FieldName))<> 'SEQUENCE' AND TRIM(UPPER(l_RecPinMailerDetail.FieldName))<> 'MODULUS-10 CHECK DIGIT' THEN
l_Field                                     :=
CASE TRIM(UPPER(l_RecPinMailerDetail.FieldName))
WHEN 'IMD' THEN
SUBSTR(l_IMD,l_FieldStartIndex, l_RecPinMailerDetail.Length) -- l_IMD
WHEN 'BRANCHCODE' THEN
SUBSTR(l_BranchCode,l_FieldStartIndex, l_RecPinMailerDetail.Length) --l_BranchCode
WHEN 'PRODUCT CODE' THEN
SUBSTR(l_ProductCode,l_FieldStartIndex, l_RecPinMailerDetail.Length) --l_ProductCode
WHEN 'CUSTOMER/STAFF' THEN
l_CustomerStaff
WHEN 'ACCOUNT NUMBER' THEN
SUBSTR(NVL(inAccount_Number,''),l_FieldStartIndex, l_RecPinMailerDetail.Length) --NVL(inAccount_Number,'')
WHEN 'CONSTANT' THEN
TRIM(UPPER(l_RecPinMailerDetail.VALUE))
END;
IF LENGTH(l_Field) <> l_RecPinMailerDetail.Length THEN
outRetVal        :=-1055;
RETURN;
END IF;
--GENERATING SEQUENCE
ELSE
IF TRIM(UPPER(l_RecPinMailerDetail.FieldName))= 'SEQUENCE' THEN
-- Get Active Range for PREFIX
-- SELECT NVL(MAX(Counter),0) INTO l_Sequence FROM TBLPANLOG WHERE PREFIX =l_PAN AND STATUS = '0';
INSERT
INTO TBLPANLOG
(
PREFIX,
COUNTER,
RANGE_ID,
STATUS
)
SELECT l_PAN,
LOW_RANGE,
RANGE_ID,
STATUS
FROM TBLPANRANGE
WHERE IMD         = l_IMD
AND RANGE_ID NOT IN
( SELECT RANGE_ID FROM TBLPANLOG WHERE PREFIX = l_PAN
);
COMMIT;
SELECT COUNT(*)
INTO l_Count
FROM TBLPANLOG
WHERE PREFIX =l_PAN
AND STATUS   = '0';
IF l_Count   > 0 THEN
SELECT MIN(Counter)
INTO l_Sequence
FROM TBLPANLOG
WHERE PREFIX =l_PAN
AND STATUS   = '0';
ELSE
l_Sequence := -1;
END IF;
IF LENGTH(TO_CHAR(l_Sequence)) > l_RecPinMailerDetail.Length THEN
outRetVal                   :=-1055;
RETURN;
END IF;
IF l_Sequence <> -1 THEN
SELECT RANGE_ID
INTO l_Range
FROM TBLPANLOG
WHERE PREFIX =l_PAN
AND STATUS   = '0'
AND counter IN
( SELECT MIN(counter) FROM TBLPANLOG WHERE PREFIX = l_PAN AND STATUS = '0'
);
SELECT high_range
INTO l_HighRange
FROM tblpanrange
WHERE imd    = l_IMD
AND RANGE_ID = l_Range;
-- check if COUNTER+1 = HIGH RANGE
IF TO_NUMBER(l_Sequence + 1) = TO_NUMBER(l_HighRange) THEN
UPDATE TBLPANLOG
SET COUNTER  =l_Sequence+1
WHERE PREFIX =l_PAN
AND STATUS   = '0'
AND RANGE_ID = l_Range;
-- mark complete in tblpanlog
UPDATE TBLPANLOG
SET STATUS     = '2'
WHERE RANGE_ID = l_Range
AND PREFIX     = l_PAN;
ELSE
UPDATE TBLPANLOG
SET COUNTER  =l_Sequence+1
WHERE PREFIX =l_PAN
AND STATUS   = '0'
AND RANGE_ID = l_Range;
END IF;
ELSE
outRetVal :=-1118;
RETURN;
END IF;
l_Sequence:=l_Sequence+1;
--Padding with Zeros
l_Field:=LPAD(TO_CHAR(l_Sequence),l_RecPinMailerDetail.Length,'0');
--GENERATING Check Digit
ELSE
IF TRIM(UPPER(l_RecPinMailerDetail.FieldName))= 'MODULUS-10 CHECK DIGIT' THEN
l_Field                                    :=uipkgprsrelationship.fnGetCheckDigit(l_PAN);
END IF;
END IF;
END IF;
l_PAN:=l_PAN||l_Field;
END LOOP;
outPAN:=l_PAN;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
BEGIN
outPAN := SQLCODE||' '|| SQLERRM;
ROLLBACK;
outRetVal := -1;
END;
END spGeneratePANforImport;
####### */
PROCEDURE spBL_CustomerAccountLinking(
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
  l_DefaultProductID VARCHAR(20);
BEGIN
  outRetVal := 0;
  SELECT TBLCFGPARAM.VALUE
  INTO l_DefaultProductID
  FROM TBLCFGPARAM
  WHERE TBLCFGPARAM.ENTITY = 'IMPORT'
  AND TBLCFGPARAM.NAME     = 'DEFAULT_PRODUCT';
  /*  OPEN outCurSor for
  SELECT  '' as "SELECTIONTYPE",
  ACCOUNT_REL."ACCOUNTMAP" as "ACCOUNTMAP",
  '9999' as "CHANNEL_ID",
  ACCOUNT_REL."CUSTOMER_ID"   as "RELATIONSHIP_ID",
  '1'  as  "IS_DEFAULT",
  ACCOUNT_REL."ACCOUNT_ID",
  ACCOUNT_REL."TYPE",
  ACCOUNT_REL."CURRENCY",
  ACCOUNT_REL."CUSTOMER_ID",
  '0' as "TRAN_PERM",
  '0' as "NATURE",
  ''  as "RELATIONSHIPAUTH_ID",
  l_DefaultProductID    as "PRODUCTID",
  ACCOUNT_REL."ACTIONFLAG",
  '' as "ERR_DESCRIPTION"
  from   tblimptmpaccount_rel ACCOUNT_REL;*/
  UPDATE tblimptmpaccount_rel
  SET "CHANNEL_ID"      = '9999',
    "IS_DEFAULT"        ='1',
    "TRAN_PERM"         = '0',
    "NATURE"            = '0',
    RELATIONSHIPAUTH_ID = '',
    "PRODUCTID"         = l_DefaultProductID,
    "ERR_DESCRIPTION"   = '';
  outRetVal            := SQL%ROWCOUNT;
END spBL_CustomerAccountLinking;
/*
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.    Fahad Ali     09-Feb-2010   to update directly in tblimptmpcustomer
2.    Fariha Akhtar 07-Jul-2013   Updated to add SP level logging
***************************************************************************
*/
PROCEDURE spBL_PrepareCustomerData(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID VARCHAR2(100);
  spName    VARCHAR2(100);
  spDesc    VARCHAR2(500);
BEGIN
  /*(
  outCursor OUT REF_CURSOR,
  outRetVal  OUT NUMBER
  )
  IS
  BEGIN
  outRetVal := 0;
  OPEN outCurSor for
  SELECT  CUSTOMER.CUSTOMERID       ,
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
  TO_char(SYSDATE,'yyyyMMDD') as LASTUPDATEDDATE ,
  TO_char(SYSDATE,'yyyyMMDD') as REGISTRATIONDATE ,
  CUSTOMER.BRANCH_CODE      ,
  CUSTOMER.PASSPORT_NO      ,
  CUSTOMER.OLDCUSTOMER_ID   ,
  '' as TRANSACTIONALERTS,
  '' as CHANNELALERTS,
  '' as TRANSACTIONINSURANCE,
  CUSTOMER.ACTIONFLAG,
  CUSTOMER.INTERNAL_BRANCH_ID,
  CUSTOMER.GENDER,
  CUSTOMER.FAXNUMBER,
  CUSTOMER.INSTITUTIONID,
  '' as "ERR_DESCRIPTION"
  from tblimptmpcustomer CUSTOMER;
  */
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spPopulateCustomer';
  spDesc    := 'SP to populate TBLIMPTMPCUSTOMER from TBLIMPLOGCUSTOMER';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  UPDATE tblimptmpcustomer
  SET LASTUPDATEDDATE    = TO_CHAR(SYSDATE,'yyyyMMDD'),
    REGISTRATIONDATE     = TO_CHAR(SYSDATE,'yyyyMMDD'),
    TRANSACTIONALERTS    = '',
    CHANNELALERTS        = '',
    TRANSACTIONINSURANCE = '' ;
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := 1;
    outMsg    := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_PrepareCustomerData;
/*
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.    Fahad Ali     09-Feb-2010   to update directly in tblimptmpaccount
***************************************************************************
*/
PROCEDURE spBL_PrepareAccountData(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID VARCHAR2(100);
  spName    VARCHAR2(100);
  spDesc    VARCHAR2(500);
BEGIN
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_PrepareAccountData';
  spDesc    := 'SP to update last update date in TBLIMPTMPACCOUNT';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  UPDATE tblimptmpaccount SET LAST_UPDATED = TO_CHAR(SYSDATE,'yyyyMMDD');
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := 1;
    outMsg    := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_PrepareAccountData;
/*
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.    Fahad Ali     09-Feb-2010   to update directly in tblimptmpcard
***************************************************************************
*/
PROCEDURE spBL_PrepareCardData(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID VARCHAR2(100);
  spName    VARCHAR2(100);
  spDesc    VARCHAR2(500);
BEGIN
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_PrepareCardData';
  spDesc    := 'SP to populate TBLIMPTMPCUSTOMER from TBLIMPLOGCUSTOMER';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  --fahad 18/08/2010 for pin regeneration request handling
  UPDATE tblimptmpcard
  SET
    (
      tblimptmpcard.relationship_id,
      tblimptmpcard.EXPIRYDATE
    )
    =
    (SELECT tbldebitcard.relationship_id,
      tbldebitcard.EXPIRYDATE
    FROM tbldebitcard
    WHERE tblimptmpcard.customerid = tbldebitcard.customerid
    AND tblimptmpcard.cardnumber   = tbldebitcard.cardnumber
    )
  WHERE tblimptmpcard.Actionflag = '15';
  UPDATE tblimptmpcard
  SET failed           ='1',
    err_code           ='0040',
    err_description    ='Card Not Exist. Pin Regeneration request rejected.'
  WHERE Actionflag     = '15'
  AND relationship_id IS NULL
  AND failed          IS NULL;
  --fahad 18/08/2010 for pin regeneration request handling
  UPDATE tblimptmpcard
  SET tblimptmpcard.ISSUPPLEMENTARYCARD =
    (SELECT TO_CHAR(tblcfgproduct.ISSUPPLEMENTRY)
    FROM tblcfgproduct
    WHERE tblcfgproduct.PRODUCT_ID = tblimptmpcard.PRODUCTID
    ),
    tblimptmpcard.EXPIRYDATE =
    (SELECT TO_CHAR(LAST_DAY(TO_DATE((TO_NUMBER(TO_CHAR(sysdate,'YYYY'))+TO_NUMBER(tblcfgproductdetail.VALIDYEARS))
      || TO_CHAR(sysdate,'MM')
      ||'01','yyyyMMdd')),'yyyyMMdd')
    FROM tblcfgproductdetail
    WHERE tblcfgproductdetail.PRODUCT_ID = tblimptmpcard.PRODUCTID
    ),
    tblimptmpcard.RELATIONSHIP_ID = tblimptmpcard.CARDNUMBER
    ||'='
    ||
    (SELECT TO_CHAR(TO_NUMBER(TO_CHAR(sysdate,'YY'))+TO_NUMBER(tblcfgproductdetail.VALIDYEARS))
      || TO_CHAR(sysdate,'MM')
    FROM tblcfgproductdetail
    WHERE tblcfgproductdetail.PRODUCT_ID = tblimptmpcard.PRODUCTID
    ) ;
  ---Fariha 19-11-2013  Applying logic to set appropriate EXISTINGCARDNUMBER and FIRSTCARDNUMBER in case of regenerated cards
  UPDATE tblimptmpcard
  SET existingcardnumber=
    (SELECT relationship_id
    FROM tbldebitcard
    WHERE cardnumber             =tblimptmpcard.oldpan
    AND tbldebitcard.expirydate IN
      (SELECT MAX(expirydate)
      FROM tbldebitcard
      WHERE cardnumber=tblimptmpcard.oldpan
      )
    )
  WHERE oldpan IS NOT NULL;
  UPDATE tblimptmpcard
  SET firstcardnumber =
    (SELECT NVL(firstcardnumber,relationship_id)
    FROM tbldebitcard
    WHERE relationship_id=tblimptmpcard.existingcardnumber
    AND rownum           ='1'
    );
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := -1;
    outMsg    := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_PrepareCardData;
/*
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.    Fahad Ali     05-Jul-2010   to validate existence of branch in system
2.    Waqas Ahmed   29-Nov-2011   placed additional checks
3.    Fariha Akhtar 30-Jul-2013   Commented old code, add new one and also added new parameters
***************************************************************************
*/
PROCEDURE spBL_CheckBranchExistance(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID VARCHAR2(100);
  spName    VARCHAR2(100);
  spDesc    VARCHAR2(500);
BEGIN
  outRetVal := 0;
  /*        Update tblimptmpcustomer
  set ERR_DESCRIPTION = 'Branch ['||branch_code||'] does not Exist.',
  Failed = '1'
  where failed is null
  and uipkgimportbl.fnIsBranchExist(branch_code,INSTITUTIONID) = 'false';*/
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_CheckBranchExistance';
  spDesc    := 'SP to check if account branch exists in DB';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  --Fariha: Applying business logic
  UPDATE tblimptmpaccount
  SET failed                                                = '1',
    err_code                                                ='449',
    err_description                                         = 'Account Branch does not exist.'
  WHERE failed                                             IS NULL
  AND uipkgimportbl.fnIsBranchExist(branchid,INSTITUTIONID) = 'false';
  UPDATE tblimptmpaccount_rel
  SET failed        = '1',
    err_code        ='449',
    err_description = 'Account Branch does not exist.'
  WHERE failed     IS NULL
  AND cnic         IN
    (SELECT cnic FROM tblimptmpaccount WHERE err_code = '449' AND failed = '1'
    );
  UPDATE tblimptmpcustomer
  SET failed        = '1',
    err_code        = '449',
    err_description = 'Account Branch does not exist.'
  WHERE failed     IS NULL
  AND cnic         IN
    (SELECT cnic FROM tblimptmpaccount WHERE err_code = '449' AND failed = '1'
    );
  UPDATE tblimptmpcard
  SET failed        = '1',
    err_code        = '449',
    err_description = 'Account Branch does not exist.'
  WHERE failed     IS NULL
  AND cnic         IN
    (SELECT cnic FROM tblimptmpaccount WHERE err_code = '449' AND failed = '1'
    );
  UPDATE tblimptmpaccount_rel
  SET failed        = '1',
    err_code        = '449',
    err_description = 'Branch does not exist.'
  WHERE failed     IS NULL
  AND cnic         IN
    (SELECT cnic FROM tblimptmpaccount WHERE err_code = '449' AND failed = '1'
    );
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
  /* Fariha: Commenting below logic as it can be done in simpler way above
  UPDATE tblimptmpaccount
  SET ERR_DESCRIPTION = 'Branch ['
  ||branchid
  ||'] does not Exist.',
  Failed                                                   = '1'
  WHERE failed                                              IS NULL
  AND (uipkgimportbl.fnIsBranchExist(branchid,INSTITUTIONID) = 'false'
  OR CUSTOMERID                                             IN
  (SELECT customerid
  FROM tblimptmpcustomer
  WHERE failed='1'
  AND ERR_DESCRIPTION LIKE 'Branch%'
  ));
  UPDATE tblimptmpcard
  SET ERR_DESCRIPTION = 'Branch does not Exist.',
  Failed            = '1'
  WHERE failed       IS NULL
  AND CUSTOMERID     IN
  (SELECT customerid
  FROM tblimptmpaccount
  WHERE failed='1'
  AND ERR_DESCRIPTION LIKE 'Branch%'
  );
  UPDATE tblimptmpcustomer
  SET ERR_DESCRIPTION = 'Branch ['
  ||branch_code
  ||'] does not Exist.',
  Failed        = '1'
  WHERE failed   IS NULL
  AND CUSTOMERID IN
  (SELECT customerid
  FROM tblimptmpaccount
  WHERE failed='1'
  AND ERR_DESCRIPTION LIKE 'Branch%'
  );
  UPDATE tblimptmpaccount_rel
  SET ERR_DESCRIPTION = 'Branch does not Exist.',
  Failed            = '1'
  WHERE failed       IS NULL
  AND CUSTOMER_ID    IN
  (SELECT customerid
  FROM tblimptmpaccount
  WHERE failed='1'
  AND ERR_DESCRIPTION LIKE 'Branch%'
  UNION ALL
  SELECT customerid
  FROM tblimptmpcustomer
  WHERE failed='1'
  AND ERR_DESCRIPTION LIKE 'Branch%'
  );
  UPDATE TBLIMPTMPCUSTOMERDETAIL
  SET ERR_DESCRIPTION = 'Branch does not Exist.',
  Failed            = '1'
  WHERE failed       IS NULL
  AND CUSTOMERID     IN
  (SELECT customerid
  FROM tblimptmpaccount
  WHERE failed='1'
  AND ERR_DESCRIPTION LIKE 'Branch%'
  UNION ALL
  SELECT customerid
  FROM tblimptmpcustomer
  WHERE failed='1'
  AND ERR_DESCRIPTION LIKE 'Branch%'
  );
  outRetVal := SQL%ROWCOUNT;*/
END spBL_CheckBranchExistance;
--Added By Waqas Ahmed - 21-June-2011
PROCEDURE spBL_CheckIMDExistance(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpcustomer
  SET ERR_DESCRIPTION = 'IMD ['
    ||imd
    ||'] does not Exist.',
    Failed                                          = '1'
  WHERE failed                                     IS NULL
  AND uipkgimportbl.fnIsIMDExist(imd,INSTITUTIONID) = 'false';
  UPDATE tblimptmpcard
  SET ERR_DESCRIPTION = 'IMD does not Exist.',
    Failed            = '1'
  WHERE failed       IS NULL
  AND CUSTOMERID     IN
    (SELECT customerid
    FROM tblimptmpcustomer
    WHERE failed='1'
    AND ERR_DESCRIPTION LIKE 'IMD%'
    );
  UPDATE tblimptmpaccount
  SET ERR_DESCRIPTION = 'IMD does not Exist.',
    Failed            = '1'
  WHERE failed       IS NULL
  AND CUSTOMERID     IN
    (SELECT customerid
    FROM tblimptmpcustomer
    WHERE failed='1'
    AND ERR_DESCRIPTION LIKE 'IMD%'
    );
  UPDATE tblimptmpaccount_rel
  SET ERR_DESCRIPTION = 'IMD does not Exist.',
    Failed            = '1'
  WHERE failed       IS NULL
  AND CUSTOMER_ID    IN
    (SELECT customerid
    FROM tblimptmpcustomer
    WHERE failed='1'
    AND ERR_DESCRIPTION LIKE 'IMD%'
    );
  UPDATE TBLIMPTMPCUSTOMERDETAIL
  SET ERR_DESCRIPTION = 'IMD does not Exist.',
    Failed            = '1'
  WHERE failed       IS NULL
  AND CUSTOMERID     IN
    (SELECT customerid
    FROM tblimptmpcustomer
    WHERE failed='1'
    AND ERR_DESCRIPTION LIKE 'IMD%'
    );
  outRetVal := SQL%ROWCOUNT;
END spBL_CheckIMDExistance;
PROCEDURE spBL_CheckCustomerExistance(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  --        Update tblimptmpaccount_rel ACCOUNT_REL
  --         set ACCOUNT_REL.ERR_DESCRIPTION = 'Customer ['||ACCOUNT_REL.customer_id||'] does not Exist.',
  --             ACCOUNT_REL.Failed = '1'
  --        Where ACCOUNT_REL.customer_id in
  --        (
  --              SELECT  ACCOUNT_REL."CUSTOMER_ID"
  --              from   tblimptmpaccount_rel ACCOUNT_REL
  --              Where ACCOUNT_REL.Failed is null
  --              AND ACCOUNT_REL.CHANNEL_ID <> '0000'
  --              Minus
  --              SELECT CUSTOMER.customerid
  --              FROM tblimptmpcustomer CUSTOMER
  --              Where CUSTOMER.Failed is null
  --              Minus
  --              SELECT CUSTOMERID
  --              FROM TBLCUSTOMER
  --        );
  --optimized query by tanveer
  UPDATE tblimptmpaccount_rel ACCOUNT_REL
  SET ACCOUNT_REL.ERR_DESCRIPTION = 'Customer ['
    ||ACCOUNT_REL.customer_id
    ||'] does not Exist.',
    ACCOUNT_REL.Failed = '1'
  WHERE rowid         IN
    (SELECT x.rowid
    FROM tblimptmpaccount_rel x ,
      (SELECT ACCOUNT_REL."CUSTOMER_ID"
      FROM tblimptmpaccount_rel ACCOUNT_REL
      WHERE ACCOUNT_REL.Failed   IS NULL
      AND ACCOUNT_REL.CHANNEL_ID <> '0000'
      MINUS
      SELECT CUSTOMER.customerid
      FROM tblimptmpcustomer CUSTOMER
      WHERE CUSTOMER.Failed IS NULL
      AND actionflag         = '01'
      MINUS
      SELECT CUSTOMERID FROM TBLCUSTOMER
      )y
    WHERE x.customer_id = y.CUSTOMER_ID
    );
  outRetVal := SQL%ROWCOUNT;
  UPDATE tblimptmpcustomer CUST
  SET CUST.ERR_DESCRIPTION = 'Customer ['
    ||cust.customerid
    ||'] does not Exist for Action Flag (02, 03).',
    CUST.Failed = '1'
  WHERE rowid  IN
    (SELECT x.rowid
    FROM tblimptmpcustomer x ,
      (SELECT customerid
      FROM tblimptmpcustomer
      WHERE Failed   IS NULL
      AND actionflag IN ('02','03')
      MINUS
      SELECT customerid FROM TBLCUSTOMER
      )y
    WHERE x.customerid = y.customerid
    ) ;
END spBL_CheckCustomerExistance;
PROCEDURE spBL_CheckAccountExistance(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID VARCHAR2(100);
  spName    VARCHAR2(100);
  spDesc    VARCHAR2(500);
BEGIN
  -- A.F. Have Done Some Optimizations in Query.
  -- outRetVal := 0;
  --         Update  tblimptmpaccount_rel ACCOUNT_REL
  --         Set ACCOUNT_REL.ERR_DESCRIPTION = 'Account ['||ACCOUNT_REL.ACCOUNT_ID||'] does not Exist.',
  --             ACCOUNT_REL.Failed = '1'
  --        WHERE (ACCOUNT_ID, TYPE, CURRENCY) in (
  --              Select Account_ID,TYPE,CURRENCY
  --                  From tblimptmpaccount_rel
  --                  Where Failed is null
  --                  AND ACCOUNT_REL.CHANNEL_ID <> '0000'
  --                  minus
  --              Select Account_ID,ACCOUNT_TYPE,ACCOUNT_CURRENCY
  --                  From tblimptmpaccount
  --                  Where Failed is null
  --                  minus
  --              Select TRIM(TBLACCOUNT.Account_ID),
  --                TBLACCOUNT.ACCOUNT_TYPE,
  --                TBLACCOUNT.ACCOUNT_CURRENCY
  --              FROM TBLACCOUNT );
  --optimized query by tanveer
  ----Fariha :  Updating temporary tables to the ones used in Default Account Marking and Account Linking/De-Linking
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_CheckAccountExistance';
  spDesc    := 'SP to check if accounts coming for linking/de-linking and default marking exist in system';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  UPDATE tblimptmpaccount_enhanced
  SET tblimptmpaccount_enhanced.ERR_DESCRIPTION = 'Account ['
    ||tblimptmpaccount_enhanced.ACCOUNT_ID
    ||'] does not exist for Action Flag (02, 03, 09).',
    tblimptmpaccount_enhanced.Failed = '1'
  WHERE rowid                       IN
    (SELECT tblimptmpaccount_enhanced.rowid
    FROM tblimptmpaccount_enhanced ,
      (SELECT Account_ID,
        ACCOUNT_TYPE,
        ACCOUNT_CURRENCY
      FROM tblimptmpaccount_enhanced
      WHERE Failed   IS NULL
      AND actionflag IN ('02','03')
      MINUS
      SELECT TRIM(TBLACCOUNT.Account_ID),
        TBLACCOUNT.ACCOUNT_TYPE,
        TBLACCOUNT.ACCOUNT_CURRENCY
      FROM TBLACCOUNT
      )y
    WHERE tblimptmpaccount_enhanced.account_id     = y.account_id
    AND tblimptmpaccount_enhanced.ACCOUNT_TYPE     = y.ACCOUNT_TYPE
    AND tblimptmpaccount_enhanced.ACCOUNT_CURRENCY = y.ACCOUNT_CURRENCY
    ) ;
  ---Fariha - not needed as we are checking TBLTMPACCOUNT first
  /* UPDATE tblimptmpaccount_rel
  SET tblimptmpaccount_rel.ERR_DESCRIPTION = 'Account ['
  ||tblimptmpaccount_rel.ACCOUNT_ID
  ||'] does not Exist.',
  tblimptmpaccount_rel.err_code = '150',
  tblimptmpaccount_rel.Failed   = '1'
  WHERE rowid           IN
  (SELECT tblimptmpaccount_rel.rowid
  FROM tblimptmpaccount_rel,
  (SELECT Account_ID,
  TYPE,
  CURRENCY
  FROM tblimptmpaccount_rel
  WHERE Failed   IS NULL
  AND CHANNEL_ID <> '0000'
  MINUS
  SELECT Account_ID,
  ACCOUNT_TYPE,
  ACCOUNT_CURRENCY
  FROM tblimptmpaccount
  WHERE Failed  IS NULL
  AND actionflag = '01'
  MINUS
  SELECT TRIM(TBLACCOUNT.Account_ID),
  TBLACCOUNT.ACCOUNT_TYPE,
  TBLACCOUNT.ACCOUNT_CURRENCY
  FROM TBLACCOUNT
  )y
  WHERE tblimptmpaccount_rel.account_id = y.account_id
  AND tblimptmpaccount_rel.TYPE         = y.TYPE
  AND tblimptmpaccount_rel.CURRENCY     = y.CURRENCY
  ) ;
  outRetVal := SQL%ROWCOUNT;*/
  UPDATE tblimptmpaccount_rel_enhanced
  SET tblimptmpaccount_rel_enhanced.ERR_DESCRIPTION = 'Account ['
    ||tblimptmpaccount_rel_enhanced.ACCOUNT_ID
    ||'] does not exist for Action Flag (02, 03, 09).',
    tblimptmpaccount_rel_enhanced.err_code        = '150',
    tblimptmpaccount_rel_enhanced.Failed          = '1'
  WHERE tblimptmpaccount_rel_enhanced.account_id IN
    ( SELECT DISTINCT account_id
    FROM tblimptmpaccount_enhanced
    WHERE err_code = '150'
    );
  UPDATE tblimptmpcard_enhanced
  SET tblimptmpcard_enhanced.ERR_DESCRIPTION = 'CardNumber ['
    ||tblimptmpcard_enhanced.cardnumber
    ||']:-  Account does not Exist.',
    tblimptmpcard_enhanced.err_code        = '150',
    tblimptmpcard_enhanced.Failed          = '1'
  WHERE tblimptmpcard_enhanced.cardnumber IN
    ( SELECT DISTINCT cardnumber
    FROM tblimptmpaccount_enhanced
    WHERE err_code = '150'
    );
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := -1;
    outMsg    := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_CheckAccountExistance;
PROCEDURE spBL_CheckCardExistance(
    outRetVal OUT NUMBER )
IS
  l_DefaultProductID VARCHAR(20);
BEGIN
  outRetVal := 0;
  --        Update  tblimptmpaccount_rel ACCOUNT_REL
  --         Set ACCOUNT_REL.ERR_DESCRIPTION = 'Card ['||ACCOUNT_REL.RELATIONSHIP_ID||'] does not Exist.',
  --             ACCOUNT_REL.Failed = '1'
  --        Where ACCOUNT_REL.relationship_id in
  --        (
  --          SELECT  ACCOUNT_REL."RELATIONSHIP_ID"
  --           from   tblimptmpaccount_rel ACCOUNT_REL
  --           Where ACCOUNT_REL.Failed is null
  --          Minus
  --           SELECT CARD.RELATIONSHIP_ID
  --           FROM tblimptmpcard CARD
  --           Where CARD.Failed is null
  --          Minus
  --           SELECT RELATIONSHIP_ID
  --           FROM TBLDEBITCARD
  --        )
  --        and ACCOUNT_REL.channel_id in
  --        (
  --          select channelid from tblcfgchannel
  --          where cardrequired = 'Y'
  --        );
  UPDATE tblimptmpaccount_rel ACCOUNT_REL
  SET ACCOUNT_REL.ERR_DESCRIPTION = 'Card ['
    ||ACCOUNT_REL.RELATIONSHIP_ID
    ||'] does not Exist.',
    ACCOUNT_REL.Failed = '1'
  WHERE EXISTS
    (SELECT *
    FROM
      (SELECT ACCOUNT_REL."RELATIONSHIP_ID"
      FROM tblimptmpaccount_rel ACCOUNT_REL
      WHERE ACCOUNT_REL.Failed IS NULL
      MINUS
      SELECT CARD.RELATIONSHIP_ID
      FROM tblimptmpcard CARD
      WHERE CARD.Failed IS NULL
      AND actionflag     = '01'
      MINUS
      SELECT RELATIONSHIP_ID FROM TBLDEBITCARD
      )y
    WHERE y.relationship_id = ACCOUNT_REL.relationship_id
    )
  AND ACCOUNT_REL.channel_id IN
    ( SELECT channelid FROM tblcfgchannel WHERE cardrequired = 'Y'
    ) ;
  outRetVal := SQL%ROWCOUNT;
  UPDATE tblimptmpCARD CARD
  SET CARD.ERR_DESCRIPTION = 'Card ['
    ||CARD.RELATIONSHIP_ID
    ||'] does not Exist for Action Flag (02, 03).',
    CARD.Failed = '1'
  WHERE rowid  IN
    (SELECT x.rowid
    FROM tblimptmpCARD x ,
      (SELECT relationship_id
      FROM tblimptmpCARD
      WHERE Failed   IS NULL
      AND actionflag IN ('02','03')
      MINUS
      SELECT relationship_id FROM TBLDEBITCARD
      )y
    WHERE x.relationship_id = y.relationship_id
    ) ;
END spBL_CheckCardExistance;
PROCEDURE spBLGetDefaultCTLAcct(
    inINSTITUTIONID IN VARCHAR2,
    outCursor OUT REF_CURSOR )
IS
  l_DefaultProductID VARCHAR(20);
BEGIN
  OPEN outCursor FOR SELECT TBLACCOUNT.* FROM TBLACCOUNT,
  TBLBRANCH WHERE TBLACCOUNT.BRANCHID = TBLBRANCH.BRANCH_ID AND TBLACCOUNT.INTERNAL_BRANCH_ID = TBLBRANCH.INTERNAL_BRANCH_ID AND TBLACCOUNT.ACCOUNT_ID = '0187616350202414114' AND NVL(TBLBRANCH.INSTITUTIONID, '') = inINSTITUTIONID ;
END spBLGetDefaultCTLAcct;
PROCEDURE spBL_MarkProductDefaultOnGDCI(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  /*
  UPDATE tblimptmpcustomerproducts A
  SET is_default_ongdc     = '0'
  WHERE A.CUSTOMER_ID NOT IN
  (SELECT C.CUSTOMERID FROM TBLCUSTOMERPRODUCTS C
  )
  OR A.CUSTOMER_ID IN
  (SELECT B.CUSTOMERID
  FROM TBLCUSTOMERPRODUCTS B
  WHERE (B.IS_DEFAULT_ONGDC = '1' )
  AND (((SELECT priority
  FROM tblcfgproductdetail
  WHERE tblcfgproductdetail.PRODUCT_ID = A.PRODUCTID) >
  (SELECT priority
  FROM tblcfgproductdetail
  WHERE tblcfgproductdetail.PRODUCT_ID = B.PRODUCTID
  ))
  AND B.IS_DEFAULT_ONGDC = '1')
  );
  UPDATE tblimptmpcustomerproducts A
  SET is_default_ongdc = '1'
  WHERE A.CUSTOMER_ID IN
  (SELECT B.CUSTOMERID
  FROM TBLCUSTOMERPRODUCTS B
  WHERE (B.IS_DEFAULT_ONGDC = '1' )
  AND (((SELECT priority
  FROM tblcfgproductdetail
  WHERE tblcfgproductdetail.PRODUCT_ID = A.PRODUCTID) <=
  (SELECT priority
  FROM tblcfgproductdetail
  WHERE tblcfgproductdetail.PRODUCT_ID = B.PRODUCTID
  ))
  AND B.IS_DEFAULT_ONGDC = '1'));
  */
  /*no need to set 0 since it's inseretd by default. update for 1 only. Also, it's done only in the case
  when previous entries don't exist for customer products*/
  UPDATE tblimptmpcustomerproducts A
  SET is_default_ongdc     = '1'
  WHERE A.CUSTOMER_ID NOT IN
    (SELECT C.CUSTOMERID FROM TBLCUSTOMERPRODUCTS C
    )
  AND (PRODUCTID, CUSTOMER_ID) IN
    (SELECT product_id,
      customer_id
    FROM
      (SELECT cp.customer_id,
        pd.product_id,
        NVL(pd.priority,0) prodpri,
        MAX(NVL(pd.priority,0)) over (partition BY customer_id) maxpriority
      FROM tblcfgproductdetail pd,
        tblimptmpcustomerproducts cp
      WHERE pd.product_id = cp.productid
      )
    WHERE customer_id = A.CUSTOMER_ID
    AND prodpri       = maxpriority
    );
  outRetVal := SQL%ROWCOUNT;
END spBL_MarkProductDefaultOnGDCI;
/*
***************************************************************************
Created By  : FahadAli
Dated       : 09-Feb-2010
Description : To add internal branch id in tblimptmpCustomer
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.    Fariha Akhtar   01-JUN-2013   Added SP level logging
***************************************************************************
*/
PROCEDURE spBL_AddCustomerInternalBranch(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID VARCHAR2(100);
  spName    VARCHAR2(100);
  spDesc    VARCHAR2(500);
BEGIN
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_AddCustomerInternalBranch';
  spDesc    := 'SP to update Internal Branch ID in TBLIMPTMPCUSTOMER';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  ---Fariha: Applying business logic
  UPDATE tblimptmpCustomer
  SET tblimptmpCustomer.INTERNAL_BRANCH_ID =
    (SELECT tblbranch.INTERNAL_BRANCH_ID
    FROM tblbranch
    WHERE tblbranch.INSTITUTIONID = tblimptmpCustomer.INSTITUTIONID
    AND tblbranch.branch_id       = tblimptmpCustomer.branch_code
    AND rownum                    <2
    )
  WHERE failed IS NULL;
  outRetVal    := SQL%ROWCOUNT;
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal:=-1;
    outMsg   := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_AddCustomerInternalBranch;
/*
***************************************************************************
Created By  : FahadAli
Dated       : 09-Feb-2010
Description : To add internal branch id in tblimptmpaccount
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
PROCEDURE spBL_AddAccountInternalBranch(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpaccount ACCT
  SET ACCT.INTERNAL_BRANCH_ID =
    (SELECT tb.INTERNAL_BRANCH_ID
    FROM tblbranch tb
    WHERE tb.INSTITUTIONID = ACCT.INSTITUTIONID
    AND tb.branch_id       = acct.branchid
    AND rownum             <2
    )
  WHERE failed IS NULL ;
  outRetVal    := SQL%ROWCOUNT;
END spBL_AddAccountInternalBranch;
PROCEDURE spGetInternalBranchId(
    inBranchId      IN VARCHAR2,
    inInstitutionID IN VARCHAR2,
    outInternalBranchId OUT VARCHAR2 )
AS
BEGIN
  SELECT INTERNAL_BRANCH_ID
  INTO outInternalBranchId
  FROM tblbranch
  WHERE branch_id   = inBranchId
  AND institutionid = inInstitutionID;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  outInternalBranchId := NULL;
END spGetInternalBranchId;
/************************************ DEBIT CARD LOGIC *********************************************/
PROCEDURE spCheckCardBasedProduct(
    inProductID IN VARCHAR2,
    outCardBasedProduct OUT VARCHAR2 )
AS
  l_ProductCount NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO l_ProductCount
  FROM TBLCFGPRODUCT
  WHERE TBLCFGPRODUCT.PRODUCTTYPE = 'Card Based'
  AND TBLCFGPRODUCT.PRODUCT_ID    = inProductID;
  IF (l_ProductCount              > 0) THEN
    outCardBasedProduct          := 'Y';
  ELSE
    outCardBasedProduct := 'N';
  END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  outCardBasedProduct := 'N';
END spCheckCardBasedProduct;
/***************************************************************************************************/
PROCEDURE spBL_GetDistinctProducts(
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
AS
BEGIN
  outRetVal := 0;
  OPEN outCurSor FOR SELECT A.PRODUCTID FROM
  (SELECT ACCOUNT_REL.PRODUCTID FROM tblimptmpaccount_rel ACCOUNT_REL
  )A GROUP BY A.PRODUCTID;
END spBL_GetDistinctProducts;
PROCEDURE spGetImportChannelsbyProduct(
    inProductID IN VARCHAR2,
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
AS
BEGIN
  outRetVal                                                                                    := 0;
  OPEN outCursor FOR SELECT * FROM TBLCFGPRODUCTCHANNELS WHERE TBLCFGPRODUCTCHANNELS.PRODUCT_ID = inProductID AND TBLCFGPRODUCTCHANNELS.CHANNEL_TO_IMPORT = '1';
END spGetImportChannelsbyProduct;
/*
***************************************************************************
Created By  :
Dated      :
Description :
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.   Fahad Ali     18-Feb-2010   MAXRETRIES and REMRETRIES added
2.   Salman Aziz     08 April-10   When 'PANONLY' case added
3. Amir Farooq     10-May-2010   Seperated the part of existing Relationships
4. Fariha          23-Jul-2012   Added SP level logging
***************************************************************************
*/
PROCEDURE spBL_GetRelationsForChannel(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
AS
  historyID       VARCHAR2(100);
  spName          VARCHAR2(100);
  Spdesc          VARCHAR2(500);
  l_ActivityLogID NUMBER;
BEGIN
  --outRetVal := 0;
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_GetRelationsForChannel';
  spDesc    := 'SP to populate TBLIMPTMPRELATIONS, TBLIMPTMPREL_AUTH, TBLIMPTMPACCOUNT_REL for all channels.';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  --Mark action flag to update(02) for soft recarding records
  UPDATE tblimptmpaccount_rel
  SET actionflag = '02'
  WHERE failed  IS NULL
  AND cnic      IN
    (SELECT cnic
    FROM tblimptmpcard
    WHERE failed         IS NULL
    AND regeneration_type = '12'
    );
  DELETE tblimptmprelations;
  -- Inserting relations into a temporary table without relationshipAuth_ID
  INSERT
  INTO tblimptmprelations
    (
      SELECTIONTYPE,
      ACCOUNTMAP,
      CHANNELID,
      RELATIONSHIP_ID,
      IS_DEFAULT,
      ACCOUNT_ID,
      TYPE,
      CURRENCY,
      CUSTOMER_ID,
      TRAN_PERM,
      NATURE,
      RELATIONSHIPAUTH_ID,
      PRODUCTID,
      PIN,
      STATUS,
      PINSHARINGCATEGORY,
      ACTIONFLAG,
      MAXRETRIES,
      REMRETRIES,
      INSTITUTIONID
    )
  SELECT A.SELECTIONTYPE,
    A.ACCOUNTMAP,
    D.CHANNEL_ID,
    CASE D.RELATIONSHIPTYPE
      WHEN 'CNIC'
      THEN C.CNIC
        -- BY SR - Feb 22 - 2011 - Merged from ENBD
        --When 'CARDNUMBER' then B.CARDNUMBER
        --When 'PANONLY' then substr(B.CARDNUMBER,0,instr(B.CARDNUMBER,'=') -1)
      WHEN 'CARDNUMBER=EXPIRY'
      THEN B.CARDNUMBER
      WHEN 'CARDNUMBER'
      THEN SUBSTR(B.CARDNUMBER,0,instr(B.CARDNUMBER,'=') -1)
    END AS RELATIONSHIP_ID,
    A.IS_DEFAULT,
    A.ACCOUNT_ID,
    A.TYPE,
    A.CURRENCY,
    A.CUSTOMER_ID,
    A.TRAN_PERM,
    A.NATURE,
    A.RELATIONSHIPAUTH_ID,
    A.PRODUCTID,
    A.PIN,
    NVL(A.STATUS,D.FIRSTSTATUS) AS STATUS,
    E.PINSHARINGCATEGORY,
    A.ACTIONFLAG,
    D.MAXRETRIES,
    D.MAXRETRIES,
    A.INSTITUTIONID
  FROM tblimptmpaccount_rel A
  LEFT OUTER JOIN
    (SELECT CARD.RELATIONSHIP_ID AS CARDNUMBER,
      CARD.CUSTOMERID,
      CARD.PRODUCTID
    FROM tblimptmpcard CARD
    WHERE failed IS NULL
    ) B
  ON A.CUSTOMER_ID = B.CUSTOMERID
  AND A.PRODUCTID  = B.PRODUCTID --fahad 13-08-2010
  LEFT OUTER JOIN
    (SELECT CUSTOMER.CNIC,
      CUSTOMER.CUSTOMERID
    FROM tblimptmpcustomer CUSTOMER
    WHERE failed IS NULL
    UNION
    SELECT TBLCUSTOMER.CNIC,
      TBLCUSTOMER.CUSTOMERID
    FROM TBLCUSTOMER
    WHERE customerid IN
      (SELECT DISTINCT ACCOUNT_REL.CUSTOMER_ID
      FROM tblimptmpaccount_rel ACCOUNT_REL
      )
    ) C
  ON B.CUSTOMERID = C.CUSTOMERID
  LEFT OUTER JOIN TBLCFGPRODUCTCHANNELS D
  ON A.PRODUCTID = D.PRODUCT_ID
  LEFT OUTER JOIN TBLCFGCHANNEL E
  ON D.CHANNEL_ID = E.CHANNELID
  WHERE A.failed IS NULL;
  /* INSERT
  INTO TBLIMPTMPRELATIONS_LOG
  (
  SELECTIONTYPE,
  ACCOUNTMAP,
  CHANNELID,
  RELATIONSHIP_ID,
  IS_DEFAULT,
  ACCOUNT_ID,
  TYPE,
  CURRENCY,
  CUSTOMER_ID,
  TRAN_PERM,
  NATURE,
  RELATIONSHIPAUTH_ID,
  PRODUCTID,
  PIN,
  STATUS,
  PINSHARINGCATEGORY,
  ACTIONFLAG,
  MAXRETRIES,
  REMRETRIES,
  INSTITUTIONID
  )
  SELECT SELECTIONTYPE,
  ACCOUNTMAP,
  CHANNELID,
  RELATIONSHIP_ID,
  IS_DEFAULT,
  ACCOUNT_ID,
  TYPE,
  CURRENCY,
  CUSTOMER_ID,
  TRAN_PERM,
  NATURE,
  RELATIONSHIPAUTH_ID,
  PRODUCTID,
  PIN,
  STATUS,
  PINSHARINGCATEGORY,
  ACTIONFLAG,
  MAXRETRIES,
  REMRETRIES,
  INSTITUTIONID
  FROM TBLIMPTMPRELATIONS;*/
  --Generating New relationshipauths or getting it from TBLCUSTCHANNELACCT
  DELETE tblimptmprel_auth; --added as it has to be empty before inseting
  -- BY SR - Feb 22 - 2011 - Merged from ENBD
  COMMIT;
  INSERT
  INTO tblimptmprel_auth
    (
      RELATIONSHIP_ID,
      STATUS,
      PINSHARINGCATEGORY,
      MAXRETRIES,
      REMRETRIES,
      PIN, --added by tanveer as the pin was coming in the import file
      RELATIONSHIPAUTH_ID
    )
  SELECT A.*,
    NVL(B.RELATIONSHIPAUTH_ID,RELATIONSHIP_AUTH_ID.NEXTVAL) AS RELATIONSHIPAUTH_ID
  FROM
    (SELECT RELATIONS.RELATIONSHIP_ID,
      NVL(B.cardstatus, RELATIONS.STATUS),
      RELATIONS.PINSHARINGCATEGORY,
      RELATIONS.MAXRETRIES,
      RELATIONS.REMRETRIES,
      RELATIONS.PIN
    FROM TBLIMPTMPRELATIONS RELATIONS
    LEFT OUTER JOIN
      (SELECT CARD.RELATIONSHIP_ID,
        CARD.cardstatus
      FROM tblimptmpcard CARD
      WHERE failed IS NULL
      ) B
    ON RELATIONS.RELATIONSHIP_ID     = B.RELATIONSHIP_ID
    WHERE RELATIONS.RELATIONSHIP_ID IS NOT NULL --added by Fahad 20/03/2010 suppressing if relationship is null
    GROUP BY RELATIONS.CUSTOMER_ID,
      RELATIONS.PINSHARINGCATEGORY,
      RELATIONS.RELATIONSHIP_ID,
      RELATIONS.STATUS,
      B.cardstatus,
      MAXRETRIES,
      REMRETRIES,
      RELATIONS.PIN
    ) A
  LEFT OUTER JOIN TBLCUSTCHANNELACCT B
  ON A.Relationship_ID     = B.Relationship_ID ---FARIHA:  swapped sides of this clause to avoid returning multiple rows
  AND A.PINSHARINGCATEGORY =
    (SELECT pinsharingcategory FROM tblcfgchannel WHERE channelid = B.channel_id
    ); --NAZIM: To avoid returning multiple rows for ADC channels
  --Mark old pan warm in case of soft recarding
  INSERT
  INTO tblimptmprel_auth
    (
      RELATIONSHIP_ID,
      STATUS,
      ACTIONFLAG,
      PINSHARINGCATEGORY,
      MAXRETRIES,
      REMRETRIES,
      PIN,
      RELATIONSHIPAUTH_ID
    )
  /*
  select tmp.relationship_id,tmp.STATUS,tmp.ACTIONFLAG,tmp.PINSHARINGCATEGORY,
  tmp.MAXRETRIES,tmp.REMRETRIES,tmp.PIN,tmp.relationshipauth_id from
  (
  */
  SELECT cca.relationship_id,
    '01' AS STATUS,
    '02' AS ACTIONFLAG, --for update
    NULL AS PINSHARINGCATEGORY,
    NULL AS MAXRETRIES,
    NULL AS REMRETRIES,
    NULL AS PIN,
    cca.relationshipauth_id
  FROM tblimptmpcard card
  INNER JOIN tblcustchannelacct cca
  ON card.oldpan               = SUBSTR(cca.relationship_id, 1, 16)
  AND cca.channel_id           = '0001'
  WHERE card.regeneration_type = '12'
  AND cca.is_default           = '1'
  AND card.failed             IS NULL;
  /*
  Order By Cca.Relationshipauth_Id Desc
  ) tmp /*where rownum=1;
  */
  /*Added by Adil*/
  INSERT
  INTO TBLACTIVITYLOGS
    (
      ACTIVITYLOGID,
      REL_ID,
      ACTIVITIYCODE,
      ACTIVITYDATETIME,
      ALERTSENT,
      AGENTID,
      CHANNELID,
      STATUS,
      old_status,
      db_date_time
    )
    (SELECT SEQ_ACTIVITYLOG.nextval,
        cca.relationship_id,
        '05',
        Sysdate,
        NULL,
        'SOFT_RECARDING',
        '0001',
        '01',
        ra.status,
        Sysdate
      FROM tblimptmpcard card
      INNER JOIN tblcustchannelacct cca
      ON card.oldpan     = SUBSTR(cca.relationship_id, 1, 16)
      AND cca.channel_id = '0001'
      INNER JOIN tblrelationshipauth ra
      ON ra.relationshipauth_id    = cca.relationshipauth_id
      WHERE Card.Regeneration_Type = '12'
      AND cca.is_default           = '1'
      AND card.failed             IS NULL
    );
  COMMIT;
  /*INSERT
  INTO TBLIMPTMPREL_AUTH_LOG
  (
  RELATIONSHIP_ID,
  STATUS,
  PINSHARINGCATEGORY,
  MAXRETRIES,
  REMRETRIES,
  PIN,
  RELATIONSHIPAUTH_ID
  )
  SELECT RELATIONSHIP_ID,
  STATUS,
  PINSHARINGCATEGORY,
  MAXRETRIES,
  REMRETRIES,
  PIN,
  RELATIONSHIPAUTH_ID
  FROM TBLIMPTMPREL_AUTH;
  COMMIT;*/
  -- Putting Complete Relations for each channels into TBLIMPTMPACCOUNT_REL table
  INSERT
  INTO tblimptmpaccount_rel
    (
      SELECTIONTYPE ,
      ACCOUNTMAP ,
      ACCOUNT_ID ,
      TYPE ,
      CUSTOMER_ID ,
      NATURE ,
      PRODUCTID ,
      TRAN_PERM ,
      CURRENCY ,
      IS_DEFAULT ,
      RELATIONSHIP_ID ,
      PINSHARINGCATEGORY ,
      CHANNEL_ID ,
      PIN ,
      REASON ,
      ACTIONFLAG ,
      RELATIONSHIPAUTH_ID,
      STATUS ,
      INSTITUTIONID
    )
  SELECT DISTINCT TBLIMPTMPRELATIONS.SELECTIONTYPE ,
    TBLIMPTMPRELATIONS.ACCOUNTMAP ,
    TBLIMPTMPRELATIONS.ACCOUNT_ID ,
    TBLIMPTMPRELATIONS.TYPE ,
    TBLIMPTMPRELATIONS.CUSTOMER_ID ,
    TBLIMPTMPRELATIONS.NATURE ,
    TBLIMPTMPRELATIONS.PRODUCTID ,
    TBLIMPTMPRELATIONS.TRAN_PERM ,
    TBLIMPTMPRELATIONS.CURRENCY ,
    TBLIMPTMPRELATIONS.IS_DEFAULT ,
    TBLIMPTMPRELATIONS.RELATIONSHIP_ID ,
    TBLIMPTMPRELATIONS.PINSHARINGCATEGORY ,
    TBLIMPTMPRELATIONS.CHANNELID ,
    TBLIMPTMPRELATIONS.PIN ,
    TBLIMPTMPRELATIONS.REASON ,
    TBLIMPTMPRELATIONS.ACTIONFLAG ,
    TBLIMPTMPREL_AUTH.RELATIONSHIPAUTH_ID ,
    TBLIMPTMPREL_AUTH.STATUS ,
    TBLIMPTMPRELATIONS.INSTITUTIONID
  FROM TBLIMPTMPREL_AUTH,
    TBLIMPTMPRELATIONS
  WHERE TBLIMPTMPREL_AUTH.PINSHARINGCATEGORY = TBLIMPTMPRELATIONS.PINSHARINGCATEGORY
  AND TBLIMPTMPREL_AUTH.RELATIONSHIP_ID      = TBLIMPTMPRELATIONS.RELATIONSHIP_ID;
  COMMIT;
  outRetVal := SQL%ROWCOUNT;
  --NAZIM: Assigning -1 as productID for 9999 channel to new customer OR existing productID for 9999 channel to existing customer
  UPDATE tblimptmpaccount_rel
  SET productid = NVL(
    (SELECT productid
    FROM tblcustchannelacct
    WHERE tblcustchannelacct.customer_id = tblimptmpaccount_rel.customer_id
    AND tblcustchannelacct.channel_id    = '9999'
    AND rownum                           ='1'
    ), '-1')
  WHERE channel_id = '9999';
  COMMIT;
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := 1;
    outMsg    := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_GetRelationsForChannel;
/*
***************************************************************************
Created By  : Tanveer Ali
Dated      : 30 sep 2010
Description : The previous function links channels based on customer, while this links on the card
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
PROCEDURE spBL_GetRelForChannel_ByCard(
    outRetVal OUT NUMBER )
AS
BEGIN
  outRetVal := 0;
  DELETE tblimptmprelations;
  -- Inserting relations into a temporary table without relationshipAuth_ID
  INSERT
  INTO tblimptmprelations
    (
      SELECTIONTYPE,
      ACCOUNTMAP,
      CHANNELID,
      RELATIONSHIP_ID,
      IS_DEFAULT,
      ACCOUNT_ID,
      TYPE,
      CURRENCY,
      CUSTOMER_ID,
      TRAN_PERM,
      NATURE,
      RELATIONSHIPAUTH_ID,
      PRODUCTID,
      PIN,
      STATUS,
      PINSHARINGCATEGORY,
      ACTIONFLAG,
      MAXRETRIES,
      REMRETRIES,
      INSTITUTIONID
    )
  SELECT A.SELECTIONTYPE,
    A.ACCOUNTMAP,
    D.CHANNEL_ID,
    CASE D.RELATIONSHIPTYPE
        --                    When 'CNIC' then C.CNIC
      WHEN 'CARDNUMBER'
      THEN B.CARDNUMBER
      WHEN 'PANONLY'
      THEN SUBSTR(B.CARDNUMBER,0,instr(B.CARDNUMBER,'=') -1)
    END AS RELATIONSHIP_ID,
    A.IS_DEFAULT,
    A.ACCOUNT_ID,
    A.TYPE,
    A.CURRENCY,
    A.CUSTOMER_ID,
    A.TRAN_PERM,
    A.NATURE,
    A.RELATIONSHIPAUTH_ID,
    A.PRODUCTID,
    A.PIN,
    NVL(A.STATUS,D.FIRSTSTATUS) AS STATUS,
    E.PINSHARINGCATEGORY,
    A.ACTIONFLAG,
    D.MAXRETRIES,
    D.MAXRETRIES,
    A.INSTITUTIONID
  FROM tblimptmpaccount_rel A
  LEFT OUTER JOIN
    (SELECT CARD.RELATIONSHIP_ID AS CARDNUMBER,
      CARD.CUSTOMERID
    FROM tblimptmpcard CARD
    WHERE failed IS NULL
    ) B
  ON (A.card_number
    || '='
    || SUBSTR( A.expiry_date,3,4 )) = B.CARDNUMBER
    --          LEFT OUTER JOIN
    --              (
    --                    Select CUSTOMER.CNIC,
    --                           CUSTOMER.CUSTOMERID
    --                      From  tblimptmpcustomer CUSTOMER
    --                    where failed is null
    --                    UNION
    --
    --                    Select TBLCUSTOMER.CNIC,
    --                           TBLCUSTOMER.CUSTOMERID
    --                    FROM TBLCUSTOMER
    --                    where customerid in (Select distinct ACCOUNT_REL.CUSTOMER_ID
    --                                          From  tblimptmpaccount_rel ACCOUNT_REL
    --                                        )
    --              ) C
    --          ON  B.CUSTOMERID = C.CUSTOMERID
  LEFT OUTER JOIN TBLCFGPRODUCTCHANNELS D
  ON A.PRODUCTID = D.PRODUCT_ID
  LEFT OUTER JOIN TBLCFGCHANNEL E
  ON D.CHANNEL_ID = E.CHANNELID
  WHERE A.failed IS NULL;
  --Generating New relationshipauths or getting it from TBLCUSTCHANNELACCT
  DELETE tblimptmprel_auth; --added as it has to be empty before inseting
  INSERT
  INTO tblimptmprel_auth
    (
      RELATIONSHIP_ID,
      STATUS,
      PINSHARINGCATEGORY,
      MAXRETRIES,
      REMRETRIES,
      PIN, --added by tanveer as the pin was coming in the import file
      RELATIONSHIPAUTH_ID
    )
  SELECT A.*,
    NVL(B.RELATIONSHIPAUTH_ID,RELATIONSHIP_AUTH_ID.NEXTVAL) AS RELATIONSHIPAUTH_ID
  FROM
    (SELECT RELATIONS.RELATIONSHIP_ID,
      RELATIONS.STATUS,
      RELATIONS.PINSHARINGCATEGORY,
      RELATIONS.MAXRETRIES,
      RELATIONS.REMRETRIES,
      RELATIONS.PIN
    FROM tblimptmprelations RELATIONS
    WHERE RELATIONSHIP_ID IS NOT NULL --added by Fahad 20/03/2010 suppressing if relationship is null
    GROUP BY RELATIONS.CUSTOMER_ID,
      RELATIONS.PINSHARINGCATEGORY,
      RELATIONSHIP_ID,
      RELATIONS.STATUS,
      MAXRETRIES,
      REMRETRIES,
      RELATIONS.PIN
    ) A
  LEFT OUTER JOIN TBLCUSTCHANNELACCT B
  ON A.Relationship_ID = B.Relationship_ID;
  -- Putting Complete Relations for each channels into TBLIMPTMPACCOUNT_REL table
  INSERT
  INTO tblimptmpaccount_rel
    (
      SELECTIONTYPE ,
      ACCOUNTMAP ,
      ACCOUNT_ID ,
      TYPE ,
      CUSTOMER_ID ,
      NATURE ,
      PRODUCTID ,
      TRAN_PERM ,
      CURRENCY ,
      IS_DEFAULT ,
      RELATIONSHIP_ID ,
      PINSHARINGCATEGORY ,
      CHANNEL_ID ,
      PIN ,
      REASON ,
      ACTIONFLAG ,
      RELATIONSHIPAUTH_ID,
      STATUS ,
      INSTITUTIONID
    )
  SELECT DISTINCT TBLIMPTMPRELATIONS.SELECTIONTYPE ,
    TBLIMPTMPRELATIONS.ACCOUNTMAP ,
    TBLIMPTMPRELATIONS.ACCOUNT_ID ,
    TBLIMPTMPRELATIONS.TYPE ,
    TBLIMPTMPRELATIONS.CUSTOMER_ID ,
    TBLIMPTMPRELATIONS.NATURE ,
    TBLIMPTMPRELATIONS.PRODUCTID ,
    TBLIMPTMPRELATIONS.TRAN_PERM ,
    TBLIMPTMPRELATIONS.CURRENCY ,
    TBLIMPTMPRELATIONS.IS_DEFAULT ,
    TBLIMPTMPRELATIONS.RELATIONSHIP_ID ,
    TBLIMPTMPRELATIONS.PINSHARINGCATEGORY ,
    TBLIMPTMPRELATIONS.CHANNELID ,
    TBLIMPTMPRELATIONS.PIN ,
    TBLIMPTMPRELATIONS.REASON ,
    TBLIMPTMPRELATIONS.ACTIONFLAG ,
    TBLIMPTMPREL_AUTH.RELATIONSHIPAUTH_ID ,
    TBLIMPTMPREL_AUTH.STATUS ,
    TBLIMPTMPRELATIONS.INSTITUTIONID
  FROM TBLIMPTMPREL_AUTH,
    TBLIMPTMPRELATIONS
  WHERE TBLIMPTMPREL_AUTH.PINSHARINGCATEGORY = TBLIMPTMPRELATIONS.PINSHARINGCATEGORY
  AND TBLIMPTMPREL_AUTH.RELATIONSHIP_ID      = TBLIMPTMPRELATIONS.RELATIONSHIP_ID;
  outRetVal                                 := SQL%ROWCOUNT;
END spBL_GetRelForChannel_ByCard;
PROCEDURE spBL_GetExistRelForChannel(
    outRetVal OUT NUMBER )
AS
BEGIN
  outRetVal := 0;
  DELETE tblimptmprelations;
  -- Inserting relations into a temporary table without relationshipAuth_ID
  INSERT
  INTO tblimptmprelations
    (
      SELECTIONTYPE,
      ACCOUNTMAP,
      CHANNELID,
      RELATIONSHIP_ID,
      IS_DEFAULT,
      ACCOUNT_ID,
      TYPE,
      CURRENCY,
      CUSTOMER_ID,
      TRAN_PERM,
      NATURE,
      RELATIONSHIPAUTH_ID,
      PRODUCTID,
      PIN,
      STATUS,
      PINSHARINGCATEGORY,
      ACTIONFLAG,
      MAXRETRIES,
      REMRETRIES,
      INSTITUTIONID
    )
  SELECT A.SELECTIONTYPE,
    A.ACCOUNTMAP,
    D.CHANNEL_ID,
    CASE D.RELATIONSHIPTYPE
      WHEN 'CNIC'
      THEN C.CNIC
      WHEN 'CARDNUMBER'
      THEN B.CARDNUMBER
      WHEN 'PANONLY'
      THEN SUBSTR(B.CARDNUMBER,0,instr(B.CARDNUMBER,'=') -1)
    END AS RELATIONSHIP_ID,
    A.IS_DEFAULT,
    A.ACCOUNT_ID,
    A.TYPE,
    A.CURRENCY,
    A.CUSTOMER_ID,
    A.TRAN_PERM,
    A.NATURE,
    NULL,
    B.GROUP_ID, --xisting cards Product ID
    A.PIN,
    NVL(A.STATUS,D.FIRSTSTATUS) AS STATUS,
    E.PINSHARINGCATEGORY,
    A.ACTIONFLAG,
    D.MAXRETRIES,
    D.MAXRETRIES,
    A.INSTITUTIONID
  FROM tblimptmpaccount_rel A,
    ( SELECT DISTINCT relationship_ID AS CARDNUMBER,
      customerID                      AS CUSTOMERID,
      group_id
    FROM TBLDEBITCARD
    WHERE customerid IN
      (SELECT DISTINCT ACCOUNT_REL.CUSTOMER_ID
      FROM tblimptmpaccount_rel ACCOUNT_REL
      WHERE failed IS NULL
      )
    ) B,
    (SELECT CUSTOMER.CNIC,
      CUSTOMER.CUSTOMERID
    FROM tblimptmpcustomer CUSTOMER
    WHERE failed IS NULL
    UNION
    SELECT TBLCUSTOMER.CNIC,
      TBLCUSTOMER.CUSTOMERID
    FROM TBLCUSTOMER
    WHERE customerid IN
      (SELECT DISTINCT ACCOUNT_REL.CUSTOMER_ID
      FROM tblimptmpaccount_rel ACCOUNT_REL
      )
    ) C,
    TBLCFGPRODUCTCHANNELS D,
    TBLCFGCHANNEL E
  WHERE A.PRODUCTID = D.PRODUCT_ID
  AND A.CUSTOMER_ID = B.CUSTOMERID
  AND B.CUSTOMERID  = C.CUSTOMERID
  AND D.CHANNEL_ID  = E.CHANNELID
  AND A.failed     IS NULL;
  --Generating New relationshipauths or getting it from TBLCUSTCHANNELACCT
  DELETE tblimptmprel_auth;
  INSERT
  INTO tblimptmprel_auth
    (
      RELATIONSHIP_ID,
      STATUS,
      PINSHARINGCATEGORY,
      MAXRETRIES,
      REMRETRIES,
      RELATIONSHIPAUTH_ID
    )
  SELECT A.*,
    NVL(B.RELATIONSHIPAUTH_ID,RELATIONSHIP_AUTH_ID.NEXTVAL) AS RELATIONSHIPAUTH_ID
  FROM
    (SELECT RELATIONS.RELATIONSHIP_ID,
      RELATIONS.STATUS,
      RELATIONS.PINSHARINGCATEGORY,
      RELATIONS.MAXRETRIES,
      RELATIONS.REMRETRIES
    FROM tblimptmprelations RELATIONS
    WHERE RELATIONSHIP_ID IS NOT NULL --added by Fahad 20/03/2010 suppressing if relationship is null
    GROUP BY RELATIONS.CUSTOMER_ID,
      RELATIONS.PINSHARINGCATEGORY,
      RELATIONSHIP_ID,
      RELATIONS.STATUS,
      MAXRETRIES,
      REMRETRIES
    ) A
  LEFT OUTER JOIN TBLCUSTCHANNELACCT B
  ON A.Relationship_ID = B.Relationship_ID;
  -- Putting Complete Relations for each channels into TBLIMPTMPACCOUNT_REL table
  INSERT
  INTO tblimptmpaccount_rel
    (
      SELECTIONTYPE ,
      ACCOUNTMAP ,
      ACCOUNT_ID ,
      TYPE ,
      CUSTOMER_ID ,
      NATURE ,
      PRODUCTID ,
      TRAN_PERM ,
      CURRENCY ,
      IS_DEFAULT ,
      RELATIONSHIP_ID ,
      PINSHARINGCATEGORY ,
      CHANNEL_ID ,
      PIN ,
      REASON ,
      ACTIONFLAG ,
      RELATIONSHIPAUTH_ID,
      STATUS ,
      INSTITUTIONID
    )
  SELECT DISTINCT TBLIMPTMPRELATIONS.SELECTIONTYPE ,
    TBLIMPTMPRELATIONS.ACCOUNTMAP ,
    TBLIMPTMPRELATIONS.ACCOUNT_ID ,
    TBLIMPTMPRELATIONS.TYPE ,
    TBLIMPTMPRELATIONS.CUSTOMER_ID ,
    TBLIMPTMPRELATIONS.NATURE ,
    TBLIMPTMPRELATIONS.PRODUCTID ,
    TBLIMPTMPRELATIONS.TRAN_PERM ,
    TBLIMPTMPRELATIONS.CURRENCY ,
    TBLIMPTMPRELATIONS.IS_DEFAULT ,
    TBLIMPTMPRELATIONS.RELATIONSHIP_ID ,
    TBLIMPTMPRELATIONS.PINSHARINGCATEGORY ,
    TBLIMPTMPRELATIONS.CHANNELID ,
    TBLIMPTMPRELATIONS.PIN ,
    TBLIMPTMPRELATIONS.REASON ,
    TBLIMPTMPRELATIONS.ACTIONFLAG ,
    TBLIMPTMPREL_AUTH.RELATIONSHIPAUTH_ID ,
    TBLIMPTMPREL_AUTH.STATUS ,
    TBLIMPTMPRELATIONS.INSTITUTIONID
  FROM TBLIMPTMPREL_AUTH,
    TBLIMPTMPRELATIONS
  WHERE TBLIMPTMPREL_AUTH.PINSHARINGCATEGORY = TBLIMPTMPRELATIONS.PINSHARINGCATEGORY
  AND TBLIMPTMPREL_AUTH.RELATIONSHIP_ID      = TBLIMPTMPRELATIONS.RELATIONSHIP_ID;
  outRetVal                                 := SQL%ROWCOUNT;
END spBL_GetExistRelForChannel;
PROCEDURE spTranListByProdChanCurr(
    inPRODUCTID     IN VARCHAR2,
    inChannelID     IN VARCHAR2,
    inAcctCurrency  IN VARCHAR2,
    inInstitutionID IN VARCHAR2,
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
  lIsForeignCurrency VARCHAR(10);
  lBaseCurrency      VARCHAR(10);
BEGIN
  outRetval := 0;
  SELECT TBLCFGCURRENCY.CODE
  INTO lBaseCurrency
  FROM TBLCFGCURRENCY
  WHERE TBLCFGCURRENCY.IS_BASE_CURR = '1'
  AND TBLCFGCURRENCY.INSTITUTIONID  =inInstitutionID;
  --IF Channel supports foreign currency transactions then all transactions will be displayed
  SELECT tblCfgChannel.FOREIGNCURRENCY
  INTO lIsForeignCurrency
  FROM tblCfgChannel
  WHERE tblCfgChannel.CHANNELID = inChannelID;
  IF lIsForeignCurrency         ='Y' THEN
    BEGIN
      IF inAcctCurrency = lBaseCurrency THEN
        BEGIN
          OPEN outCursor FOR SELECT * FROM tblCfgTransactionCodes WHERE tblCfgTransactionCodes.TRAN_TYPE IN (1,3) AND tblCfgTransactionCodes.TRAN_CODE IN
          (SELECT TBLCFGPRODUCTCHANNELTRAN.TRAN_CODE
          FROM TBLCFGPRODUCTCHANNELTRAN
          WHERE TBLCFGPRODUCTCHANNELTRAN.PRODUCT_ID=inPRODUCTID
          AND TBLCFGPRODUCTCHANNELTRAN.CHANNEL_ID  =inChannelID
          );
        END;
      ELSE
        BEGIN
          OPEN outCursor FOR SELECT * FROM tblCfgTransactionCodes WHERE tblCfgTransactionCodes.TRAN_TYPE IN (1,3) AND tblCfgTransactionCodes.TRAN_CODE IN
          (SELECT TBLCFGPRODUCTCHANNELTRAN.TRAN_CODE
          FROM TBLCFGPRODUCTCHANNELTRAN
          WHERE TBLCFGPRODUCTCHANNELTRAN.PRODUCT_ID    =inPRODUCTID
          AND TBLCFGPRODUCTCHANNELTRAN.CHANNEL_ID      =inChannelID
          ) AND tblCfgTransactionCodes.FOREIGNCURRENCY = 'Y';
        END;
      END IF;
    END;
  ELSE
    BEGIN
      OPEN outCursor FOR SELECT * FROM tblCfgTransactionCodes WHERE tblCfgTransactionCodes.TRAN_TYPE IN (1,3) AND tblCfgTransactionCodes.TRAN_CODE IN
      (SELECT TBLCFGPRODUCTCHANNELTRAN.TRAN_CODE
      FROM TBLCFGPRODUCTCHANNELTRAN
      WHERE TBLCFGPRODUCTCHANNELTRAN.PRODUCT_ID    =inPRODUCTID
      AND TBLCFGPRODUCTCHANNELTRAN.CHANNEL_ID      =inChannelID
      ) AND tblCfgTransactionCodes.FOREIGNCURRENCY ='N';
    END;
  END IF;
END spTranListByProdChanCurr;
PROCEDURE spGetBaseCurrecny(
    inInstitutionID IN VARCHAR2,
    outBaseCurrecncy OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  SELECT TBLCFGCURRENCY.CODE
  INTO outBaseCurrecncy
  FROM TBLCFGCURRENCY
  WHERE (TBLCFGCURRENCY.INSTITUTIONID = inInstitutionID
  OR inInstitutionID                 IS NULL)
  AND TBLCFGCURRENCY.IS_BASE_CURR     = '1';
END spGetBaseCurrecny;
PROCEDURE spGetPinSharingCategory(
    inChannelID IN VARCHAR2,
    outPinSharingCategory OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  SELECT TBLCFGCHANNEL.PINSHARINGCATEGORY
  INTO outPinSharingCategory
  FROM TBLCFGCHANNEL
  WHERE TBLCFGCHANNEL.CHANNELID = inChannelID;
END spGetPinSharingCategory;
PROCEDURE spGetATMDefaultAccount(
    inCustomerID IN VARCHAR2,
    outAccountNumber OUT VARCHAR2 )
IS
BEGIN
  SELECT account_id
  INTO outaccountnumber
  FROM tblcustchannelacct
  WHERE channel_id = '0001'
  AND is_default   = '1'
  AND customer_id  = incustomerid ;
END spGetATMDefaultAccount;
PROCEDURE spBL_GetLimitRelationsByProd(
    inProductID IN VARCHAR,
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  OPEN outCursor FOR SELECT A.*,
  B.CUSTOMER_ID,
  B.RELATIONSHIP_ID,
  B.ACCOUNT_ID,
  B.TYPE,
  B.CURRENCY FROM
  ( SELECT DISTINCT TBLCFGLIMIT.AMOUNT_ID,
    TBLCFGLIMIT.CHANNEL_ID,
    TBLCFGLIMIT.LIMIT_TYPE
  FROM TBLCFGLIMIT
  WHERE TBLCFGLIMIT.GROUP_ID   = inProductID
  AND TBLCFGLIMIT.is_inclusive = '0' --fahad 24-05-2010
  ORDER BY TBLCFGLIMIT.LIMIT_TYPE
  ) A,
  ( SELECT ACCOUNT_REL.* FROM tblimptmpaccount_rel ACCOUNT_REL
  ) B WHERE A.CHANNEL_ID = B.CHANNEL_ID;
END spBL_GetLimitRelationsByProd;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 11-Feb-2010
Description : To apply product based limits
***************************************************************************
S#     Who           Date          Change Description
1.     Fariha        1-JUL-2013    Added SP level logging
***************************************************************************
***************************************************************************
*/
PROCEDURE spBL_ApplyProductBasedLimits(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID VARCHAR2(100);
  spName    VARCHAR2(100);
  spDesc    VARCHAR2(500);
BEGIN
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_ApplyProductBasedLimits';
  spDesc    := 'SP to populate TBLIMPTMPLIMITS';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  DELETE tblimptmplimits;
  DELETE tblimptmpaccountlimit;
  DELETE tblimptmpcustomerlimit;
  --FOR Relationship BASED
  INSERT
  INTO tblimptmplimits
    (
      PRODUCTID,
      /*CHANNEL_ID,TRAN_CODE,*/
      AMOUNT_ID,
      RELATIONSHIP_ID,
      EXPIRY_DATE,
      CARD_NUMBER,
      CYCLE_BEGIN_DATE,
      REMAINING_LIMIT,
      IS_IND_LIMIT,
      IS_INDIVIDUAL,
      REMAINING_FREQUENCY,
      ACTIONFLAG
    )
  SELECT DISTINCT PRODUCTID,--CHANNEL_ID,TRAN_CODE,
    AMOUNT_ID,
    RELATIONSHIP_ID,
    SUBSTR(SUBSTR(TO_CHAR(sysdate,'yyyyMMdd'),1,2)
    ||SUBSTR(B.RELATIONSHIP_ID,instr(B.RELATIONSHIP_ID,'=')+1,LENGTH(B.RELATIONSHIP_ID))
    ||SUBSTR(TO_CHAR(sysdate,'ddyyyyMM'),1,2),0,8)                                    AS EXPIRY_DATE,
    NVL(SUBSTR(B.RELATIONSHIP_ID,0,instr(B.RELATIONSHIP_ID,'=')-1),B.RELATIONSHIP_ID) AS CARD_NUMBER,
    TO_CHAR(sysdate,'yyyyMMdd')                                                       AS CYCLE_BEGIN_DATE,
    B.AMOUNT                                                                          AS REMAINING_LIMIT,
    '0'                                                                               AS IS_IND_LIMIT,
    '0'                                                                               AS IS_INDIVIDUAL,
    B.FREQUENCY_QUOTA                                                                 AS REMAINING_FREQUENCY,
    '01'                                                                              AS ACTIONFLAG
  FROM
    ( SELECT DISTINCT TBLCFGLIMIT.AMOUNT_ID,
      TBLCFGLIMIT.TRAN_CODE,
      tblimptmpaccount_rel.*,
      TBLCFGLIMITAMOUNT.AMOUNT,
      TBLCFGLIMITAMOUNT.FREQUENCY_QUOTA
    FROM TBLCFGLIMIT,
      tblimptmpaccount_rel,
      TBLCFGLIMITAMOUNT
    WHERE TBLCFGLIMIT.GROUP_ID            = tblimptmpaccount_rel.productid
    AND TBLCFGLIMIT.CHANNEL_ID            = tblimptmpaccount_rel.CHANNEL_ID
    AND tblcfglimit.amount_id             = TBLCFGLIMITAMOUNT.amount_id
    AND TBLCFGLIMIT.LIMIT_TYPE            = '01'
    AND tblimptmpaccount_rel.customer_id IN
      ( SELECT customerid FROM tblimptmpcard WHERE regeneration_type != '12'
      )
    ) B;
  --For Account BASED
  INSERT
  INTO tblimptmpaccountlimit
    (
      AMOUNT_ID,
      ACCOUNT_ID,
      ACCOUNT_TYPE,
      ACCOUNT_CURRENCY,
      CYCLE_BEGIN_DATE,
      REMAINING_LIMIT,
      IS_INDIVIDUAL,
      ACTIONFLAG,
      INSTITUTIONID
    )
  SELECT DISTINCT AMOUNT_ID,
    ACCOUNT_ID,
    TYPE ACCOUNT_TYPE,
    CURRENCY ACCOUNT_CURRENCY,
    TO_CHAR(sysdate,'yyyyMMdd') AS CYCLE_BEGIN_DATE,
    B.AMOUNT                    AS REMAINING_LIMIT,
    '0'                         AS IS_INDIVIDUAL,
    '01'                        AS ACTIONFLAG,
    INSTITUTIONID
  FROM
    ( SELECT DISTINCT TBLCFGLIMIT.AMOUNT_ID,
      TBLCFGLIMIT.TRAN_CODE,
      tblimptmpaccount_rel.*,
      TBLCFGLIMITAMOUNT.AMOUNT,
      TBLCFGLIMITAMOUNT.FREQUENCY_QUOTA
    FROM TBLCFGLIMIT,
      tblimptmpaccount_rel,
      TBLCFGLIMITAMOUNT
    WHERE TBLCFGLIMIT.GROUP_ID = tblimptmpaccount_rel.productid
    AND TBLCFGLIMIT.CHANNEL_ID = tblimptmpaccount_rel.CHANNEL_ID
    AND tblcfglimit.amount_id  = tblcfglimitamount.amount_id
    AND TBLCFGLIMIT.LIMIT_TYPE = '02'
    ) B;
  --FOR CUSTOMER BASED
  INSERT
  INTO tblimptmpcustomerlimit
    (
      AMOUNT_ID,
      CUSTOMER_ID,
      CYCLE_BEGIN_DATE,
      REMAINING_LIMIT,
      IS_IND_LIMIT,
      REMAINING_FREQUENCY,
      ACTIONFLAG
    )
  SELECT DISTINCT AMOUNT_ID,
    CUSTOMER_ID,
    TO_CHAR(sysdate,'yyyyMMdd') AS CYCLE_BEGIN_DATE,
    B.AMOUNT                    AS REMAINING_LIMIT,
    '0'                         AS IS_IND_LIMIT,
    B.FREQUENCY_QUOTA           AS REMAINING_FREQUENCY,
    '01'                        AS ACTIONFLAG
  FROM
    ( SELECT DISTINCT TBLCFGLIMIT.AMOUNT_ID,
      TBLCFGLIMIT.TRAN_CODE,
      tblimptmpaccount_rel.*,
      TBLCFGLIMITAMOUNT.AMOUNT,
      TBLCFGLIMITAMOUNT.FREQUENCY_QUOTA
    FROM TBLCFGLIMIT,
      tblimptmpaccount_rel,
      TBLCFGLIMITAMOUNT
    WHERE TBLCFGLIMIT.GROUP_ID = tblimptmpaccount_rel.productid
    AND TBLCFGLIMIT.CHANNEL_ID = tblimptmpaccount_rel.CHANNEL_ID
    AND tblcfglimit.amount_id  = tblcfglimitamount.amount_id
    AND TBLCFGLIMIT.LIMIT_TYPE = '03'
    ) B;
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_ApplyProductBasedLimits;
PROCEDURE spBL_PrepareRemainingLimits(
    inLimitType IN VARCHAR2,
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal      := 0;
  IF (inLimitType = '01') THEN --RELATIONSHIP BASED LIMIT
    BEGIN
      OPEN outCursor FOR
      SELECT DISTINCT REMAININGLIMITS.AMOUNT_ID,
        REMAININGLIMITS.RELATIONSHIP_ID,
        SUBSTR(SUBSTR(TO_CHAR(sysdate,'yyyyMMdd'),1,2)
        ||SUBSTR(REMAININGLIMITS.RELATIONSHIP_ID,instr(REMAININGLIMITS.RELATIONSHIP_ID,'=')+1,LENGTH(REMAININGLIMITS.RELATIONSHIP_ID))
        ||SUBSTR(TO_CHAR(sysdate,'ddyyyyMM'),1,2),0,8)                                                                              AS EXPIRY_DATE,
        NVL(SUBSTR(REMAININGLIMITS.RELATIONSHIP_ID,0,instr(REMAININGLIMITS.RELATIONSHIP_ID,'=')-1),REMAININGLIMITS.RELATIONSHIP_ID) AS CARD_NUMBER,
        TO_CHAR(sysdate,'yyyyMMdd')                                                                                                 AS CYCLE_BEGIN_DATE,
        '0'                                                                                                                         AS REMAINING_LIMIT,
        '0'                                                                                                                         AS IS_IND_LIMIT,
        '0'                                                                                                                         AS IS_INDIVIDUAL,
        '0'                                                                                                                         AS REMAINING_FREQUENCY,
        '01'                                                                                                                        AS ACTIONFLAG
      FROM tblimptmpremaininglimits REMAININGLIMITS;
    END;
  ELSE
    BEGIN
      IF( inLimitType = '02') THEN --ACCOUNT BASED LIMIT
        OPEN outCursor FOR
        SELECT DISTINCT REMAININGLIMITS.AMOUNT_ID,
          REMAININGLIMITS.ACCOUNT_ID,
          TO_CHAR(sysdate,'yyyyMMdd') AS CYCLE_BEGIN_DATE,
          '0'                         AS REMAINING_LIMIT,
          '0'                         AS IS_IND_LIMIT,
          '0'                         AS IS_INDIVIDUAL,
          '0'                         AS REMAINING_FREQUENCY,
          '01'                        AS ACTIONFLAG,
          REMAININGLIMITS.TYPE        AS ACCOUNT_TYPE,
          REMAININGLIMITS.CURRENCY    AS ACCOUNT_CURRENCY
        FROM tblimptmpremaininglimits REMAININGLIMITS;
      ELSE
        IF( inLimitType = '03') THEN --CUSTOMER BASED LIMIT
          OPEN outCursor FOR
          SELECT DISTINCT REMAININGLIMITS.AMOUNT_ID,
            REMAININGLIMITS.CUSTOMER_ID,
            TO_CHAR(sysdate,'yyyyMMdd') AS CYCLE_BEGIN_DATE,
            '0'                         AS REMAINING_LIMIT,
            '0'                         AS IS_IND_LIMIT,
            '0'                         AS IS_INDIVIDUAL,
            '0'                         AS REMAINING_FREQUENCY,
            '01'                        AS ACTIONFLAG
          FROM tblimptmpremaininglimits REMAININGLIMITS;
        END IF;
      END IF;
    END;
  END IF;
END spBL_PrepareRemainingLimits;
PROCEDURE spBL_FilterRelationsbyChannel--for Card Based and ADC
  (
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  OPEN outCursor FOR
  SELECT DISTINCT RELATIONSHIP_ID,
    ACCOUNT_ID,
    TYPE     AS ACCOUNT_TYPE,
    CURRENCY AS ACCOUNT_CURRENCY,
    PRODUCTID,
    ChannelType
  FROM
    (SELECT RELATIONS.*,
      CASE
        WHEN TBLCFGCHANNEL.CARDREQUIRED = 'Y'
        THEN '0001'
        ELSE TBLCFGCHANNEL.CHANNELID
      END AS ChannelType
    FROM tblimptmprelations RELATIONS,
      TBLCFGCHANNEL
    WHERE RELATIONS.CHANNELID = TBLCFGCHANNEL.CHANNELID
    AND RELATIONS.CHANNELID  <> '9999'
    );
END spBL_FilterRelationsbyChannel;
PROCEDURE spBL_PrepareProductionEntries(
    inStageCode IN VARCHAR2,
    inProductID IN VARCHAR2,
    inChannelID IN VARCHAR2,
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  OPEN outCursor FOR
  SELECT DISTINCT PRODUCTION.RELATIONSHIP_ID,
    PRODUCTION.CHANNELTYPE AS CHANNEL_ID,
    inStageCode            AS STAGE,
    '0'                    AS ISFORCED,
    '01'                   AS ACTIONFLAG,
    ''                     AS ERR_DESCRIPTION
  FROM tblimptmpproductionstage PRODUCTION
  WHERE PRODUCTION.PRODUCTID = inProductID
  AND PRODUCTION.CHANNELTYPE = inChannelID;
END spBL_PrepareProductionEntries;
PROCEDURE spBL_PrepareRelationshipAuth(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  DELETE tblimptmprel_auth; --added as it has to be empty before inserting
  INSERT
  INTO tblimptmprel_auth
    (
      PIN,
      STATUS,
      RELATIONSHIPAUTH_ID,
      PIN_GEN_DATE,
      MAXRETRIES,
      REMRETRIES,
      REASON,
      ACTIONFLAG
    )
  SELECT DISTINCT PIN,
    STATUS,
    RELATIONSHIPAUTH_ID,
    PIN_GEN_DATE,
    NVL(MAXRETRIES,
    (SELECT TO_CHAR(TBLCFGPRODUCTCHANNELS.MAXRETRIES)
    FROM TBLCFGPRODUCTCHANNELS
    WHERE TBLCFGPRODUCTCHANNELS.CHANNEL_ID = ChannelType
    AND TBLCFGPRODUCTCHANNELS.PRODUCT_ID   = PRODUCTID
    )) AS MAXRETRIES,
    NVL(REMRETRIES,
    (SELECT TO_CHAR(TBLCFGPRODUCTCHANNELS.MAXRETRIES)
    FROM TBLCFGPRODUCTCHANNELS
    WHERE TBLCFGPRODUCTCHANNELS.CHANNEL_ID = ChannelType
    AND TBLCFGPRODUCTCHANNELS.PRODUCT_ID   = PRODUCTID
    )) AS REMRETRIES,
    REASON,
    '01' AS ACTIONFLAG
  FROM
    ( SELECT DISTINCT RELATIONS.RELATIONSHIP_ID,
      RELATIONS.ACCOUNT_ID,
      RELATIONS.TYPE,
      RELATIONS.CURRENCY,
      RELATIONS.PRODUCTID,
      RELATIONS.PIN,
      RELATIONS.STATUS,
      RELATIONS.REASON,
      RELATIONS.RELATIONSHIPAUTH_ID,
      RELATIONS.PIN_GEN_DATE,
      CASE
        WHEN TBLCFGCHANNEL.CARDREQUIRED = 'Y'
        THEN '0001'
        ELSE TBLCFGCHANNEL.CHANNELID
      END AS ChannelType,
      RELATIONS.MAXRETRIES,
      RELATIONS.REMRETRIES
    FROM tblimptmpaccount_rel RELATIONS,
      TBLCFGCHANNEL
    WHERE RELATIONS.CHANNEL_ID = TBLCFGCHANNEL.CHANNELID
    AND CHANNEL_ID            <> '9999'
    AND RELATIONSHIPAUTH_ID   IS NOT NULL --added by tanveer to prevent null exception in insertion layer
    AND RELATIONS.FAILED      IS NULL
    ) A;
  outRetVal := SQL%ROWCOUNT;
END spBL_PrepareRelationshipAuth;
PROCEDURE spBL_SetPrimaryPAN --MCB Specific Function
  (
    outProductID OUT VARCHAR2,
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
  l_ProductID VARCHAR2(100);
BEGIN
  outRetVal := 0;
  OPEN outCurSor FOR SELECT CARD.*,
  PRIMARYPAN.PPAN
AS
  PRIMARYCARDNUMBER FROM
  ( SELECT CARD.* FROM tblimptmpcard CARD
  )CARD,
  (SELECT SUBSTR(B.RELATIONSHIP_ID,0,instr(B.RELATIONSHIP_ID,'=')-1) AS PPAN,
    A.RELATIONSHIP_ID                                                AS CARDNUMBER
  FROM
    (SELECT ACCOUNT_REL.*
    FROM tblimptmpaccount_rel ACCOUNT_REL
    WHERE PRODUCTID            = l_ProductID
    AND ACCOUNT_REL.channel_id = '0001'
    )A,
    TBLCUSTCHANNELACCT B
  WHERE Trim(A.ACCOUNT_ID)                = Trim(B.ACCOUNT_ID)
  AND A.TYPE                              = B.ACCOUNT_TYPE
  AND A.CURRENCY                          = B.ACCOUNT_CURRENCY
  AND A.CHANNEL_ID                        = B.CHANNEL_ID
  AND B.IS_DEFAULT                        = '1'
  AND B.CHANNEL_ID                        = '0001'
  AND B.PRODUCTID                        <> l_ProductID
  ) PRIMARYPAN WHERE CARD.RELATIONSHIP_ID = PRIMARYPAN.CARDNUMBER;
END spBL_SetPrimaryPAN;
PROCEDURE spBL_CheckMaxSupplyAllowed(
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal                                                                         := 0;
  OPEN outCurSor FOR SELECT CARD.* FROM tblimptmpcard CARD WHERE ISSUPPLEMENTARYCARD = '1' AND PRIMARYCARDNUMBER IN
  (                   -- Gets all the cards whos maximum allowed supplementary are created and not HOT
  SELECT A.CARDNUMBER --,count(B.PRIMARYCARDNUMBER),A.GROUP_ID,(select MAX_SUPPLEMENTARY_ALLOWED from TBLCFGPRODUCTDETAIL where TBLCFGPRODUCTDETAIL.PRODUCT_ID = A.GROUP_ID)
  FROM tbldebitcard A,
    Tbldebitcard B
  WHERE A.CARDNUMBER     = B.PRIMARYCARDNUMBER
  AND B.RELATIONSHIP_ID IN
    (SELECT RELATIONSHIP_ID
    FROM tblcustchannelacct,
      tblrelationshipauth
    WHERE tblcustchannelacct.RELATIONSHIPAUTH_ID = tblrelationshipauth.RELATIONSHIPAUTH_ID
    AND tblrelationshipauth.STATUS NOT          IN ('02')
    )
  GROUP BY A.CARDNUMBER,
    A.GROUP_ID
  HAVING COUNT(B.PRIMARYCARDNUMBER) >=
    (SELECT TO_NUMBER(NVL(TBLCFGPRODUCTDETAIL.MAX_SUPPLEMENTARY_ALLOWED,'4'))
    FROM TBLCFGPRODUCTDETAIL
    WHERE TBLCFGPRODUCTDETAIL.PRODUCT_ID = A.GROUP_ID
    )
  );
END spBL_CheckMaxSupplyAllowed;
PROCEDURE spBL_GetCustomerWithNewProduct(
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
  l_Count NUMBER;
BEGIN
  outRetVal := 0;
  OPEN outCurSor FOR SELECT A.CUSTOMER_ID FROM
  (SELECT TRIM(ACCOUNT_REL.CUSTOMER_ID) AS CUSTOMER_ID,
    TRIM(ACCOUNT_REL.PRODUCTID)         AS PRODUCTID
  FROM tblimptmpaccount_rel ACCOUNT_REL
  ) A WHERE A.PRODUCTID NOT IN
  (SELECT TBLCUSTOMERPRODUCTS.productid
  FROM TBLCUSTOMERPRODUCTS
  WHERE TBLCUSTOMERPRODUCTS.customerid = A.CUSTOMER_ID
  );
END spBL_GetCustomerWithNewProduct;
PROCEDURE spCheckDefaultAlreadyExists(
    inChannelId      IN VARCHAR2,
    inRelationshipId IN VARCHAR2,
    inProductId      IN VARCHAR2,
    outRetVal OUT NUMBER )
IS
BEGIN
  SELECT COUNT(*)
  INTO outRetVal
  FROM TBLCUSTCHANNELACCT
  WHERE RELATIONSHIP_ID = inRelationshipId
  AND PRODUCTID         = inProductId
  AND CHANNEL_ID        = inchannelid
  AND IS_DEFAULT        = 1;
END spCheckDefaultAlreadyExists;
PROCEDURE spCheckAccountAlreadyLinked(
    inChannelId IN VARCHAR2,
    inAccountId IN VARCHAR2,
    outRetVal OUT NUMBER )
IS
BEGIN
  SELECT COUNT(*)
  INTO outRetVal
  FROM TBLCUSTCHANNELACCT
  WHERE ACCOUNT_ID = inAccountId
  AND CHANNEL_ID   = inchannelid;
END spCheckAccountAlreadyLinked;
/*
***************************************************************************
Created By  :
Dated       :
Description :
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.    Fahad Ali   10-Feb-2010   To work directly in tblimptmpcard using
tbltmpimppancards and tblimptmpaccount_rel
***************************************************************************
*/
PROCEDURE spBL_GetCardsWithPAN(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  l_Count     NUMBER;
  l_PAN       VARCHAR2(50);
  l_outpan    VARCHAR2(100);
  l_outretval NUMBER;
  tmpCardCusor REF_CURSOR;
  tmpCUSTOMERID   VARCHAR2(100);
  tmpPRODUCTID    VARCHAR2(100);
  tmpACCOUNT_ID   VARCHAR2(100);
  tmpCARDNAME     VARCHAR2(100);
  tmpBATCHID      VARCHAR2(100);
  tmpCUSTOMERTYPE VARCHAR2(100);
  tmpBRANCH_CODE  VARCHAR2(100);
  tmpCardSeq      VARCHAR2(1024);
  historyID       VARCHAR2(100);
  spName          VARCHAR2(100);
  spDesc          VARCHAR2(500);
  CURSOR tmpCardCursor
  IS
    SELECT tbltmpimppancards.CARDNUMBER,
      tbltmpimppancards.CUSTOMERID,
      tbltmpimppancards.PRODUCTID,
      tbltmpimppancards.ACCOUNT_ID,
      tbltmpimppancards.CARDNAME,
      tbltmpimppancards.BATCHID,
      TBLIMPTMPCARD.CUSTOMERTYPE,
      TBLIMPTMPCARD.BRANCHID,
      TBLIMPTMPCARD.SEQNO
    FROM tbltmpimppancards,
      TBLIMPTMPCARD
    WHERE tbltmpimppancards.CUSTOMERID = TBLIMPTMPCARD.CUSTOMERID
    ORDER BY tbltmpimppancards.Customerid;
BEGIN
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_GetCardsWithPAN';
  spDesc    := 'SP to populate TBLTMPIMPPANCARDS from TBLIMPTMPCARD';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  INSERT
  INTO tbltmpimppancards
    (
      CARDNUMBER,
      CUSTOMERID,
      PRODUCTID,
      ACCOUNT_ID,
      CARDNAME,
      BATCHID,
      ACTIONFLAG,
      CARDINTERFACINGNO,
      SEQNO
    )
  SELECT '',
    A.CUSTOMERID,
    A.PRODUCTID,
    A.ACCOUNT_ID,
    TBLIMPTMPCARD.CARDNAME,
    A.BATCHID,
    ACTIONFLAG,
    '',
    TBLIMPTMPCARD.SEQNO
  FROM
    (SELECT ACCOUNT_REL.CUSTOMER_ID AS CUSTOMERID,
      ACCOUNT_REL.PRODUCTID,
      ACCOUNT_ID,
      BATCHID
    FROM tblimptmpaccount_rel ACCOUNT_REL
    ) A,
    TBLIMPTMPCARD
  WHERE A.CUSTOMERID            = TBLIMPTMPCARD.CUSTOMERID
  AND A.productid               = TBLIMPTMPCARD.productid
  AND TBLIMPTMPCARD.FAILED     IS NULL
  AND TBLIMPTMPCARD.cardnumber IS NULL
  ORDER BY A.CUSTOMERID;
  OPEN tmpCardCursor;
  LOOP
    FETCH tmpCardCursor
    INTO l_outpan,
      tmpCUSTOMERID,
      tmpPRODUCTID,
      tmpACCOUNT_ID,
      tmpCARDNAME,
      tmpBATCHID,
      tmpCUSTOMERTYPE,
      tmpBRANCH_CODE,
      tmpCardSeq;
    EXIT
  WHEN tmpCardCursor%NOTFOUND;
    l_outretval := 0;
    -- BY SR - Feb 22 - 2011 - Merged from ENBD
    --<Edit Author: Fariha   Date: 02-12-2013  Description:  The one present in UIPKGPRSRELATIONSHIP does not work when branch code included in PAN Format -->
    -- spGeneratePANforImport(tmpPRODUCTID,tmpCUSTOMERID,tmpACCOUNT_ID,tmpCUSTOMERTYPE,tmpBRANCH_CODE,l_outpan,l_outretval);
    --UIPKGPRSRELATIONSHIP.spGeneratePAN(tmpPRODUCTID,tmpCUSTOMERID,tmpACCOUNT_ID,l_outpan,l_outretval);
    spGeneratePANforImport(tmpPRODUCTID,tmpCUSTOMERID,tmpACCOUNT_ID,l_outpan,l_outretval);
    IF l_outretval = 0 THEN
      UPDATE tbltmpimppancards
      SET cardnumber   = l_outpan
      WHERE customerid = tmpcustomerid
      AND productid    = tmpproductid
      AND ACCOUNT_ID   = tmpACCOUNT_ID
      AND SEQNO        = tmpCardSeq;
    ELSE
      outRetVal := l_outretval;
      --done by tanveer to report the pan error for the particular card and not rejecting all cards
      UPDATE tblimptmpcard tc
      SET tc.failed       = '1',
        tc.err_description= NVL(
        (SELECT 'ID: ['
          || tmpcustomerid
          || '], Product: ['
          || tmpproductid
          || '] -- '
          || exceptiondescription
        FROM tbldbexceptions
        WHERE exceptionnumber = l_outretval
        ),l_outretval)
      WHERE EXISTS
        (SELECT tp.cardnumber
        FROM tbltmpimppancards tp
        WHERE tp.customerid=tc.customerid
        AND tp.productid   =tc.productid
        AND tp.SEQNO       =tc.SEQNO
        AND rownum         <2
        AND tp.customerid  = tmpcustomerid
        AND tp.productid   = tmpproductid
        AND tp.ACCOUNT_ID  = tmpACCOUNT_ID
        )
      AND tc.cardnumber IS NULL; --added by tanveer as cards for update cardnumber were becoming null
      --      rollback;
      --      RETURN;
    END IF;
  END LOOP;
  CLOSE tmpCardCursor;
  UPDATE tblimptmpcard tc
  SET tc.cardnumber=
    (SELECT tp.cardnumber
    FROM tbltmpimppancards tp
    WHERE tp.customerid=tc.customerid
    AND tp.productid   =tc.productid
    AND tp.SEQNO       =tc.SEQNO
    AND rownum         <2
    )
  WHERE tc.cardnumber IS NULL--added by tanveer as cards for update cardnumber were becoming null
  AND tc.failed       IS NULL;
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := -1;
    outMsg    := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_GetCardsWithPAN;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 11-Feb-2010
Description : To register production stage cycle in tblimptmpproductionstage
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.    Fariha Akhtar   1-JUL-2013   Added SP level logging and commented PIN Regen
related logic
***************************************************************************
*/
PROCEDURE spBL_RegisterProductionCycle(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID VARCHAR2(100);
  spName    VARCHAR2(100);
  spDesc    VARCHAR2(500);
BEGIN
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_RegisterProductionCycle';
  spDesc    := 'SP to populate TBLIMPTMPPRODUCTIONSTAGE';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  /*  Fariha: Commenting as not required in ABL
  --fahad 18/08/2010 for handling pin regeneration request
  INSERT
  INTO tblimptmpproductionstage
  (
  RELATIONSHIP_ID,
  Channel_ID,
  ChannelType,
  ISFORCED,
  ACTIONFLAG,
  STAGE
  )
  SELECT DISTINCT RELATIONSHIP_ID,
  '0001'    AS Channel_ID,
  '0001'    AS ChannelType,
  '0'       AS ISFORCED,
  '01'      AS ACTIONFLAG,
  'PIN_GEN' AS STAGE
  FROM tblimptmpcard
  WHERE actionflag='15'
  AND failed     IS NULL;
  --fahad 18/08/2010 for handling pin regeneration request */
  INSERT
  INTO tblimptmpproductionstage
    (
      RELATIONSHIP_ID,
      /*PRODUCTID,*/
      Channel_ID,
      ChannelType,
      ISFORCED,
      ACTIONFLAG,
      STAGE
    )
  SELECT DISTINCT RELATIONSHIP_ID,
    --PRODUCTID,
    ChannelType,
    ChannelType,
    '0'  AS ISFORCED,
    '01' AS ACTIONFLAG,
    STAGE
  FROM
    (SELECT RELATIONS.*,
      ChannelType,
      STAGE
    FROM tblimptmpaccount_rel RELATIONS
    INNER JOIN
      ( SELECT DISTINCT Channelid AS ChannelType
      FROM TBLCFGCHANNEL
      WHERE CARDREQUIRED = 'N'
      AND channelid     IN
        (SELECT DISTINCT Channel_id
        FROM tblimptmpaccount_rel
        WHERE CHANNEL_ID <> '9999'
        )
      UNION
      SELECT NVL( tblcfgproductchannels.channel_id,'0001')
      FROM tblimptmpaccount_rel
      LEFT OUTER JOIN tblcfgproductchannels
      ON tblcfgproductchannels.product_id            = tblimptmpaccount_rel.productid
      WHERE tblcfgproductchannels.is_primary_channel = '1'
      AND rownum                                     = 1
      ) B ON RELATIONS.CHANNEL_ID                    = B.ChannelType,
      ( SELECT DISTINCT tc.stage_code AS STAGE,
        tc.Product_ID,
        tc.Channel_ID
      FROM TBLCFGPRODUCTPRODUCTIONCYCLE tc
      WHERE tc.ISINCLUDED          = 'Y'
      AND To_NUMBER(tc.SEQUENCENO) = 1
      ) C
    WHERE RELATIONS.FAILED IS NULL
    AND C.Product_ID        = RELATIONS.productid
    AND C.Channel_ID        = RELATIONS.CHANNEL_ID
    AND STAGE              IS NOT NULL
      --          SELECT RELATIONS.*,
      --                 ChannelType,
      --                 ( SELECT DISTINCT tc.stage_code FROM TBLCFGPRODUCTPRODUCTIONCYCLE tc WHERE tc.ISINCLUDED = 'Y' AND To_NUMBER(tc.SEQUENCENO) = 1
      --                   AND tc.Product_ID = RELATIONS.productid AND tc.Channel_ID = RELATIONS.CHANNEL_ID
      --                 ) as STAGE
      --          FROM tblimptmpaccount_rel RELATIONS INNER JOIN
      --              ( Select distinct Channelid as ChannelType from TBLCFGCHANNEL where CARDREQUIRED = 'N' and channelid in (Select distinct Channel_id from tblimptmpaccount_rel where CHANNEL_ID <> '9999')
      --                UNION
      --                select NVL( tblcfgproductchannels.channel_id,'0001') from tblimptmpaccount_rel
      --                left outer join tblcfgproductchannels
      --                on tblcfgproductchannels.product_id = tblimptmpaccount_rel.productid
      --                where tblcfgproductchannels.is_primary_channel = '1'
      --                and rownum = 1
      --              ) B on RELATIONS.CHANNEL_ID = B.ChannelType
      --          WHERE RELATIONS.FAILED IS NULL
    );
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := SQL%ROWCOUNT;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := 1;
    outMsg    := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_RegisterProductionCycle;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 12-Feb-2010
Description : To assign PAN from tblimptmpcard to tblimptmpcustomerdetail
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
PROCEDURE spBL_UpdateCardDetailsPAN(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpcustomerdetail tc
  SET tc.IDENTFIER =
    (SELECT ta.cardnumber
    FROM tblimptmpcard ta
    WHERE ta.customerid=tc.customerid
    AND ta.RECORDNUMBER=tc.RECORDNUMBER
    AND ta.failed     IS NULL
    AND rownum         <2
    )
  WHERE EXISTS
    (SELECT 1
    FROM tblimptmpcard ta
    WHERE ta.customerid=tc.customerid
    AND ta.failed     IS NULL
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := -1;
  END;
END spBL_UpdateCardDetailsPAN;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 11=Feb-2010
Description : To assign Customer Type value from tblimptmpcard to
tblimptmpcustomer
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
PROCEDURE spBL_UpdateCustomerType(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpcustomer tc
  SET tc.customertype =
    (SELECT DECODE(tp.customertype,'0','02','1','00') customertype
    FROM tblimptmpcard tp
    WHERE tp.customerid=tc.customerid
    AND rownum         =1
    )
  WHERE tc.failed IS NULL
  AND EXISTS
    (SELECT 1 FROM tblimptmpcard tp WHERE tp.customerid=tc.customerid
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := -1;
  END;
END spBL_UpdateCustomerType;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 11=Feb-2010
Description : To assign Branch ID value from tbltmpimpaccount to
tblimptmpcustomer
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
PROCEDURE spBL_UpdateCustomerBranch(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  /*update tblimptmpcustomer tc
  set tc.branch_code =(select ta.branchid from tblimptmpaccount ta where ta.customerid=tc.customerid and rownum<2)
  WHERE tc.failed is null
  and EXISTS (SELECT 1 from tblimptmpaccount ta where ta.customerid=tc.customerid);
  */
  UPDATE tblimptmpcustomer tc
  SET tc.branch_code =
    (SELECT SUBSTR(trim(ta.ACCOUNT_ID),1,4)
    FROM tblimptmpaccount_rel ta
    WHERE ta.CUSTOMER_ID=tc.customerid
    AND ta.recordnumber =tc.recordnumber
    AND rownum          <2
    )
  WHERE tc.failed IS NULL
  AND EXISTS
    (SELECT 1
    FROM tblimptmpaccount_rel ta
    WHERE ta.CUSTOMER_ID=tc.customerid
    AND ta.recordnumber =tc.recordnumber
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := -1;
  END;
END spBL_UpdateCustomerBranch;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 11=Feb-2010
Description : To assign Branch ID value from tbltmpimpaccount to
tblimptmpcard
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.  Fariha Akhtar    08-Jul-2013   Added SP Level Logging and picking branch
from branch id field
***************************************************************************
*/
PROCEDURE spBL_UpdateCardBranch(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID VARCHAR2(100);
  spName    VARCHAR2(100);
  spDesc    VARCHAR2(500);
BEGIN
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_UpdateCardBranch';
  spDesc    := 'SP to assign account branch in TBLIMPTMPACCOUNT to card in TBLIMPTMPCARD';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  UPDATE tblimptmpcard
  SET tblimptmpcard.branchid =
    (SELECT branchid
    FROM TBLIMPTMPACCOUNT_REL
    WHERE TBLIMPTMPACCOUNT_REL.customer_id=tblimptmpcard.customerid
    AND TBLIMPTMPACCOUNT_REL.productid    =tblimptmpcard.productid
    AND rownum                            <2
    )
  WHERE tblimptmpcard.failed IS NULL
  AND EXISTS
    (SELECT 1
    FROM TBLIMPTMPACCOUNT_REL
    WHERE TBLIMPTMPACCOUNT_REL.customer_id=tblimptmpcard.customerid
    AND TBLIMPTMPACCOUNT_REL.productid    =tblimptmpcard.productid
    );
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := -1;
    outMsg    := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_UpdateCardBranch;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 11=Feb-2010
Description : To assign Product ID value from tbltmpimpcard to
tblimptmpaccount_rel
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
PROCEDURE spBL_UpdateAccountRelProduct(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpaccount_rel ta
  SET ta.productid=
    (SELECT tc.productid
    FROM tblimptmpcard tc
    WHERE tc.customerid=ta.customer_id
    AND rownum         <2
    )
  WHERE EXISTS
    (SELECT 1 FROM tblimptmpcard tc WHERE tc.customerid=ta.customer_id
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := -1;
  END;
END spBL_UpdateAccountRelProduct;
PROCEDURE spBL_UpdateAccountBalance(
    outRetVal OUT NUMBER )
IS
  l_importRecords NUMBER;
  l_Count         NUMBER;
BEGIN
  outRetVal := 0;
  --gives the count of import records
  SELECT COUNT(*)
  INTO l_importRecords
  FROM tblimptmpaccount_balance
  WHERE failed IS NULL;
  --gives the count of the matching records from tblaccount
  SELECT COUNT(*)
  INTO l_Count
  FROM TBLACCOUNT
  WHERE DATE_SETTLEMENT IN
    (SELECT date_settlement FROM tblimptmpaccount_balance WHERE failed IS NULL
    );
  -- if not all records match raise error
  IF l_count <> l_importRecords THEN
    UPDATE tblimptmpaccount_balance
    SET failed        = '1',
      err_description ='Account Balances Not Settled for the given date'
    WHERE failed     IS NULL;
    outRetVal        := SQL%ROWCOUNT;
    RETURN;
  ELSE
    SELECT COUNT(*)
    INTO l_Count
    FROM TBLACCOUNT
    WHERE DATE_SETTLEMENT IN
      (SELECT DATE_SETTLEMENT FROM tblimptmpaccount_balance WHERE failed IS NULL
      )
    AND TBLACCOUNT.is_settled = '0';
    IF l_Count               <> l_importRecords THEN
      UPDATE tblimptmpaccount_balance
      SET failed        = '1',
        err_description ='Account Balances Already imported for the given date'
      WHERE failed     IS NULL;
      outRetVal        := SQL%ROWCOUNT;
      RETURN;
    END IF;
  END IF;
END spBL_UpdateAccountBalance;
PROCEDURE spBL_SetRelationShipAuth(
    outcursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
BEGIN
  OPEN outCursor FOR SELECT A.*,
  NVL(TBLCUSTCHANNELACCT.RELATIONSHIP_ID,RELATIONSHIP_AUTH_ID.nextval)
AS
  RELATIONSHIPAUTH_ID FROM
  ( SELECT DISTINCT RELATIONSHIP_ID,
    PINSHARINGCATEGORY
  FROM
    (SELECT ACCOUNT_REL."RELATIONSHIP_ID",
      ACCOUNT_REL."PINSHARINGCATEGORY"
    FROM tblimptmpaccount_rel ACCOUNT_REL
    )
  )A RIGHT OUTER JOIN TBLCUSTCHANNELACCT ON tblcustchannelacct.relationship_ID = A.RELATIONSHIP_ID;
  outRetVal                                                                   := SQL%ROWCOUNT;
END spBL_SetRelationShipAuth;
PROCEDURE spInsert(
    p_input IN REF_CURSOR )
IS
  l NUMBER;
BEGIN
  l := 0;
END spInsert;
PROCEDURE spBL_SetCardProductByIMD(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpcard CARD
  SET CARD.PRODUCTID =
    (SELECT PRODUCT_ID FROM tblcfgproduct WHERE imd = CARD.IMD AND rownum = 1
    )
  WHERE CARD.failed IS NULL;
  UPDATE tblimptmpcard CARD
  SET CARD.ERR_DESCRIPTION = 'Product for IMD ['
    ||CARD.imd
    ||'] does not Exist.',
    CARD.Failed         = '1'
  WHERE CARD.productid IS NULL;
  outRetVal            := SQL%ROWCOUNT;
END spBL_SetCardProductByIMD;
PROCEDURE spBL_SetRelationProductByIMD(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE Tblimptmpaccount_rel ACCOUNT_REL
  SET ACCOUNT_REL.PRODUCTID =
    (SELECT PRODUCT_ID
    FROM tblcfgproduct
    WHERE imd  = ACCOUNT_REL.IMD
    AND rownum = 1
    )
  WHERE ACCOUNT_REL.failed IS NULL;
  UPDATE Tblimptmpaccount_rel ACCOUNT_REL
  SET ACCOUNT_REL.ERR_DESCRIPTION = 'Product for IMD ['
    ||ACCOUNT_REL.imd
    ||'] does not Exist.',
    ACCOUNT_REL.Failed         = '1'
  WHERE ACCOUNT_REL.productid IS NULL;
END spBL_SetRelationProductByIMD;
PROCEDURE spBL_SetTranPermission(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  l_product     VARCHAR2(10);
  l_channel     VARCHAR2(10);
  l_Transaction VARCHAR2(10);
  --Qumber Hassan - Modify Variable length
  l_TranPerm    VARCHAR2(4000);
  l_AccountType VARCHAR(2);
  historyID     VARCHAR2(100);
  spName        VARCHAR2(100);
  spDesc        VARCHAR2(500);
  CURSOR ProductCursor
  IS
    SELECT DISTINCT ProductID FROM tblimptmpaccount_rel;
  CURSOR ChannelCursor
  IS
    SELECT DISTINCT Channel_ID
    FROM tblimptmpaccount_rel
    WHERE tblimptmpaccount_rel.ProductID = l_product;
  CURSOR AccountCursor
  IS
    SELECT DISTINCT type
    FROM tblimptmpaccount_rel
    WHERE tblimptmpaccount_rel.ProductID = l_product
    AND tblimptmpaccount_rel.channel_id  = l_channel;
  /*
  Cursor TransactionCursor is
  Select Distinct tran_code
  From TBLCFGProductChannelTran
  Where TBLCFGProductCHannelTran.Product_ID = l_product
  and TBLCFGProductCHannelTran.Channel_ID = l_channel;
  */
  CURSOR TransactionCursor
  IS
    SELECT DISTINCT tran_code
    FROM TBLCFGPRODUCTACCOUNTTRAN
    WHERE TBLCFGPRODUCTACCOUNTTRAN.Product_ID = l_product
    AND TBLCFGPRODUCTACCOUNTTRAN.Channel_ID   = l_channel
    AND tblcfgproductaccounttran.account_type = l_AccountType;
BEGIN
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_SetTranPermission';
  spDesc    := 'SP to populate tran perm in TBLIMPTMPACCOUNT_REL';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  OPEN ProductCursor;
  LOOP
    EXIT
  WHEN ProductCursor %NOTFOUND;
    FETCH ProductCursor INTO l_product;
    OPEN ChannelCursor;
    LOOP
      EXIT
    WHEN ChannelCursor %NOTFOUND;
      FETCH ChannelCursor INTO l_channel;
      OPEN AccountCursor;
      LOOP
        EXIT
      WHEN AccountCursor %NOTFOUND;
        FETCH AccountCursor INTO l_AccountType;
        OPEN TransactionCursor;
        LOOP
          EXIT
        WHEN TransactionCursor %NOTFOUND;
          FETCH TransactionCursor INTO l_Transaction;
          l_TranPerm := l_TranPerm || l_Transaction || '-';
        END LOOP;
        CLOSE TransactionCursor;
        UPDATE TBLIMPTMPACCOUNT_REL
        SET Tran_perm                        = l_TranPerm
        WHERE TBLIMPTMPACCOUNT_REL.PRODUCTID = l_product
        AND TBLIMPTMPACCOUNT_REL.CHANNEL_ID  = l_channel
        AND TBLIMPTMPACCOUNT_REL.type        = l_AccountType;
        outRetVal                           := SQL%ROWCOUNT;
        l_TranPerm                          := '';
      END LOOP;
      CLOSE AccountCursor;
    END LOOP;
    CLOSE ChannelCursor;
  END LOOP;
  CLOSE ProductCursor;
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := 1;
    outMsg    := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_SetTranPermission;
PROCEDURE spBL_PrepareCustomerProducts(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID VARCHAR2(100);
  spName    VARCHAR2(100);
  spDesc    VARCHAR2(500);
BEGIN
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_PrepareCustomerProducts';
  spDesc    := 'SP to populate TBLIMPTMPCUSTOMERPRODUCTS from TBLIMPTMPACCOUNT_REL';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  DELETE TBLIMPTMPCUSTOMERPRODUCTS;
  INSERT
  INTO TBLIMPTMPCUSTOMERPRODUCTS
    (
      CUSTOMER_ID,
      PRODUCTID,
      IS_DEFAULT_ONGDC,
      ACTIONFLAG
    )
  SELECT DISTINCT CUSTOMER_ID,
    PRODUCTID,
    '0'  AS "IS_DEFAULT_ONGDC",
    '01' AS "ACTIONFLAG"
  FROM tblimptmpaccount_rel
  WHERE channel_ID <> '9999'
  AND failed       IS NULL;
  --insert into TBLSABAIMPTEMPCUSTOMERPRODUCTS select * from tblimptmpcustomerproducts;
  ---Incorporating logic to mark first product coming against any customer as Default on ADC
  UPDATE tblimptmpcustomerproducts A
  SET is_default_ongdc = '1'
  WHERE
    --<Comment By: Saba Anjum , 19-09-2017, To allow the new product as default>
    --<UnComment By: Saba Anjum , 11-01-2018, To make first product as default>
    A.CUSTOMER_ID NOT IN
    (SELECT C.CUSTOMERID FROM TBLCUSTOMERPRODUCTS C
    )
  AND
    --End <Comment By: Saba Anjum , 19-09-2017>
    --End <UnComment By: Saba Anjum , 11-01-2018, To make first product as default>
    (PRODUCTID, CUSTOMER_ID) IN
    (SELECT product_id,
      customer_id
    FROM
      (SELECT cp.customer_id,
        pd.product_id,
        NVL(pd.priority,0) prodpri,
        MAX(NVL(pd.priority,0)) over (partition BY customer_id) maxpriority
      FROM tblcfgproductdetail pd,
        tblimptmpcustomerproducts cp
      WHERE pd.product_id = cp.productid
      )
    WHERE customer_id = A.CUSTOMER_ID
    AND prodpri       = maxpriority
    );
  --TEMPORARY ADDED BY MUSFAR 23AUG
  --insert into tblimptmpcustomerproducts_new2 select * from tblimptmpcustomerproducts;
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  outRetVal := 0;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    outMsg := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_PrepareCustomerProducts;
/*
***************************************************************************
Created By  :  Salman Aziz
Dated       : 01 April 2010
Description : PrepareCustomerProducts with IsDefaultOnGDC = 1
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
PROCEDURE spBL_AddCustomerProductsOnGDCI(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  INSERT
  INTO TBLIMPTMPCUSTOMERPRODUCTS
    (
      CUSTOMER_ID,
      PRODUCTID,
      IS_DEFAULT_ONGDC,
      ACTIONFLAG
    )
  SELECT DISTINCT CUSTOMER_ID,
    PRODUCTID,
    '1'  AS "IS_DEFAULT_ONGDC",
    '01' AS "ACTIONFLAG"
  FROM tblimptmpaccount_rel
  WHERE channel_ID <> '9999'
  AND failed       IS NULL;
END spBL_AddCustomerProductsOnGDCI;
PROCEDURE spBL_SetLimitProductByIMD(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmplimits Limits
  SET Limits.PRODUCTID =
    (SELECT PRODUCT_ID
    FROM tblcfgproduct
    WHERE imd  = SUBSTR(Limits.relationship_id,0,6)
    AND rownum = 1
    )
  WHERE Limits.failed IS NULL;
  UPDATE tblimptmplimits Limits
  SET Limits.ERR_DESCRIPTION = 'Product for IMD ['
    ||Limits.imd
    ||'] does not Exist.',
    Limits.Failed         = '1'
  WHERE Limits.productid IS NULL;
END spBL_SetLimitProductByIMD;
PROCEDURE spBL_GenerateLimitRows(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  INSERT
  INTO TBLIMPTMPLIMITS
    (
      CHANNEL_ID ,
      CARD_NUMBER ,
      EXPIRY_DATE ,
      RELATIONSHIP_ID ,
      ACCOUNT_ID ,
      TRAN_CODE ,
      AMOUNT ,
      AMOUNT_ID ,
      LIMIT_TYPE ,
      LIMIT_FREQUENCY ,
      CYCLE_LENGTH ,
      PRODUCTID ,
      IS_INDIVIDUAL ,
      CUSTOMER_ID ,
      ACTIONFLAG ,
      ACTIONDATE ,
      PROCESSFLAG ,
      PROCESSDATE ,
      ERR_DESCRIPTION ,
      CYCLE_BEGIN_DATE ,
      REMAINING_LIMIT ,
      IS_IND_LIMIT ,
      REMAINING_FREQUENCY,
      ACCOUNT_TYPE ,
      FAILED ,
      IMD
    )
  SELECT tblcfgproductchanneltran.CHANNEL_ID,
    TBLIMPTMPLIMITS.CARD_NUMBER ,
    TBLIMPTMPLIMITS.EXPIRY_DATE ,
    TBLIMPTMPLIMITS.RELATIONSHIP_ID ,
    TBLIMPTMPLIMITS.ACCOUNT_ID ,
    TBLIMPTMPLIMITS.TRAN_CODE ,
    TBLIMPTMPLIMITS.AMOUNT ,
    TBLIMPTMPLIMITS.AMOUNT_ID ,
    TBLIMPTMPLIMITS.LIMIT_TYPE ,
    TBLIMPTMPLIMITS.LIMIT_FREQUENCY ,
    TBLIMPTMPLIMITS.CYCLE_LENGTH ,
    TBLIMPTMPLIMITS.PRODUCTID ,
    TBLIMPTMPLIMITS.IS_INDIVIDUAL ,
    TBLIMPTMPLIMITS.CUSTOMER_ID ,
    TBLIMPTMPLIMITS.ACTIONFLAG ,
    TBLIMPTMPLIMITS.ACTIONDATE ,
    TBLIMPTMPLIMITS.PROCESSFLAG ,
    TBLIMPTMPLIMITS.PROCESSDATE ,
    TBLIMPTMPLIMITS.ERR_DESCRIPTION ,
    TBLIMPTMPLIMITS.CYCLE_BEGIN_DATE ,
    TBLIMPTMPLIMITS.REMAINING_LIMIT ,
    TBLIMPTMPLIMITS.IS_IND_LIMIT ,
    TBLIMPTMPLIMITS.REMAINING_FREQUENCY,
    TBLIMPTMPLIMITS.ACCOUNT_TYPE ,
    TBLIMPTMPLIMITS.FAILED ,
    TBLIMPTMPLIMITS.IMD
  FROM tblimptmplimits,
    tblcfgproductchanneltran
  WHERE tblimptmplimits.productid = tblcfgproductchanneltran.product_id
  AND tblimptmplimits.tran_code   = tblcfgproductchanneltran.tran_code
  AND tblimptmplimits.failed     IS NULL;
  DELETE TBLIMPTMPLIMITS WHERE channel_id = '9999';
  outRetVal := SQL%ROWCOUNT;
END spBL_GenerateLimitRows;
PROCEDURE spBL_setAccountRelFields(
    inXML IN CLOB,
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal:=0;
  DELETE
  FROM XML_DOCUMENT_TABLE
  WHERE XML_DOCUMENT_TABLE.FILENAME = 'ACCOUNT_REL';
  COMMIT;
  INSERT INTO XML_DOCUMENT_TABLE VALUES
    ('ACCOUNT_REL',xmltype(inXML)
    );
  COMMIT;
  INSERT INTO RELATIONS
  SELECT RELATIONS.SELECTIONTYPE,
    RELATIONS.ACCOUNTMAP,
    RELATIONS.IS_DEFAULT,
    RELATIONS.ACCOUNT_ID,
    RELATIONS.TYPE,
    RELATIONS.CURRENCY,
    RELATIONS.CUSTOMER_ID,
    RELATIONS.NATURE,
    RELATIONS.PRODUCTID,
    RELATIONS.TRAN_PERM,
    RELATIONS.RELATIONSHIP_ID,
    RELATIONS.PINSHARINGCATEGORY,
    RELATIONS.CHANNEL_ID,
    RELATIONS.PIN,
    RELATIONS.REASON,
    RELATIONS.ACTIONFLAG,
    RELATIONS.HOSTCUSTOMERID
  FROM XML_DOCUMENT_TABLE,
    XMLTABLE('/NewDataSet/ACCOUNT_REL' PASSING XML_DOCUMENT_TABLE.XML_DOCUMENT COLUMNS SELECTIONTYPE VARCHAR2(100) PATH '/ACCOUNT_REL/SELECTIONTYPE', ACCOUNTMAP VARCHAR2(100) PATH '/ACCOUNT_REL/ACCOUNTMAP', ACCOUNT_ID VARCHAR2(100) PATH '/ACCOUNT_REL/ACCOUNT_ID', TYPE VARCHAR2(100) PATH '/ACCOUNT_REL/TYPE', CUSTOMER_ID VARCHAR2(100) PATH '/ACCOUNT_REL/CUSTOMER_ID', NATURE VARCHAR2(100) PATH '/ACCOUNT_REL/NATURE', PRODUCTID VARCHAR2(100) PATH '/ACCOUNT_REL/PRODUCTID', TRAN_PERM VARCHAR2(100) PATH '/ACCOUNT_REL/TRAN_PERM', CURRENCY VARCHAR2(100) PATH '/ACCOUNT_REL/CURRENCY', IS_DEFAULT VARCHAR2(100) PATH '/ACCOUNT_REL/IS_DEFAULT', RELATIONSHIP_ID VARCHAR2(100) PATH '/ACCOUNT_REL/RELATIONSHIP_ID', PINSHARINGCATEGORY VARCHAR2(100) PATH '/ACCOUNT_REL/PINSHARINGCATEGORY', CHANNEL_ID VARCHAR2(100) PATH '/ACCOUNT_REL/CHANNEL_ID', PIN VARCHAR2(100) PATH '/ACCOUNT_REL/PIN', REASON VARCHAR2(100) PATH '/ACCOUNT_REL/REASON', ACTIONFLAG VARCHAR2(100) PATH '/ACCOUNT_REL/ACTIONFLAG', HOSTCUSTOMERID
                                                                                                     VARCHAR2(100) PATH '/ACCOUNT_REL/HOSTCUSTOMERID') RELATIONS
  WHERE XML_DOCUMENT_TABLE.FILENAME = 'ACCOUNT_REL';
  OPEN outCursor FOR SELECT
  CASE
  WHEN B.PRODUCTID IS NULL THEN
    C.GROUP_ID
  ELSE
    B.PRODUCTID
  END
AS
  PRODUCTID,
  C.RELATIONSHIP_ID,
  CASE
  WHEN B.CARDNAME IS NULL THEN
    C.CARDNAME
  ELSE
    B.CARDNAME
  END
AS
  CARDNAME,
  CASE
  WHEN B.CARDSTATUS IS NULL THEN
    C.CARDSTATUS
  ELSE
    B.CARDSTATUS
  END
AS
  STATUS,
  B.IMD ,
  B.BATCHID,
  A.*,
  ''
AS
  RELATIONSHIPAUTH_ID,
  ''
AS
  ERR_DESCRIPTION FROM RELATIONS A LEFT OUTER JOIN
  (SELECT CARD.*
  FROM XML_DOCUMENT_TABLE,
    XMLTABLE('/NewDataSet/CARD' PASSING XML_DOCUMENT_TABLE.XML_DOCUMENT COLUMNS "CUSTOMERID" VARCHAR(100) PATH '/CARD/CUSTOMERID', "IMD" VARCHAR(100) PATH '/CARD/IMD', "PRODUCTID" VARCHAR(100) PATH '/CARD/PRODUCTID', "CARDNAME" VARCHAR(100) PATH '/CARD/CARDNAME', "CARDSTATUS" VARCHAR(100) PATH '/CARD/CARDSTATUS', "BATCHID" VARCHAR(100) PATH '/CARD/BATCHID' ) CARD
  WHERE XML_DOCUMENT_TABLE.FILENAME = 'ACCOUNT_REL'
  )B ON A.CUSTOMER_ID               = B.CUSTOMERID LEFT OUTER JOIN TBLDEBITCARD C ON A.CUSTOMER_ID = C.CARD_INTERFACING_NO;
END spBL_setAccountRelFields;
PROCEDURE spBL_setORIGINAL_AcctRelFields(
    inXML IN CLOB,
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal:=0;
  DELETE
  FROM XML_DOCUMENT_TABLE
  WHERE XML_DOCUMENT_TABLE.FILENAME = 'ORIGINAL_ACCOUNT_REL';
  COMMIT;
  INSERT
  INTO XML_DOCUMENT_TABLE VALUES
    (
      'ORIGINAL_ACCOUNT_REL',
      xmltype(inXML)
    );
  COMMIT;
  INSERT INTO RELATIONS
  SELECT RELATIONS.SELECTIONTYPE,
    RELATIONS.ACCOUNTMAP,
    RELATIONS.IS_DEFAULT,
    RELATIONS.ACCOUNT_ID,
    RELATIONS.TYPE,
    RELATIONS.CURRENCY,
    RELATIONS.CUSTOMER_ID,
    RELATIONS.NATURE,
    RELATIONS.PRODUCTID,
    RELATIONS.TRAN_PERM,
    RELATIONS.RELATIONSHIP_ID,
    RELATIONS.PINSHARINGCATEGORY,
    RELATIONS.CHANNEL_ID,
    RELATIONS.PIN,
    RELATIONS.REASON,
    RELATIONS.ACTIONFLAG,
    RELATIONS.HOSTCUSTOMERID
  FROM XML_DOCUMENT_TABLE,
    XMLTABLE('/NewDataSet/ORIGINAL_ACCOUNT_REL' PASSING XML_DOCUMENT_TABLE.XML_DOCUMENT COLUMNS SELECTIONTYPE VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/SELECTIONTYPE', ACCOUNTMAP VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/ACCOUNTMAP', ACCOUNT_ID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/ACCOUNT_ID', TYPE VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/TYPE', CUSTOMER_ID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/CUSTOMER_ID', NATURE VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/NATURE', PRODUCTID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/PRODUCTID', TRAN_PERM VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/TRAN_PERM', CURRENCY VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/CURRENCY', IS_DEFAULT VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/IS_DEFAULT', RELATIONSHIP_ID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/RELATIONSHIP_ID', PINSHARINGCATEGORY VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/PINSHARINGCATEGORY', CHANNEL_ID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/CHANNEL_ID', PIN VARCHAR2(100) PATH
    '/ORIGINAL_ACCOUNT_REL/PIN', REASON                                                                       VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/REASON', ACTIONFLAG VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/ACTIONFLAG', HOSTCUSTOMERID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/HOSTCUSTOMERID') RELATIONS
  WHERE XML_DOCUMENT_TABLE.FILENAME = 'ORIGINAL_ACCOUNT_REL';
  OPEN outCursor FOR SELECT NVL(B.PRODUCTID,'-1')
AS
  PRODUCTID,
  B.CARDNAME,
  B.STATUS,
  B.IMD ,
  B.BATCHID,
  A.*,
  ''
AS
  RELATIONSHIPAUTH_ID,
  ''
AS
  ERR_DESCRIPTION FROM RELATIONS A LEFT OUTER JOIN
  (SELECT ACCOUNT_REL.*
  FROM XML_DOCUMENT_TABLE,
    XMLTABLE('/NewDataSet/ACCOUNT_REL' PASSING XML_DOCUMENT_TABLE.XML_DOCUMENT COLUMNS ACCOUNT_ID VARCHAR2(100) PATH '/ACCOUNT_REL/ACCOUNT_ID', TYPE VARCHAR2(100) PATH '/ACCOUNT_REL/TYPE', PRODUCTID VARCHAR2(100) PATH '/ACCOUNT_REL/PRODUCTID', CURRENCY VARCHAR2(100) PATH '/ACCOUNT_REL/CURRENCY', HOSTCUSTOMERID VARCHAR2(100) PATH '/ACCOUNT_REL/HOSTCUSTOMERID', CARDNAME VARCHAR2(100) PATH '/ACCOUNT_REL/CARDNAME', STATUS VARCHAR2(100) PATH '/ACCOUNT_REL/STATUS', IMD VARCHAR2(100) PATH '/ACCOUNT_REL/IMD', BATCHID VARCHAR2(100) PATH '/ACCOUNT_REL/BATCHID') ACCOUNT_REL
  WHERE XML_DOCUMENT_TABLE.FILENAME = 'ORIGINAL_ACCOUNT_REL'
  )B ON A.CUSTOMER_ID               = B.HOSTCUSTOMERID AND A.ACCOUNT_ID = B.ACCOUNT_ID AND A.TYPE = B.TYPE AND A.CURRENCY = B.CURRENCY;
END spBL_setORIGINAL_AcctRelFields;
PROCEDURE spBL_makeFinalAccountRel(
    inXML IN CLOB,
    outCursor OUT REF_CURSOR,
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal:=0;
  DELETE
  FROM XML_DOCUMENT_TABLE
  WHERE XML_DOCUMENT_TABLE.FILENAME = 'ACCOUNT_REL';
  COMMIT;
  INSERT INTO XML_DOCUMENT_TABLE VALUES
    ('ACCOUNT_REL',xmltype(inXML)
    );
  COMMIT;
  INSERT INTO RELATIONS
  SELECT RELATIONS.SELECTIONTYPE,
    RELATIONS.ACCOUNTMAP,
    RELATIONS.IS_DEFAULT,
    RELATIONS.ACCOUNT_ID,
    RELATIONS.TYPE,
    RELATIONS.CURRENCY,
    RELATIONS.CUSTOMER_ID,
    RELATIONS.NATURE,
    RELATIONS.PRODUCTID,
    RELATIONS.TRAN_PERM,
    RELATIONS.RELATIONSHIP_ID,
    RELATIONS.PINSHARINGCATEGORY,
    RELATIONS.CHANNEL_ID,
    RELATIONS.PIN,
    RELATIONS.REASON,
    RELATIONS.ACTIONFLAG,
    RELATIONS.HOSTCUSTOMERID
  FROM XML_DOCUMENT_TABLE,
    XMLTABLE('/NewDataSet/ORIGINAL_ACCOUNT_REL' PASSING XML_DOCUMENT_TABLE.XML_DOCUMENT COLUMNS SELECTIONTYPE VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/SELECTIONTYPE', ACCOUNTMAP VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/ACCOUNTMAP', ACCOUNT_ID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/ACCOUNT_ID', TYPE VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/TYPE', CUSTOMER_ID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/CUSTOMER_ID', NATURE VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/NATURE', PRODUCTID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/PRODUCTID', TRAN_PERM VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/TRAN_PERM', CURRENCY VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/CURRENCY', IS_DEFAULT VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/IS_DEFAULT', RELATIONSHIP_ID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/RELATIONSHIP_ID', PINSHARINGCATEGORY VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/PINSHARINGCATEGORY', CHANNEL_ID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/CHANNEL_ID', PIN VARCHAR2(100) PATH
    '/ORIGINAL_ACCOUNT_REL/PIN', REASON                                                                       VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/REASON', ACTIONFLAG VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/ACTIONFLAG', HOSTCUSTOMERID VARCHAR2(100) PATH '/ORIGINAL_ACCOUNT_REL/HOSTCUSTOMERID') RELATIONS
  WHERE XML_DOCUMENT_TABLE.FILENAME = 'ACCOUNT_REL';
  OPEN outCursor FOR SELECT A.CHANNEL_ID
AS
  CHANNEL_ID,
  A.CUSTOMER_ID
AS
  CUSTOMER_ID,
  A.*,
  ''
AS
  RELATIONSHIPAUTH_ID FROM relations A
  UNION
  SELECT
    CASE
      WHEN RELATIONS.CHANNEL_ID      = '9999'
      AND RELATIONS.RELATIONSHIP_ID IS NOT NULL
      THEN '0000'
      ELSE RELATIONS.CHANNEL_ID
    END                      AS CHANNEL_ID,
    RELATIONS.HOSTCUSTOMERID AS CUSTOMER_ID,
    RELATIONS.*
  FROM XML_DOCUMENT_TABLE,
    XMLTABLE('/NewDataSet/ACCOUNT_REL' PASSING XML_DOCUMENT_TABLE.XML_DOCUMENT COLUMNS SELECTIONTYPE VARCHAR2(100) PATH '/ACCOUNT_REL/SELECTIONTYPE', ACCOUNTMAP VARCHAR2(100) PATH '/ACCOUNT_REL/ACCOUNTMAP', IS_DEFAULT VARCHAR2(100) PATH '/ACCOUNT_REL/IS_DEFAULT', ACCOUNT_ID VARCHAR2(100) PATH '/ACCOUNT_REL/ACCOUNT_ID', TYPE VARCHAR2(100) PATH '/ACCOUNT_REL/TYPE', CURRENCY VARCHAR2(100) PATH '/ACCOUNT_REL/CURRENCY', CUSTOMER_ID VARCHAR2(100) PATH '/ACCOUNT_REL/CUSTOMER_ID', NATURE VARCHAR2(100) PATH '/ACCOUNT_REL/NATURE', PRODUCTID VARCHAR2(100) PATH '/ACCOUNT_REL/PRODUCTID', TRAN_PERM VARCHAR2(100) PATH '/ACCOUNT_REL/TRAN_PERM', RELATIONSHIP_ID VARCHAR2(100) PATH '/ACCOUNT_REL/RELATIONSHIP_ID', PINSHARINGCATEGORY VARCHAR2(100) PATH '/ACCOUNT_REL/PINSHARINGCATEGORY', CHANNEL_ID VARCHAR2(100) PATH '/ACCOUNT_REL/CHANNEL_ID', PIN VARCHAR2(100) PATH '/ACCOUNT_REL/PIN', REASON VARCHAR2(100) PATH '/ACCOUNT_REL/REASON', ACTIONFLAG VARCHAR2(100) PATH '/ACCOUNT_REL/ACTIONFLAG', HOSTCUSTOMERID
                                                                                                     VARCHAR2(100) PATH '/ACCOUNT_REL/HOSTCUSTOMERID', RELATIONSHIPAUTH_ID VARCHAR2(100) PATH '/ACCOUNT_REL/RELATIONSHIPAUTH_ID' ) RELATIONS
  WHERE XML_DOCUMENT_TABLE.FILENAME = 'ACCOUNT_REL'
  AND ( (RELATIONS.CHANNEL_ID      <> '9999')
  OR (RELATIONS.CHANNEL_ID          = '9999'
  AND RELATIONS.RELATIONSHIP_ID    IS NOT NULL) );
END spBL_makeFinalAccountRel;
--added by tanveer used in mucodec / bci/ bicec
PROCEDURE spBL_ImportRecordIfBranchExist(
    inFormatId IN VARCHAR2,
    outRetVal OUT NUMBER )
IS
  inInstitutionId VARCHAR2(100);
BEGIN
  outRetVal:=0;
  SELECT institutionid
  INTO inInstitutionId
  FROM tblimpformat
  WHERE formatid = inFormatId;
  UPDATE tblimptmpcustomer
  SET failed             = '1',
    err_description      = 'Branch Code does not exists.'
  WHERE branch_code NOT IN
    (SELECT branch_id FROM tblbranch WHERE institutionid = inInstitutionId
    )
  AND tblimptmpcustomer.failed IS NULL;
  UPDATE tblimptmpaccount
  SET failed          = '1',
    err_description   = 'Branch Code does not exists.'
  WHERE branchid NOT IN
    (SELECT branch_id FROM tblbranch WHERE institutionid = inInstitutionId
    )
  AND tblimptmpaccount.failed IS NULL;
  UPDATE tblimptmpcard
  SET failed          = '1',
    err_description   = 'Branch Code does not exists.'
  WHERE branchid NOT IN
    (SELECT branch_id FROM tblbranch WHERE institutionid = inInstitutionId
    )
  AND tblimptmpcard.failed IS NULL;
  UPDATE tblimptmpaccount_rel
  SET failed                            = '1',
    err_description                     = 'Branch Code does not exists.'
  WHERE ( (account_id, type, currency) IN
    (SELECT account_id,
      account_type,
      account_currency
    FROM tblimptmpaccount
    WHERE branchid NOT IN
      (SELECT branch_id FROM tblbranch WHERE institutionid = inInstitutionId
      )
    ) )
  AND tblimptmpaccount_rel.failed IS NULL;
  UPDATE tblimptmpmultilimitsobj
  SET failed                                            = '1',
    err_description                                     = 'Branch Code does not exists.'
  WHERE ( (account_id, account_type, account_currency) IN
    (SELECT account_id,
      account_type,
      account_currency
    FROM tblimptmpaccount
    WHERE branchid NOT IN
      (SELECT branch_id FROM tblbranch WHERE institutionid = inInstitutionId
      )
    ) )
  AND tblimptmpmultilimitsobj.failed IS NULL;
  UPDATE tblimptmporiginal_account_rel
  SET failed                            = '1',
    err_description                     = 'Branch Code does not exists.'
  WHERE ( (account_id, type, currency) IN
    (SELECT account_id,
      account_type,
      account_currency
    FROM tblimptmpaccount
    WHERE branchid NOT IN
      (SELECT branch_id FROM tblbranch WHERE institutionid = inInstitutionId
      )
    ) )
  AND tblimptmporiginal_account_rel.failed IS NULL;
END spBL_ImportRecordIfBranchExist;
PROCEDURE spBL_MarkFirstAcctDefOnChan(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal:=0;
  UPDATE tblimptmpaccount_rel
  SET is_default                                                           = '1'
  WHERE (relationship_id, channel_id, customer_id, productid, account_id) IN
    (SELECT relationship_id,
      channel_id,
      customer_id,
      productid,
      MIN(account_id)
    FROM tblimptmpaccount_rel
    GROUP BY relationship_id,
      customer_id,
      productid,
      channel_id
    )
  AND failed IS NULL;
  outRetVal  := SQL%ROWCOUNT;
END spBL_MarkFirstAcctDefOnChan;
/*PROCEDURE spBL_SetRelationShipAuth
(
outRetVal OUT NUMBER
)
IS
l_relationship_id VARCHAR2(100);
l_pinsharingcategory VARCHAR2(100);
l_RELAUTH_ID VARCHAR2(100);
CURSOR tmpRelAuthCursor IS
select A.*,RELATIONSHIP_AUTH_ID.nextval as RELAUTH_ID FROM
( SELECT DISTINCT
tblimptmpaccount_rel.RELATIONSHIP_ID,
tblimptmpaccount_rel.PINSHARINGCATEGORY
from tblimptmpaccount_rel
LEFT OUTER JOIN TBLCUSTCHANNELACCT ON tblcustchannelacct.relationship_ID = tblimptmpaccount_rel.RELATIONSHIP_ID
where tblcustchannelacct.relationship_id is null
and tblimptmpaccount_rel.pinsharingcategory is not null
and tblimptmpaccount_rel.failed is null
)A ;
BEGIN
outRetVal := 0;
open tmpRelAuthCursor;
LOOP
FETCH tmpRelAuthCursor into l_relationship_id, l_pinsharingcategory,l_RELAUTH_ID;
EXIT WHEN tmpRelAuthCursor%NOTFOUND;
update tblimptmpaccount_rel set relationshipauth_id = l_RELAUTH_ID
where relationship_id = l_relationship_id
and pinsharingcategory = l_pinsharingcategory;
END LOOP;
outRetVal := SQL%ROWCOUNT;
END spBL_SetRelationShipAuth;*/
--optimized for mucodec extensive work by tanveer no functionality changed
PROCEDURE spBL_SetRelationShipAuth(
    outRetVal OUT NUMBER )
IS
  l_relauth_seq_count NUMBER;
  l_next_relauth_seq  NUMBER;
  --l_relationship_id VARCHAR2(100);
  --l_pinsharingcategory VARCHAR2(100);
  --l_RELAUTH_ID VARCHAR2(100);
  --    CURSOR tmpRelAuthCursor IS
  --    select A.*,RELATIONSHIP_AUTH_ID.nextval as RELAUTH_ID FROM
  --           ( SELECT DISTINCT
  --            tblimptmpaccount_rel.RELATIONSHIP_ID,
  --            tblimptmpaccount_rel.PINSHARINGCATEGORY
  --            from tblimptmpaccount_rel
  --            LEFT OUTER JOIN TBLCUSTCHANNELACCT ON tblcustchannelacct.relationship_ID = tblimptmpaccount_rel.RELATIONSHIP_ID
  --            where tblcustchannelacct.relationship_id is null
  --            and tblimptmpaccount_rel.pinsharingcategory is not null
  --            and tblimptmpaccount_rel.failed is null
  --           )A ;
BEGIN
  outRetVal := 0;
  --      open tmpRelAuthCursor;
  --
  --LOOP
  --    FETCH tmpRelAuthCursor into l_relationship_id, l_pinsharingcategory,l_RELAUTH_ID;
  --
  --    EXIT WHEN tmpRelAuthCursor%NOTFOUND;
  --
  --          update tblimptmpaccount_rel set relationshipauth_id = l_RELAUTH_ID
  --          where relationship_id = l_relationship_id
  --          and pinsharingcategory = l_pinsharingcategory;
  --
  --    END LOOP;
  SELECT RELATIONSHIP_AUTH_ID.nextval
  INTO l_next_relauth_seq
  FROM dual ;
  --can be negative but in for loop will not execute for negative
  SELECT COUNT(*)-1
  INTO l_relauth_seq_count
  FROM
    ( SELECT DISTINCT tblimptmpaccount_rel.RELATIONSHIP_ID,
      tblimptmpaccount_rel.PINSHARINGCATEGORY
    FROM tblimptmpaccount_rel
    LEFT OUTER JOIN TBLCUSTCHANNELACCT
    ON tblcustchannelacct.relationship_ID        = tblimptmpaccount_rel.RELATIONSHIP_ID
    WHERE tblcustchannelacct.relationship_id    IS NULL
    AND tblimptmpaccount_rel.pinsharingcategory IS NOT NULL
    AND tblimptmpaccount_rel.failed             IS NULL
    )A ;
  MERGE INTO tblimptmpaccount_rel a USING
  (SELECT A.*,
    l_next_relauth_seq+(rownum-1) AS RELAUTH_ID
  FROM
    ( SELECT DISTINCT tblimptmpaccount_rel.RELATIONSHIP_ID,
      tblimptmpaccount_rel.PINSHARINGCATEGORY
    FROM tblimptmpaccount_rel
    LEFT OUTER JOIN TBLCUSTCHANNELACCT
    ON tblcustchannelacct.relationship_ID        = tblimptmpaccount_rel.RELATIONSHIP_ID
    WHERE tblcustchannelacct.relationship_id    IS NULL
    AND tblimptmpaccount_rel.pinsharingcategory IS NOT NULL
    AND tblimptmpaccount_rel.failed             IS NULL
    )A
  ) b ON (a.RELATIONSHIP_ID = b.RELATIONSHIP_ID AND a.pinsharingcategory = b.pinsharingcategory)
WHEN MATCHED THEN
  UPDATE SET a.relationshipauth_id = b.RELAUTH_ID ;
  outRetVal := SQL%ROWCOUNT;
  FOR i IN 1..l_relauth_seq_count
  LOOP
    SELECT RELATIONSHIP_AUTH_ID.nextval INTO l_next_relauth_seq FROM dual;
  END LOOP;
  COMMIT;
END spBL_SetRelationShipAuth;
/*
***************************************************************************
Created By  : Tanveer Ali
Dated       : 31=Mar-2010
Description : To fail any row in temp table with err_code and err_description
with the provided logfeedbackid
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
*/
PROCEDURE spBL_MarkFailed(
    inTableName       IN VARCHAR2,
    inLogFeedBackId   IN VARCHAR2,
    inErr_code        IN VARCHAR2,
    inErr_description IN VARCHAR2,
    outRetVal OUT NUMBER )
IS
  cmd VARCHAR2(4000);
BEGIN
  outRetVal := 0;
  cmd       := 'update ' || intablename || ' set failed = ''1'',err_code = ''' || inerr_code || ''',err_description = ''' || inerr_description || ''' where log_feedback_id = ''' || inlogfeedbackid || '''' ;
  EXECUTE immediate cmd;
  outRetVal := SQL%ROWCOUNT;
END spBL_MarkFailed;
/*
***************************************************************************
Created By  : Tanveer Ali
Dated       : 1=April-2010
Description : To get any temp table in dataset
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
*/
PROCEDURE spBL_GetTempTable(
    inTableName IN VARCHAR2,
    OUTCURSOR OUT REF_CURSOR )
IS
  cmd VARCHAR2(4000);
  tempCur REF_CURSOR;
BEGIN
  cmd := 'select * from ' || intablename ;
  OPEN OUTCURSOR FOR cmd;
END spBL_GetTempTable;
/***************************************************************************
Created By  : Salman Aziz
Dated       : 28-April-2010
Description : Force Pin Generation performed by using
TBLIMPTMPCARDOPS ( new Temp table for operation)
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************/
PROCEDURE spInsertCardForcePinGeneration(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  --'PIN_GEN','1'
  SET TRANSACTION READ WRITE;
  --<ENBD MERGE: AUBY [28-NOV-2011>
  UPDATE TBLIMPTMPCARDOPS
  SET failed        = '02' ,
    err_code        ='138',
    err_description = 'Card already in Production cycle'
  WHERE EXISTS
    (SELECT * FROM tblproduction WHERE relationship_id = relationshipid
    );
  --</ENBD MERGE: AUBY [28-NOV-2011>
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
      (SELECT CARD_RESP.RELATIONSHIPID
      FROM TBLIMPTMPCARDOPS CARD_RESP
      WHERE CARD_RESP.FAILED  IS NULL
      AND CARD_RESP.ACTIONFLAG = '03'
      ) CARD_RESP
    ON CARD_RESP.RELATIONSHIPID = tbldebitcard.relationship_id
    ) Debit_Table
  WHERE NOT EXISTS
    (SELECT *
    FROM tblproduction
    WHERE tblproduction.RELATIONSHIP_ID = Debit_Table.relID
    AND tblproduction.CHANNEL_ID        = Debit_Table.chalID
    );
  outRetVal := SQL%ROWCOUNT;
  COMMIT;
END spInsertCardForcePinGeneration;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 31-May-2010
Description : To assign Primnary PAN incase of supplementary product
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
PROCEDURE spBL_AssignPrimaryPAN(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpcard
  SET PRIMARYCARDNUMBER  = UIPKGIMPORTBL.fnGetPrimaryPAN(RELATIONSHIP_ID)
  WHERE failed          IS NULL
  AND PRIMARYCARDNUMBER IS NULL
  AND productid         IN
    (SELECT product_id FROM tblcfgproduct WHERE issupplementry=1
    )
  AND UIPKGIMPORTBL.fnGetPrimaryPAN(RELATIONSHIP_ID) IS NOT NULL;
  COMMIT;
  outRetVal := SQL%ROWCOUNT;
END spBL_AssignPrimaryPAN;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 31-May-2010
Description : To get Primnary PAN from tblimptmpaccount_rel
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
FUNCTION fnGetPrimaryPAN(
    inRelationshipID VARCHAR2 )
  RETURN VARCHAR2
IS
  tmpVar VARCHAR2(30);
BEGIN
  tmpVar := '';
  SELECT SUBSTR(RELATIONSHIP_ID,1,instr(RELATIONSHIP_ID, '=')-1)
  INTO tmpVar
  FROM
    (SELECT RELATIONSHIP_ID
    FROM tblcustchannelacct
    WHERE channel_id =
      (SELECT tblcfgproductchannels.CHANNEL_ID
      FROM tblcfgproductchannels,
        tblcfgchannel
      WHERE tblcfgproductchannels.CHANNEL_ID       = tblcfgchannel.CHANNELID
      AND tblcfgproductchannels.IS_PRIMARY_CHANNEL = '1'
      AND tblcfgchannel.CARDREQUIRED               ='Y'
      AND tblcfgproductchannels.PRODUCT_ID         = tblcustchannelacct.PRODUCTID
      )
    AND productid IN
      (SELECT product_id FROM tblcfgproduct WHERE issupplementry=0
      )
    AND instr(RELATIONSHIP_ID, '=') > 0
    AND trim(account_id)           IN
      (SELECT trim(account_id)
      FROM tblimptmpaccount_rel
      WHERE RELATIONSHIP_ID = inRelationshipID
      )
    UNION
    SELECT RELATIONSHIP_ID
    FROM tblimptmpaccount_rel
    WHERE channel_id =
      (SELECT tblcfgproductchannels.CHANNEL_ID
      FROM tblcfgproductchannels,
        tblcfgchannel
      WHERE tblcfgproductchannels.CHANNEL_ID       = tblcfgchannel.CHANNELID
      AND tblcfgproductchannels.IS_PRIMARY_CHANNEL = '1'
      AND tblcfgchannel.CARDREQUIRED               ='Y'
      AND tblcfgproductchannels.PRODUCT_ID         = tblimptmpaccount_rel.PRODUCTID
      )
    AND RELATIONSHIP_ID <> inRelationshipID
    AND productid       IN
      (SELECT product_id FROM tblcfgproduct WHERE issupplementry=0
      )
    AND instr(RELATIONSHIP_ID, '=') > 0
    AND trim(account_id)           IN
      (SELECT trim(account_id)
      FROM tblimptmpaccount_rel
      WHERE RELATIONSHIP_ID = inRelationshipID
      )
    )
  WHERE rownum < 2;
  RETURN tmpVar;
END fnGetPrimaryPAN;
/*
***************************************************************************
Created By  : Fahad Ali
Dated       : 31-May-2010
Description : To validate branch
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
FUNCTION fnIsBranchExist(
    inBranchId      IN VARCHAR2,
    inInstitutionID IN VARCHAR2 )
  RETURN VARCHAR2
IS
  tmpCount NUMBER;
  tmpVar   VARCHAR2(10);
BEGIN
  tmpVar := 'false';
  SELECT COUNT(branch_id)
  INTO tmpCount
  FROM tblbranch
  WHERE branch_id   = inBranchId
  AND institutionid = inInstitutionID;
  IF tmpCount       > 0 THEN
    tmpVar         := 'true';
  END IF;
  RETURN tmpVar;
END fnIsBranchExist;
/*
***************************************************************************
Created By  : Rabia Masroor
Dated       : 07-July-2010
Description : Add product service charge
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
1.    Fariha Akhtar  7-JUL-2013    Added SP level logging
***************************************************************************
*/
PROCEDURE spBL_ApplyProductCharge(
    inFormatID VARCHAR2,
    outMsg OUT VARCHAR2,
    outRetVal OUT NUMBER )
IS
  historyID     VARCHAR2(100);
  spName        VARCHAR2(100);
  spDesc        VARCHAR2(500);
  l_currentYear VARCHAR2(100);
  l_nextYear    VARCHAR2(100);
BEGIN
  --only issuance card will be added
  ---Fariha: Setting values of variables
  outRetVal := -1;
  spName    := 'UIPKGIMPORTBL.spBL_ApplyProductCharge';
  spDesc    := 'SP to populate TBLIMPTMPRELCHARGE';
  --Fariha: Fetching max history ID as it is always going to be the one assigned to latest file against given format
  SELECT MAX(history_id)
  INTO historyID
  FROM tblimpformathistory
  WHERE format_id=inFormatID;
  SELECT TO_CHAR(sysdate, 'YYYY') INTO l_currentYear FROM dual;
  SELECT TO_CHAR(sysdate, 'YYYY')+1 INTO l_nextYear FROM dual;
  --Fariha: First Step is to log the start of this SP
  UIPKGIMPORTLOGGING.spInsertImportLoggingABL (historyID, spName,spDesc);
  INSERT
  INTO TBLIMPTMPRELCHARGE
    (
      RELATIONSHIP_ID,
      CHANNEL_ID,
      CARDFEE_ID,
      NEXT_EXECUTION_DATE,
      IS_LOGGED,
      OCCURENCE_NUMBER
    )--, ACTIONFLAG, ACTIONDATE, PROCESSFLAG, PROCESSDATE, INSTITUTIONID, ERR_DESCRIPTION, FAILED, ERR_CODE, LOG_FEEDBACK_ID
  SELECT DISTINCT tblimptmpaccount_rel.relationship_id,
    tblimptmpaccount_rel.channel_id,
    tblcharge.cardfeeid,
    uipkgglobal.fnGetDateTimeInDBFormat(sysdate + NVL(tblcharge.firstexecutionaftercreation,0)),
    '0',
    0
  FROM tblimptmpaccount_rel,
    tblcfgproductservices,
    tblservicechargetype,
    TBLCFGPRODUCTCHARGE,
    tblcharge,
    tblimptmpcard --Added by Rizwan Hussain on 15-Dec-2015
  WHERE tblimptmpaccount_rel.productid    = tblcfgproductservices.productid
  AND tblimptmpaccount_rel.channel_id     = tblcfgproductservices.channelid
  AND tblcfgproductservices.productid     = TBLCFGPRODUCTCHARGE.productid
  AND tblcfgproductservices.servicecode   = tblservicechargetype.servicecode
  AND tblservicechargetype.chargetypecode = tblcharge.feecategory
  AND TBLCFGPRODUCTCHARGE.cardfeeid       = tblcharge.cardfeeid
    --AND tblcfgproductservices.servicecode     = '70' --rizwan commented
  AND tblimptmpaccount_rel.channel_id='0001' ----Fariha: Adding this to avoid entries against multiple channel IDs
    --Added by Rizwan Hussain on 15-Dec-2015
  AND tblcfgproductservices.servicecode =
    (SELECT
      CASE
        WHEN tblimptmpcard.regeneration_type = '10'
        THEN '70'
        WHEN tblimptmpcard.regeneration_type = '11'
        THEN '72'
      END
    FROM tblimptmpcard
    WHERE tblimptmpcard.relationship_id = tblimptmpaccount_rel.relationship_id
    );
  --End added by Rizwan Hussain on 15-Dec-2015
  ---Fariha: ABL Specific Change: Updating Execution Date in case of Annual Charges for Replaced/Renewed Cards so that it is calculated on date of creation of first card
  /* update TBLIMPTMPRELCHARGE
  set next_execution_date =
  (select next_execution_date from tblrelationshipcharges
  inner join tbldebitcard
  on tblrelationshipcharges.relationship_id=tbldebitcard.firstcardnumber
  and tblrelationshipcharges.cardfee_id='303'
  where tbldebitcard.relationship_id=tblimptmprelcharge.relationship_id
  )
  where
  --CIF_PHY_TBLIMPTMPRELCHARGE.rel_charge_Id = relcharge_Id   and
  relationship_id in (select relationship_id from tbldebitcard where regeneration_type != '3') --regeneration Type other than New . See if recarded card needs to be excluded
  and cardfee_id = '303'; */
  UPDATE TBLIMPTMPRELCHARGE
  SET next_execution_date=
    (SELECT l_currentYear
      ||SUBSTR(td1.dataenterdate,5)
      ||'000000'
    FROM tbldebitcard td1
    INNER JOIN tblimptmpcard td2
    ON td1.relationship_id          = td2.firstcardnumber
    WHERE td2.relationship_id       = tblimptmprelcharge.relationship_id
    AND SUBSTR(td1.dataenterdate,5) > TO_CHAR(sysdate,'MMdd')
    ),
    cardfee_id           ='304'
  WHERE relationship_id IN
    (SELECT relationship_id FROM tbldebitcard WHERE regeneration_type != '3'
    ) --regeneration Type other than New . See if recarded card needs to be excluded
  AND cardfee_id = '303';
  --Rizwan Hussain
  UPDATE TBLIMPTMPRELCHARGE
  SET next_execution_date=
    (SELECT
      CASE
        WHEN SUBSTR(td1.dataenterdate,5) <= TO_CHAR(sysdate,'MMdd')
        THEN l_nextYear
        ELSE l_currentyear
      END
      ||SUBSTR(td1.dataenterdate,5)
      ||SUBSTR(TO_CHAR(sysdate,'YYYYMMDDHH24MISS'),-6)
    FROM tbldebitcard td1
    INNER JOIN tblimptmpcard td2
    ON td1.relationship_id = td2.existingcardnumber
    WHERE --substr(td1.dataenterdate,5) <= to_char(sysdate,'MMdd')
      td2.relationship_id            = tblimptmprelcharge.relationship_id
    AND tblimptmprelcharge.cardfee_id='304'
    )
  WHERE TBLIMPTMPRELCHARGE.Cardfee_Id     ='304'
  AND TBLIMPTMPRELCHARGE.Relationship_Id IN
    (SELECT relationship_id FROM tblimptmpcard WHERE failed IS NULL
    );
  --Rizwan Hussain
  UPDATE TBLIMPTMPRELCHARGE
  SET next_execution_date=
    (SELECT l_nextYear
      ||SUBSTR(td1.dataenterdate,5)
      ||'000000'
    FROM tbldebitcard td1
    INNER JOIN tblimptmpcard td2
    ON td1.relationship_id          = td2.firstcardnumber
    WHERE td2.relationship_id       = tblimptmprelcharge.relationship_id
    AND SUBSTR(td1.dataenterdate,5) < TO_CHAR(sysdate,'MMdd')
    )
  WHERE relationship_id IN
    (SELECT relationship_id FROM tbldebitcard WHERE regeneration_type != '3'
    ) --regeneration Type other than New . See if recarded card needs to be excluded
  AND cardfee_id           = '304'
  AND next_execution_date IS NULL;
  ----------------------------Added By Owais For Charges Renew AND Reissue ------------------
  UPDATE TBLIMPTMPRELCHARGE
  SET next_execution_date=
    (SELECT
      CASE
        WHEN TO_DATE(rc.next_execution_date,'yyyymmddhh24miss') > sysdate
        THEN rc.next_execution_date
        ELSE TO_CHAR(ADD_MONTHS(sysdate,12),'YYYYMMDDHH24MISS')
      END AS next_execution_date
    FROM tbldebitcard td1
    INNER JOIN tblimptmpcard td2
    ON td2.existingcardnumber = td1.relationship_id
    INNER JOIN tblrelationshipcharges rc
    ON td1.relationship_id = rc.relationship_id
    WHERE
      --    substr(td1.dataenterdate,5) <= to_char(sysdate,'MMdd')
      td2.relationship_id            = tblimptmprelcharge.relationship_id
    AND tblimptmprelcharge.cardfee_id='304'
    AND td2.regeneration_type       IN ('11','4')
    AND td2.failed                  IS NULL
    AND td2.err_description         IS NULL
    AND rc.cardfee_id               IN ('303','306','304')
    AND rc.next_execution_date      IS NOT NULL
    )
  WHERE TBLIMPTMPRELCHARGE.Cardfee_Id     ='304'
  AND TBLIMPTMPRELCHARGE.Relationship_Id IN
    (SELECT relationship_id FROM tblimptmpcard WHERE failed IS NULL
    ) ;
  ----------------------------Added By Owais For Charges ------------------
  -----------------------Added By Owais For Reissue and Replace if Primary Card Next Execution null
  UPDATE TBLIMPTMPRELCHARGE
  SET next_execution_date=
    (SELECT TO_CHAR(ADD_MONTHS(sysdate,12),'YYYYMMDDHH24MISS')
    FROM tbldebitcard td1
    INNER JOIN tblimptmpcard td2
    ON td2.existingcardnumber = td1.relationship_id
    INNER JOIN tblrelationshipcharges rc
    ON td1.relationship_id = rc.relationship_id
    WHERE
      --    substr(td1.dataenterdate,5) <= to_char(sysdate,'MMdd')
      td2.relationship_id            = tblimptmprelcharge.relationship_id
    AND tblimptmprelcharge.cardfee_id='304'
    AND td2.regeneration_type       IN ('11','4')
    AND td2.failed                  IS NULL
    AND td2.err_description         IS NULL
    AND rc.cardfee_id               IN ('303','306','304')
    AND rc.next_execution_date      IS NULL
    )
  WHERE TBLIMPTMPRELCHARGE.Cardfee_Id     ='304'
  AND TBLIMPTMPRELCHARGE.Relationship_Id IN
    (SELECT relationship_id FROM tblimptmpcard WHERE failed IS NULL
    ) ;
  -----------------------Added By Owais For Reissue and Replace if Primary Card Next Execution null
  -----------------------Added By Owais For Annual Force Fully insert into next execution date if Primary Card Data not exits
  UPDATE TBLIMPTMPRELCHARGE
  SET next_execution_date                 =TO_CHAR(ADD_MONTHS(sysdate,12),'YYYYMMDDHH24MISS')
  WHERE TBLIMPTMPRELCHARGE.Cardfee_Id    IN ('303','304','306')
  AND TBLIMPTMPRELCHARGE.Relationship_Id IN
    (SELECT relationship_id FROM tblimptmpcard WHERE failed IS NULL
    )
  AND TBLIMPTMPRELCHARGE.Next_Execution_Date IS NULL
  AND TBLIMPTMPRELCHARGE.Failed              IS NULL ;
  -----------------------Added By Owais For Annual Force Fully insert into next execution date if Primary Card Data not exits
  -----------------------Added By Owais For Issue Force Fully insert into next execution date if Primary Card Data not exits
  UPDATE TBLIMPTMPRELCHARGE
  SET next_execution_date                 =TO_CHAR(sysdate,'YYYYMMDDHH24MISS')
  WHERE TBLIMPTMPRELCHARGE.Cardfee_Id    IN ('301','302')
  AND TBLIMPTMPRELCHARGE.Relationship_Id IN
    (SELECT relationship_id FROM tblimptmpcard WHERE failed IS NULL
    )
  AND TBLIMPTMPRELCHARGE.Next_Execution_Date IS NULL
  AND TBLIMPTMPRELCHARGE.Failed              IS NULL ;
  -----------------------Added By Owais For Issue Force Fully insert into next execution date if Primary Card Data not exits
  outRetVal := SQL%ROWCOUNT;
  --Fariha: Last Step is to log the end of this SP
  UIPKGIMPORTLOGGING.spUpdateImportLoggingABL (historyID, spName);
  COMMIT;
  --Fariha: In case of any exception, return the oracle error code and message
EXCEPTION
WHEN OTHERS THEN
  BEGIN
    ROLLBACK;
    outRetVal := 1;
    outMsg    := spName||': '|| SQLCODE||' '|| SQLERRM;
  END;
END spBL_ApplyProductCharge;
PROCEDURE spBL_CheckForCustCardExistance(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  --optimized query by tanveer
  UPDATE tblimptmpcard CARD
  SET CARD.ERR_DESCRIPTION = 'Customer ['
    ||CARD.customerid
    ||'] does not Exist For Card.',
    CARD.Failed = '1'
  WHERE rowid  IN
    (SELECT x.rowid
    FROM tblimptmpcard x ,
      (SELECT CARD.customerid FROM tblimptmpcard CARD WHERE CARD.Failed IS NULL
      MINUS
      SELECT CUSTOMER.customerid
      FROM tblimptmpcustomer CUSTOMER
      WHERE CUSTOMER.Failed IS NULL
      AND actionflag         = '01'
      MINUS
      SELECT CUSTOMERID FROM TBLCUSTOMER
      )y
    WHERE x.customerid = y.CUSTOMERID
    );
  outRetVal := SQL%ROWCOUNT;
END spBL_CheckForCustCardExistance;
PROCEDURE spBL_InvalidActionCustAdd(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpcustomer cust
  SET cust.ERR_DESCRIPTION = 'Invalid Action Flag i.e. Customer (01), either card (02, 03) or account (02, 03)',
    cust.err_code          = '200',
    cust.Failed            = '1'
  WHERE cust.actionflag    = '01'
  AND cust.failed         IS NULL
  AND cust.customerid     IN
    (SELECT customer_id
    FROM tblimptmpaccount_rel ACC_REL
    WHERE acc_rel.actionflag IN ('02','03')
    AND acc_rel.failed       IS NULL
    UNION
    SELECT CARD.customerid
    FROM tblimptmpcard CARD
    WHERE CARD.actionflag IN ('02','03')
    AND card.failed       IS NULL
    ) ;
  outRetVal := SQL%ROWCOUNT;
  UPDATE tblimptmpcard card
  SET card.ERR_DESCRIPTION = 'Invalid Action Flag i.e. Customer (01), either card (02, 03) or account (02, 03)',
    card.err_code          = '200',
    card.Failed            = '1'
  WHERE card.customerid   IN
    ( SELECT customerid FROM tblimptmpcustomer cust WHERE cust.err_code = '200'
    )
  AND card.failed IS NULL ;
  UPDATE tblimptmpaccount_rel ACC_REL
  SET ACC_REL.ERR_DESCRIPTION = 'Invalid Action Flag i.e. Customer (01), either card (02, 03) or account (02, 03)',
    ACC_REL.err_code          = '200',
    ACC_REL.Failed            = '1'
  WHERE ACC_REL.customer_id  IN
    ( SELECT customerid FROM tblimptmpcustomer cust WHERE cust.err_code = '200'
    )
  AND ACC_REL.failed IS NULL ;
  UPDATE tblimptmpaccount ACC
  SET ACC.ERR_DESCRIPTION                                       = 'Invalid Action Flag i.e. Customer (01), either card (02, 03) or account (02, 03)',
    ACC.err_code                                                = '200',
    ACC.Failed                                                  = '1'
  WHERE (ACC.account_id,acc.account_type,acc.account_currency) IN
    (SELECT account_id,
      type,
      currency
    FROM tblimptmpaccount_rel ACC_REL
    WHERE ACC_REL.err_code = '200'
    )
  AND ACC.failed IS NULL ;
  UPDATE tblimptmpmultilimitsobj MULLIM
  SET MULLIM.ERR_DESCRIPTION                                             = 'Invalid Action Flag i.e. Customer (01), either card (02, 03) or account (02, 03)',
    MULLIM.err_code                                                      = '200',
    MULLIM.Failed                                                        = '1'
  WHERE (MULLIM.account_id,MULLIM.account_type,MULLIM.account_currency) IN
    (SELECT account_id,
      type,
      currency
    FROM tblimptmpaccount_rel ACC_REL
    WHERE ACC_REL.err_code = '200'
    )
  AND MULLIM.failed IS NULL ;
  COMMIT;
END spBL_InvalidActionCustAdd;
PROCEDURE spBL_InvalidActionCardAdd(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpcard card
  SET card.ERR_DESCRIPTION = 'Invalid Action Flag i.e. Card (01), account (03)',
    card.err_code          = '201',
    card.Failed            = '1'
  WHERE card.actionflag    = '01'
  AND card.failed         IS NULL
  AND card.customerid     IN
    (SELECT customer_id
    FROM tblimptmpaccount_rel ACC_REL
    WHERE acc_rel.actionflag IN ('03')
    AND acc_rel.failed       IS NULL
    ) ;
  outRetVal := SQL%ROWCOUNT;
  UPDATE tblimptmpaccount_rel ACC_REL
  SET ACC_REL.ERR_DESCRIPTION = 'Invalid Action Flag i.e. Card (01), account (03)',
    ACC_REL.err_code          = '201',
    ACC_REL.Failed            = '1'
  WHERE ACC_REL.customer_id  IN
    ( SELECT customerid FROM tblimptmpcard card WHERE card.err_code = '201'
    )
  AND ACC_REL.failed IS NULL ;
  COMMIT;
END spBL_InvalidActionCardAdd;
PROCEDURE spBL_InvalidActionCardDelete(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpcard card
  SET card.ERR_DESCRIPTION = 'Invalid Action Flag i.e. Card (03), account (01)',
    card.err_code          = '202',
    card.Failed            = '1'
  WHERE card.actionflag    = '03'
  AND card.failed         IS NULL
  AND card.customerid     IN
    (SELECT customer_id
    FROM tblimptmpaccount_rel ACC_REL
    WHERE acc_rel.actionflag IN ('01')
    AND acc_rel.failed       IS NULL
    ) ;
  outRetVal := SQL%ROWCOUNT;
  UPDATE tblimptmpaccount_rel ACC_REL
  SET ACC_REL.ERR_DESCRIPTION = 'Invalid Action Flag i.e. Card (03), account (01)',
    ACC_REL.err_code          = '202',
    ACC_REL.Failed            = '1'
  WHERE ACC_REL.customer_id  IN
    ( SELECT customerid FROM tblimptmpcard card WHERE card.err_code = '202'
    )
  AND ACC_REL.failed     IS NULL
  AND acc_rel.channel_id <> '9999' ;
  COMMIT;
END spBL_InvalidActionCardDelete;
PROCEDURE spBL_InvalidActionCustDelete(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimptmpcustomer cust
  SET cust.ERR_DESCRIPTION = 'Invalid Action Flag i.e. Customer (03), either card (01, 02) or account (01, 02)',
    cust.err_code          = '203',
    cust.Failed            = '1'
  WHERE cust.actionflag    = '03'
  AND cust.failed         IS NULL
  AND cust.customerid     IN
    (SELECT customer_id
    FROM tblimptmpaccount_rel ACC_REL
    WHERE acc_rel.actionflag IN ('01','02')
    AND acc_rel.failed       IS NULL
    UNION
    SELECT CARD.customerid
    FROM tblimptmpcard CARD
    WHERE CARD.actionflag IN ('01','02')
    AND card.failed       IS NULL
    ) ;
  outRetVal := SQL%ROWCOUNT;
  UPDATE tblimptmpcard card
  SET card.ERR_DESCRIPTION = 'Invalid Action Flag i.e. Customer (03), either card (01, 02) or account (01, 02)',
    card.err_code          = '203',
    card.Failed            = '1'
  WHERE card.customerid   IN
    ( SELECT customerid FROM tblimptmpcustomer cust WHERE cust.err_code = '203'
    )
  AND card.failed IS NULL ;
  UPDATE tblimptmpaccount_rel ACC_REL
  SET ACC_REL.ERR_DESCRIPTION = 'Invalid Action Flag i.e. Customer (03), either card (01, 02) or account (01, 02)',
    ACC_REL.err_code          = '203',
    ACC_REL.Failed            = '1'
  WHERE ACC_REL.customer_id  IN
    ( SELECT customerid FROM tblimptmpcustomer cust WHERE cust.err_code = '203'
    )
  AND ACC_REL.failed IS NULL ;
  UPDATE tblimptmpaccount ACC
  SET ACC.ERR_DESCRIPTION                                       = 'Invalid Action Flag i.e. Customer (03), either card (01, 02) or account (01, 02)',
    ACC.err_code                                                = '203',
    ACC.Failed                                                  = '1'
  WHERE (ACC.account_id,acc.account_type,acc.account_currency) IN
    (SELECT account_id,
      type,
      currency
    FROM tblimptmpaccount_rel ACC_REL
    WHERE ACC_REL.err_code = '203'
    )
  AND ACC.failed IS NULL ;
  UPDATE tblimptmpmultilimitsobj MULLIM
  SET MULLIM.ERR_DESCRIPTION                                             = 'Invalid Action Flag i.e. Customer (03), either card (01, 02) or account (01, 02)',
    MULLIM.err_code                                                      = '203',
    MULLIM.Failed                                                        = '1'
  WHERE (MULLIM.account_id,MULLIM.account_type,MULLIM.account_currency) IN
    (SELECT account_id,
      type,
      currency
    FROM tblimptmpaccount_rel ACC_REL
    WHERE ACC_REL.err_code = '203'
    )
  AND MULLIM.failed IS NULL ;
  COMMIT;
END spBL_InvalidActionCustDelete;
/*
***************************************************************************
Created By  : Waqas Ahmed
Dated       : 21-June-2011
Description : To validate imd (Multi-Institution)
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
FUNCTION fnIsIMDExist(
    inIMD           IN VARCHAR2,
    inInstitutionID IN VARCHAR2 )
  RETURN VARCHAR2
IS
  tmpCount NUMBER;
  tmpVar   VARCHAR2(10);
BEGIN
  tmpVar := 'false';
  SELECT COUNT(imd)
  INTO tmpCount
  FROM tblcfgimd
  WHERE imd         = inIMD
  AND institutionid = inInstitutionID;
  IF tmpCount       > 0 THEN
    tmpVar         := 'true';
  END IF;
  RETURN tmpVar;
END fnIsIMDExist;
/*
***************************************************************************
Created By  : Waqas Ahmed
Dated       : 21-June-2011
Description : To assign institutionId in tblimplogaccount_rel
***************************************************************************
S#     Who           Date          Change Description
***************************************************************************
***************************************************************************
*/
PROCEDURE spBL_AssignInstitutionAcctRel(
    outRetVal OUT NUMBER )
IS
BEGIN
  outRetVal := 0;
  UPDATE tblimplogaccount_rel
  SET institutionid =
    (SELECT institutionid
    FROM
      (SELECT INSTITUTIONID FROM tblimplogcustomer WHERE institutionid IS NOT NULL
      )
    WHERE rownum = 1
    );
  UPDATE tblimptmpaccount_rel
  SET institutionid =
    (SELECT institutionid
    FROM
      (SELECT INSTITUTIONID FROM tblimplogcustomer WHERE institutionid IS NOT NULL
      )
    WHERE rownum = 1
    );
  outRetVal := SQL%ROWCOUNT;
END spBL_AssignInstitutionAcctRel;
--<ENBD MERGE: AUBY [28-NOV-2011]>
PROCEDURE spBL_AddMeshTranLog(
    outRetVal OUT NUMBER )
IS
BEGIN
  INSERT
  INTO TBLMESHTRANLOG
    (
      MTN_ID,
      MTNTYPE,
      CHEQUENO,
      CHEQUESTATUS,
      MTNDATETIME,
      TRAN_CODE,
      AMOUNT,
      CURR_CODE,
      NETAMOUNT,
      AMOUNTTYPE,
      PARENTTRXLOG_ID,
      MANUALSTATUS,
      MANUALREASON,
      CHEQUE_CLEARANCE_DATE,
      USER_ID,
      MANUALNARRATION,
      PAY_ORDER_NO,
      CARDFEEID,
      RELATIONSHIP_ID,
      PRODUCT_ID,
      GL_ACCOUNT_ID,
      ACCOUNT_ID,
      ACCOUNT_TYPE,
      ACCOUNT_CURRENCY
    )
  SELECT SEQ_MESHTRAN.NEXTVAL,
    MTNTYPE,
    log_feedback_id AS CHEQUENO,
    CHEQUESTATUS,
    MTNDATETIME,
    TRAN_CODE,
    AMOUNT,
    CURR_CODE,
    NETAMOUNT,
    '1',
    PARENTTRXLOG_ID,
    MANUALSTATUS,
    MANUALREASON,
    CHEQUE_CLEARANCE_DATE,
    USER_ID,
    MANUALNARRATION,
    PAY_ORDER_NO,
    CARDFEEID,
    RELATIONSHIP_ID,
    PRODUCT_ID,
    GL_ACCOUNT_ID,
    ACCOUNT_ID,
    ACCOUNT_TYPE,
    ACCOUNT_CURRENCY
  FROM TBLIMPTMPGDCITXNINFO;
  COMMIT;
  UPDATE TBLIMPTMPGDCITXNINFO
  SET mtn_ID =
    (SELECT MTN_ID
    FROM tblmeshtranlog meshtranlog
    WHERE meshtranlog.CHEQUENO = Log_Feedback_ID
    )
  WHERE LOG_Feedback_ID =
    (SELECT meshtranlog.CHEQUENO
    FROM tblmeshtranlog meshtranlog
    WHERE meshtranlog.CHEQUENO = LOG_Feedback_ID
    );
  COMMIT;
  INSERT INTO TBLTSTRANPARAMVALUE
    (TSID,PARAMID,VALUE
    )
  SELECT *
  FROM
    ( SELECT mtn_id, 'ACCOUNTNUMBER',ACCOUNT_ID FROM TBLIMPTMPGDCITXNINFO
    UNION
    SELECT mtn_id, 'ACCOUNTTYPE',ACCOUNT_TYPE FROM TBLIMPTMPGDCITXNINFO
    UNION
    SELECT mtn_id, 'ACCOUNTCURRENCY',ACCOUNT_CURRENCY FROM TBLIMPTMPGDCITXNINFO
    UNION
    SELECT mtn_id,
      'TRANSACTIONCURRENCY',
      TRANSACTION_CURRENCY
    FROM tblimptmpgdcitxninfo
    UNION
    SELECT mtn_id, 'TRANSACTIONAMOUNT', AMount FROM TBLIMPTMPGDCITXNINFO
    UNION
    SELECT mtn_id, 'TRAN_AMT_NARRATION',tran_code FROM TBLIMPTMPGDCITXNINFO
    );
  COMMIT;
  outRetVal:=0;
END spBL_AddMeshTranLog;
--</ENBD MERGE: AUBY [28-NOV-2011]>
END UIPKGIMPORTBL;
/
