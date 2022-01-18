<p align="center"> <img width=210" height="90" src="https://user-images.githubusercontent.com/91494594/144518663-363770d3-6514-47e3-8fbd-f325a4423761.png"> </p>

# T-specs Azure EDW

__Document Inforation__

| Hybrid Reporting Artifact | Data Model |
| --- | --- |
| Hybrid Reporting Summary | Staged Resources Summary Report - Control Estimate |
| Project Name | Azure Hybrid Reporting |
| Document Author | Likhitha Badri |
| Business Owner | |
| Document Version | 1.0 |
| Document Status | Draft |
| Date Released | |

__SUNCOR PROPRIETARY__  
This document is proprietary and confidential to Suncor.  This document shall be treated and safeguarded in the same manner in which the recipient treats its own confidential information of like kind or in accordance with the non-disclosure agreement between the parties.  Neither this document nor any information contained herein may be distributed, disclosed or disseminated in any way to parties outside Suncor without the prior written consent of Suncor as provided in the non-disclosure agreement.

__Document Control Information__

__Document History__

| Sprint No | Requirement / Gap ID | Business scenario | Change Description | Author | Date |
| --- | --- | --- | --- | --- | --- |
| 1.0 | | | | Initial document created | | |

__Reviewers__  
Individuals listed below must review to validate if all required business functionality is captured in the document

| Role | Name | Organization | Review Date |
| --- | --- | --- | --- |
| Sr Specialist Project Controls | Jeissy Valencia Moncada | Suncor Energy | |
| Senior Advisor, Enterprise Data | Rich Chau | Suncor Energy | |
| Manager, Business Intelligence | Jeffrey Lee | Suncor Energy | |

__Approvals__  
The individuals listed below will be final approvers of this document

| Role | Name | Signature | Date |
| --- | --- | --- | --- |
| Senior Advisor, Enterprise Data | Rich Chau | Suncor Energy | |
| Manager, Business Intelligence | Jeffrey Lee | Suncor Energy | |

---

# Table Of Contents
1. Executive Summary  
1.1 Requirement Overview  
1.2 Open Items/Assumptions  
1.3 Risk  
2. Process  
2.1 Data Source  
2.2 Data Sink  
2.3 Process Flow  
3. Data  
3.1. Data Architecture/Model  
3.2 Field Mapping and Transformation  
3.3 Data Pipeline  
3.4 Data Privacy & Security  
3.5 Data Quality / Issues  
3.6 Error Handling  
4. Additional Information  
4.1 Special Data Requirements  
4.2 Alerts, Exceptions, and Thresholds  
4.3 Other Additional Information  
5. Testing Requirements  
5.1 Test Cases  

---

# 1. Executive Summary
## 1.1 Requirement Overview
This data mart contains Control Estimated cost in detail, which will used part of Cost Summary report. At a higher level, it contains cost information on Cost Estimate vendors, unassigned PO, and other related attributes .  The final table created by this data mart is CAL_TA_CS_CONTROL_PRIM, which is consumed by the business users.

## 1.2 Open Items/Assumptions
N/A

## 1.3 Risks
N/A

---

# 2. Process
## 2.1 Data Source


| Source System | Name | Type | Delta/Full Load | Est. Production Volume (Rows) |
| --- | --- | ---- | --- | ---|
| Control Estimate | TBL_CEST_TRADES_WC_PO_BLENDED | Table | Full | 1200 |
| Control Estimate | TBL_CEST_CONTROL_ESTIMATE_SUMMARY | Table | Full | 11000 |
| SAP S4 | PROJ/ I_PROJECT | Table/CDS View | Full | |
| SAP S4 | EKPO/I_PURCHASINGDOCUMENTITEM | Table/CDS View | Full | |
| SharePoint | ZPM_TA_SUP_V | SharePoint csv file | Full | 300 |
| SharePoint | ZPM_INDIRECT_CD | SharePoitn csv file | FUll | 100 |
| SharePoint | ZPM_TRADE_CODE | SharePoitn csv file | FUll | 100 |
| NEWONE | Source name | Table | | |

### 2.1.1 Connection Method

See Job Manager Playbook for column Meanings

<p align="center">Azure Blob Storage </p>

| Environment | Data Sink Type | URL | Secret Name | Linked Service | Authentication Method |
| --- | --- | ---- | --- | --- | --- |
| Development Environment | Raw | https://edwdevarmdlsuw2101.dfs.core.windows.net | staedwraw101 | staedwraw101 | Account Key |
|  | Curated | https://edwdevarmdlsuw2201.dfs.core.windows.net | staedwcur201 | staedwcur201 | Account Key |
|  | EDM | https://edwdevarmdlsuw2301.dfs.core.windows.net | staedwedm301 | staedwedm301 | Account Key |
| QUT Environment | Raw | https://edwqutarmdlsuw2101.dfs.core.windows.net | staedwraw101 | staedwraw101 | Account Key |
|  | Curated | https://edwqutarmdlsuw2201.dfs.core.windows.net | staedwcur201 | staedwcur201 | Account Key |
|  | EDM | https://edwqutarmdlsuw2301.dfs.core.windows.net | staedwedm301 | staedwedm301 | Account Key |
| Production Environment | Raw | | | | Account Key |
| | Curated | | | | Account Key |
| | EDM | | | |  Account Key |

<p align="center"> Control Estimates Database </p>

| Environment | SQL Server Name | Database Name | Authentication | Secret Name | Linked Service |
| --- | --- | ---- | --- | --- | --- |
| Development Environment | sqlprdcgy036 | SQL Authentication | control-estimate-connection-string | sqlServer_sqlAuthentication001 |
| QUT Environment | sqlprdcgy036 | SQL Authentication | control-estimate-connection-string | sqlServer_sqlAuthentication001 |
| Prodcution Environment | | | | | |

<p align="center"> SAP S4 </p>

| Environment | Linked Service | Client ID | User Name | Password | Server | System |
| --- | --- | --- | --- | --- | --- | --- |
| Development Enviornment | sapTable_applicationServer001 | value <br> (sap--s4TableQut—clientid) | value <br> (sap--s4TableQut—username) | [REDACTED] <br> (sap--s4TableQut—password)| value <br> (sap--s4TableQut—servername)| value <br> (sap--s4TableQut—sysnumber) |
| QUT Enviornment | sapTable_applicationServer001 | value <br> (sap--s4TableQut—clientid) | value <br> (sap--s4TableQut—username) | [REDACTED] <br> (sap--s4TableQut—password)| value <br> (sap--s4TableQut—servername)| value <br> (sap--s4TableQut—sysnumber) |
| Production Environment | | | | | | |

<p align="center"> SharePoint </p>

| Environment | Linked Service | Managed Identity Resource | Service Principle ID | Shared Princple Secret | SharePoint Site | SharePoint Path | Tenant ID |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Development Environment | SharePoint | https://vault.azure.net | Value <br> (serviceprincleid) | Value <br> (serviceprinclesecretvalue) | https://suncor.sharepoint.com/sites/EnterpriseDataDARTNon-Production | '/sites/EnterpriseDataDARTNon-Production/Shared Documents/General/DEV/' | Value <br> (tenant-id) |
| QUT Environment | SharePoint | https://vault.azure.net | Value <br> (serviceprincleid) | Value <br> (serviceprinclesecretvalue) | https://suncor.sharepoint.com/sites/EnterpriseDataDARTNon-Production | '/sites/EnterpriseDataDARTNon-Production/Shared Documents/General/DEV/' | Value <br> (tenant-id) |
| Production Environment | | | | | | | |

## 2.2 Data Sink & Storage

![image](https://user-images.githubusercontent.com/91494594/144305472-128dcd9f-2efe-4b7f-9157-0651a1044080.png)

1.	The pipelines read data from the various sources and write it to the Bronze Layer
2.	Bronze to Silver Raw pipelines copy the latest data to Silver Raw, and de-duplicate the data in the process
3.	Data is copied to Synapse via the Silver Raw to Synapse pipelines
The current model ignores Silver Curated and Gold, and moves data straight from Silver Raw to Synapse

Data is stored in the following Blob Storage Locations in each layer:

| Bronze | Silver Raw | Silver Curated | Gold Storage |
| --- | --- | --- | --- |
| controlestimate/DART | raw/controlestimate/DART | Not used | Not used |
| sharepoitnDARt/flatfile | raw/sharepoitnDARt/flatfile | | |
| saps4/PM | raw/saps4/PM | | |

## 2.3 Process Flow

![image](https://user-images.githubusercontent.com/91494594/144305497-06c9713a-bd7f-44e0-bbea-ce4d250830b0.png)

1.	Macro in the Excel template pushes data into on-prem SQL database (Control Estimates) daily.
2.	Projects are created in Sap S4.
3.	The custom tables – Turnaround Event Supervisor, Indirect Code and Trade Code tables, are placed in SharePoint, and used for data maintenance and eliminate any data inconsistency.
4.	Azure pipelines execute, transporting data to Synapse with the appropriate transformations.
5.	Business users can consume data by connecting PowerBI to CAL_TA_CS_CONTROL_PRIM

---

# 3. Data Curation

## 3.1 Data Architecture/Model

### 3.1.1 CAL_TA_CS_CONTROL_PRIM

![image](https://user-images.githubusercontent.com/91494594/144305519-a5fc19cb-0b6b-42e8-9442-916141013327.png)

### 3.1.2 CAL_TA_CS_CE_SUM

![image](https://user-images.githubusercontent.com/91494594/144305538-5fb5032d-6037-4e27-ab62-1d709cb2e566.png)

### 3.1.3 CAL_TA_CS_TRADES_BLENDED

![image](https://user-images.githubusercontent.com/91494594/144305567-50fa8e65-104b-4786-b64b-10c846089d14.png)

## 3.2 Field Mapping and Transformation
| Source | Target Field Name | Datatype |	Field Logic |	Description (Sample Data) |	Entity |
| --- | --- | --- | --- | --- | --- |
| PROJ (SAP S4 HANA) | PSPNR | NVARCHAR(8) | | Project definition (internal) | |
| CEST.TBL_CEST_CONTROL_ESTIMATE_SUMMARY | Date | DATE	| | | |
| CALCULATED | CA_Value_Cat | NVARCHAR(3) | | | |
| CEST.TBL_CEST_TRADES_WC_PO_BLENDED | CA_PO_LINE1 |NVARCHAR(5) | | | |
| CEST.TBL_CEST_CONTROL_ESTIMATE_SUMMARY | MANAGEMENT | | | Management is union into CA_CONTROL_ESTIMATES column | |
| CEST.TBL_CEST_CONTROL_ESTIMATE_SUMMARY | Vendor | VARCHAR(25) | | | |
| CEST.TBL_CEST_CONTROL_ESTIMATE_SUMMARY and CEST.TBL_CEST_TRADES_WC_PO_BLENDED |	MgmtProjectID |	VARCHAR(24) | | | |
| CEST.TBL_CEST_CONTROL_ESTIMATE_SUMMARY	| WBS	| VARCHAR(24)	| | | |
| SAP_ECC.EKPO | NETWR | DECIMAL(13,2) | Sum | Unassigned PO $ | |
| CALCULATED | CA_Val_cat_desc | VARCHAR(20) | | | |
| CEST.TBL_CEST_TRADES_WC_PO_BLENDED | Unassigned_PO | VARCHAR(10) | | | |

Data Lineage Tracking
*Gotta figure out what to do with embeded file; link to it?*

## 3.3 Data Pipeline

__Source to Bronze:__  
Keeping the naming convention as the source system, copy data from the source to the sink (raw zone).  We configure all the details of the data loading once in the raw zone  

Pipeline(s) used:
1.	sqlServer_bronze_sqlAuthentication001_all_full
2.	sharepoint_bronze_file
3.	sapTable_bronze_applicationServer001_all_full
4.  NEW PIPELINE

__Bronze to Silver-Raw:__  
Data copy, cleansing, de-duplication, simple logic update, data validation and bad data capture and format into parquet file.
-	Databricks can be used for de-duplication
-	Format change for csv can be simple. For xml and json the hierarchy need to be flattened by using Databricks
-	Data cleansing and a simple logic update will also happen here (ADF or Databricks)

Pipeline(s) used:  
1. databricks_managedIdentity001_all_incremental  
1.1 Commentary about why the following columns are used for the sources below  
1.2 Business Key Columns for de-duplication:  
    - VU_FIREBAG_1_Indirect
        - Vendor, WBS, MgmtProjectID, Indirect_Code, Phase_Code, Date, Indirect_Hours, Indirect_Rate
    - VU_FIREBAG_1_Trades
        - MgmtProjectID, WBS, Vendor, Date, Phase_Code, Trade_Code,v Trade_Headcount, Trade_Hours, Hiring_Factor
    - VU_FIREBAG_1_Trades_WC_PO_Blended
        - MgmtProjectID, Vendor, Trade_Code, SAP_WorkCenter, Plant
    - VU_FIREBAG_1_Control_Estimate_Summary
        - Vendor, MgmtProjectID, Date

__Silver-Raw to Synapse:__  
Data copy to Synapse  

Pipeline(s) used:  
1.	silverRaw_synapseEdw_full_temporary


__THE FOLLOWING LAYERS ARE CURRENTLY NOT IN USE__  
- Silver-Curated to Gold
- Silver-Raw to Silver-Curated
- Gold to Synapse

## 3.4 Data Privacy & Security

### 3.4.1 Synapse

There are 3 layers of security for DART: DART, DART Restricted, and DART Private
-	DART: Dart is the first layer of security, and where all the final data marts will be.  Everyone will inherently be able to see data marts in this layer
    - Views under this classification:
        - CAL_TA_INDIRECT_VIEW
        - CAL_TA_SR_CONTROL_ESTIMATE_VIEW
-	DART Restricted: Dart Restricted is the second layer of security, and where all the intermediate level data marts will be.  
    - Views under this classification:
        - CAL_TA_SR_TRADES_VIEW
        -	CAL_TR_SR_TRADES_SUMMARY_VIEW
-	DART Private: DART Private is the third layer of security, and where all the source data and low-level data will belong
    - View under this classification:
        - CAL_TA_CE_BLENDED_RATE
        -	TBL_CEST_TRADES_WC_PO_BLENDED
        -	TBL_CEST_CONTROL_ESTIMATE_SUMMARY
        -	PROJ/ I_PROJECT
        - EKPO/I_PURCHASINGDOCUMENTITEM
        -	ZPM_TA_SUP_V
        -	ZPM_INDIRECT_CD
        -	ZPM_TRADE_CODE

### 3.4.2 Blob Storage Folders

ACL (Account control list) and RBAC (role based access control) are used to access the Blob Storage Folders
-	RG-ARM-DEV-EDW-USER-INTERNAL has access to DART except lenel
-	RG-ARM-DEV-EDW-USER-RESTRICTED has access to lenel

### 3.4.3 Data Privacy

- Data doesn't contain any PII information
- Data is classified as iternal

## 3.5 Data Quality / Issues

TBD - to be added by developers

## 3.6 Error Handling

TBD - to be added by developers

---

# 4. Additional Information

## 4.1 Special Data Requirements

TBD - to be added by developers

## 4.2 Alerts, Exceptions, and Thresholds

See the DART Playbook for alerts, exceptions, and thresholds; the policy is the same for all data marts

## 4.3 Other Additional Information

-	Control Estimates is required to run daily (see f-specs)
    -	Triggered at 06:00 Mountain time daily
-	Control Estimate job ID is 1012000
    - Calls Pipelines with IDs ranging from 1012000 to 1012999
- SAP S4 tables are used in Control Estimates (job ID is 1013000)
    - Calls Pipelines with IDs ranging from 1013000 to 1013999
-	Sharepoint tables are used in Control Estimates (job ID is 1001000)
    -	Calls Pipelines with IDs ranging from 1001000 to 1001999

---

# 5. Testing Requirements

## 5.1 Test Cases

| Step No. | Test Case Type | Scenario Title | Steps Performed | Expected Results | Actual Results | Run |
| --- | --- | --- | --- | --- | --- | --- |
| # | Unit Test | Short name for test | Enter the steps required to perform the test | List the results required after running the test | Enter the actual results during final unit testing | Initials |
