Function Get-OMSWorkspace
{
	<#
		.SYNOPSIS
			Return an OMS Workspace object
		.DESCRIPTION
			This function will return an OMS Workspace object from Azure.
		.PARAMETER SubscriptionId
			The SubscriptId that the OMS Workspace is tied to
		.PARAMETER Subscription
			A subscription object that contains subscriptionId as a property. You can use the Get-AzureRmSubscription
			cmdlet to retrieve this
		.PARAMETER ResourceGroupName
			The name of the ResourceGroup where the OMS object can be found in the Portak
		.PARAMETER WorkspaceName
			The name of the Workspace you are accessing
		.EXAMPLE
			$Subscription = Get-AzureRmSubscription

			Get-OMSWorkspace -SubscriptionId $Subscription.SubscriptionId -ResourceGroupName OMS-RG

			Name              : OMSWorkspace
			ResourceId        : /subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourcegroups/OMS-RG/providers/microsoft.operationalinsights/workspaces/OMSWorkspace
			ResourceName      : OMSWorkspace
			ResourceType      : microsoft.operationalinsights/workspaces
			ResourceGroupName : OMS-RG
			Location          : West Europe
			SubscriptionId    : 64d906f5-cc8b-48c0-84fc-9529834ec29b
			Tags              : {buildBy, buildDate, group}
			Properties        : @{source=Azure; customerId=1e3b2573-1cd8-4f5c-a48b-35925729493b; portalUrl=https://weu.mms.microsoft.com/Account?tenant=cf8bde16-8346-4bb5-b1a5-c42f187dbe9c&resource=%2fsubscriptions%2f64d906f5-cc8b-48c0-84fc-9529834ec29b%2fresourcegroups%2fOMS-RG
								%2fproviders%2fmicrosoft.operationalinsights%2fworkspaces%2fOMSWorkspace; provisioningState=Succeeded; sku=; retentionInDays=0}
		.EXAMPLE
			Get-OMSWorkspace -Subscription $Subscription -ResourceGroupName OMS-RG -WorkspaceName OMSWorkspace

			Name              : OMSWorkspace
			ResourceId        : /subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourcegroups/OMS-RG/providers/microsoft.operationalinsights/workspaces/OMSWorkspace
			ResourceName      : OMSWorkspace
			ResourceType      : microsoft.operationalinsights/workspaces
			ResourceGroupName : OMS-RG
			Location          : West Europe
			SubscriptionId    : 64d906f5-cc8b-48c0-84fc-9529834ec29b
			Tags              : {buildBy, buildDate, group}
			Properties        : @{source=Azure; customerId=1e3b2573-1cd8-4f5c-a48b-35925729493b; portalUrl=https://weu.mms.microsoft.com/Account?tenant=cf8bde16-8346-4bb5-b1a5-c42f187dbe9c&resource=%2fsubscriptions%2f64d906f5-cc8b-48c0-84fc-9529834ec29b%2fresourcegroups%2fOMS-RG
								%2fproviders%2fmicrosoft.operationalinsights%2fworkspaces%2fOMSWorkspace; provisioningState=Succeeded; sku=; retentionInDays=0}
		.NOTES
			You will need to be logged into the subscription for this to work.
			Please use the Login-AzureRmAccount to access the Azure Subscription.
		.LINK
	#>
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$True,ParameterSetName='strings',Position=1)]
		[string]$SubscriptionId,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=1)]
		[object]$Subscription,
		[Parameter(Mandatory=$True,ParameterSetName='strings')]
		[Parameter(Mandatory=$True,ParameterSetName='objects')]
		[string]$ResourceGroupName,
		[Parameter(Mandatory=$False,ParameterSetName='strings')]
		[Parameter(Mandatory=$False,ParameterSetName='objects')]
		[string]$WorkspaceName
	)
	try
	{
		$ErrorActionPreference = 'Stop';
		$Error.Clear();

		If ($Subscription)
		{
			$ResourceId = "/subscriptions/$($Subscription.SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces";
		}
		else
		{
			$ResourceId = "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces";
		}

		if ($WorkspaceName)
		{
			$ResourceId += "/$($WorkspaceName)";
		}
		Get-AzureRmResource -ResourceId $ResourceId -ApiVersion "2015-03-20"
	}
	catch
	{
		throw $_.Exception;
	}
}