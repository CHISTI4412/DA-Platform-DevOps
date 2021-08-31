#Authentication
subscription_id = "25b76ccd-57cc-46a4-9bdc-91ba167a1afe"
# tenant_id = ""
# client_id = ""

#General
environment = "sbx"
region = "westus2"
tags = {
    "ConsumerOrganization1" = ""	
    "ConsumerOrganization2" = ""	
    "SupportStatus" = ""
    "BillingIndicator" = ""	
    "Env" = "SBX"	
    "SuncorKeyIDApplicationName" = ""	
    "DataSensitivity" = ""	
    "Compliance" = ""	
    }

projectname = "abc"
regioncodename = "uw2"

#Databricks 
adbsku = "standard"
adminuser = "admin"
autoshutdownmins = 20
#Key Vault
retention = 7
akvsku = "standard"
rbacenabled = true
#ADLS
accesstier = "Hot"
accounttier = "Standard"
replication = "LRS"
#SAW
    #Data Lake Storage (required by Synapse)
    fsname = "fsname"
    sawaccesstier = "Hot"
    sawaccounttier = "Standard"
    sawreplication = "LRS"
    #Synapse workspace
    sqladminlogin = "sqladmin"
    nodesizefamily = "Memory Optimized"
    nodesize = "4"
    minnodecount = "2"
    maxnodecount = "4"
