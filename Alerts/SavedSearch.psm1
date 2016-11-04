#
#stub code
#
#	<#
#		.SYNOPSIS
#		.DESCRIPTION
#		.PARAMETER
#		.EXAMPLE
#		.NOTES
#		.LINK
#	#>
#	[CmdletBinding()]
#	param
#	(
#
#	)
#	try
#	{
#		$ErrorActionPreference = 'Stop';
#		$Error.Clear();
#	}
#	catch
#	{
#		throw $_.Exception;
#	}
#

Function Get-OMSSavedSearch
{
	<#
		.SYNOPSIS
			Return a collection of SavedSearches from the specified OMS Workspace
		.DESCRIPTION
			This function will return a collection of SavedSearch objects from the OMS workspace. You
			can provide a SubscriptionId, WorkspaceName, ResourceGroupName and optionally a specific 
			SavedSearch to return. You can also pass in a Subscription object and Workspace object, with
			the optional SavedSearchName.
		.PARAMETER SubscriptionId
			The SubscriptId that the OMS Workspace is tied to
		.PARAMETER ResourceGroupName
			The name of the ResourceGroup where the OMS object can be found in the Portak
		.PARAMETER WorkspaceName
			The name of the Workspace you are accessing
		.PARAMETER Subscription
			A subscription object that contains subscriptionId as a property. You can use the Get-AzureRmSubscription
			cmdlet to retrieve this
		.PARAMETER Workspace
			A workspace object that contains the resourceGroupName and Name property of a workspace. You can use the
			Get-AzureRmOperationalInsightsWorkspace, or the Get-OMSWorkspace cmdlet in this module
		.PARAMETER SavedSearchName
			The name of the SavedSearch you wish to get.
		.EXAMPLE
			$Subscription = Get-AzureRmSubscription
			$Workspace = Get-AzureRmOperationalInsightsWorkspace

			Get-OMSSavedSearch -Subscription $Subscription -Workspace $Workspace


			Name              : raxazurebackuperror
			ResourceId        : subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/raxazurebackuperror
			ResourceName      : OMSWorkspace/raxazurebackuperror
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches
			ResourceGroupName : OMS-RG
			Properties        : @{Category=Alert; DisplayName=Microsoft Azure Backup Agent - Generic Error; Query=EventLog="CloudBackup" AND EventLevelName=Error; Version=1}
			ETag              : W/"datetime'2016-09-21T11%3A03%3A40.7767751Z'"

			Name              : raxdblogfilefull
			ResourceId        : subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/raxdblogfilefull
			ResourceName      : OMSWorkspace/raxdblogfilefull
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches
			ResourceGroupName : OMS-RG
			Properties        : @{Category=Alert; DisplayName=Application Log - Event ID 9002: MSSQL Server database log file is full; Query=EventLog=Application AND Source=*MSSQL* AND EventID=9002; Version=1}
			ETag              : W/"datetime'2016-09-21T11%3A03%3A19.1232683Z'"
		.EXAMPLE
			Get-OMSSavedSearch -SubscriptionId $Subscription.SubscriptionId -ResourceGroupName $Workspace.ResourceGroupName -WorkspaceName $Workspace.Name -SavedSearchName raxunexpectedshutdown


			ResourceId        : subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/raxunexpectedshutdown
			ResourceName      : OMSWorkspace/raxunexpectedshutdown
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches
			ResourceGroupName : OMS-RG
			Properties        : @{Category=Alert; DisplayName=System Log - EventID 6008 - Unexpected Shutdown; Query=Type=Event EventLog="System" EventID:6008; Version=1}
			ETag              : W/"datetime'2016-09-21T11%3A03%3A12.4037906Z'"
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
		[Parameter(Mandatory=$True,ParameterSetName='strings',Position=2)]
		[string]$ResourceGroupName,
		[Parameter(Mandatory=$True,ParameterSetName='strings',Position=3)]
		[string]$WorkspaceName,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=1)]
		[object]$Subscription,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=2)]
		[object]$Workspace,
		[Parameter(Mandatory=$False,ParameterSetName='strings')]
		[Parameter(Mandatory=$False,ParameterSetName='objects')]
		[string]$SavedSearchName
	)
	try
	{
		$ErrorActionPreference = 'Stop';
		$Error.Clear();
		if ($Subscription)
		{
			$ResourceId = "/subscriptions/$($Subscription.SubscriptionId)/resourceGroups/$($Workspace.ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($Workspace.Name)/savedSearches";
		}
		else
		{
			$ResourceId = "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/savedSearches";
		}

		if ($SavedSearchName)
		{
			$ResourceId += "/$($SavedSearchName)";
		}

		Get-AzureRmResource -ResourceId $ResourceId -ApiVersion "2015-03-20"
	}
	catch
	{
		throw $_.Exception;
	}
}
Function Get-OMSSavedSearchSchedule
{
	<#
		.SYNOPSIS
		.DESCRIPTION
		.PARAMETER
		.EXAMPLE
		.NOTES
		.LINK
	#>
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$True,ParameterSetName='strings',Position=1)]
		[string]$SubscriptionId,
		[Parameter(Mandatory=$True,ParameterSetName='strings',Position=2)]
		[string]$ResourceGroupName,
		[Parameter(Mandatory=$True,ParameterSetName='strings',Position=3)]
		[string]$WorkspaceName,
		[Parameter(Mandatory=$False,ParameterSetName='strings',Position=4)]
		[string]$SavedSearchName,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=1)]
		[object]$Subscription,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=2)]
		[object]$Workspace,
		[Parameter(Mandatory=$False,ParameterSetName='objects',Position=3)]
		[object]$SavedSearch
	)
	try
	{
		$ErrorActionPreference = 'Stop';
		$Error.Clear();

		if ($Subscription)
		{
			$ResourceId = "/subscriptions/$($Subscription.SubscriptionId)/resourceGroups/$($Workspace.ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($Workspace.Name)/savedSearches/$($SavedSearch.Name)";
		}
		else
		{
			$ResourceId = "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/savedSearches/$($SavedSearchName)/schedules";
		}

		Get-AzureRmResource -ResourceId $ResourceId -ApiVersion "2015-03-20"
	}
	catch
	{
		throw $_.Exception;
	}
}