resourceGroup="rg-logicapps-az-invoice-process"
deploymentName="logicapps-az-invoice-process"
armTemplateFile="./Deployment/deploy.json"
armLogicAppTemplateFile="./Deployment/deploylogicapp.json"

az login

# Resources
az deployment group validate --resource-group $resourceGroup --template-file $armTemplateFile
az deployment group create --name $deploymentName --resource-group $resourceGroup --template-file $armTemplateFile --parameters '{ "suffixName": {"value":"cls0001"} }' 

az resource list -g $resourceGroup --query [*].[name,type] --output tsv

# Logic Apps
az deployment group validate --resource-group $resourceGroup --template-file $armLogicAppTemplateFile
az deployment group create --name $deploymentName --resource-group $resourceGroup --template-file $armLogicAppTemplateFile --parameters '{ "suffixName": {"value":"cls0001"}, "storageaccountname": {"value":"cls0001un36"}, "cosmosDbAccount": {"value":"cosmosdbcls0001un36"}, "formrecognizername": {"value":"cls0001un36fr"}, "Ocp-Apim-Subscription-Key": {"value":""} }' 

az logout