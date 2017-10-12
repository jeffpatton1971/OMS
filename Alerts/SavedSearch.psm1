#
#stub code
#
#	<#
#		.SYNOPSIS
#		.DESCRIPTION
#		.PARAMETER
#		.EXAMPLE
#		.NOTES
#			You will need to be logged into the subscription for this to work.
#			Please use the Login-AzureRmAccount to access the Azure Subscription.
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
#		throw $_;
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


			Name              : MySavedSearch
			ResourceId        : subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/MySavedSearch
			ResourceName      : OMSWorkspace/MySavedSearch
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches
			ResourceGroupName : OMS-RG
			Properties        : @{Category=Alert; DisplayName=Microsoft Azure Backup Agent - Generic Error; Query=EventLog="CloudBackup" AND EventLevelName=Error; Version=1}
			ETag              : W/"datetime'2016-09-21T11%3A03%3A40.7767751Z'"

			Name              : MySavedSearch1
			ResourceId        : subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/MySavedSearch1
			ResourceName      : OMSWorkspace/MySavedSearch1
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches
			ResourceGroupName : OMS-RG
			Properties        : @{Category=Alert; DisplayName=Application Log - Event ID 9002: MSSQL Server database log file is full; Query=EventLog=Application AND Source=*MSSQL* AND EventID=9002; Version=1}
			ETag              : W/"datetime'2016-09-21T11%3A03%3A19.1232683Z'"
		.EXAMPLE
			Get-OMSSavedSearch -SubscriptionId $Subscription.SubscriptionId -ResourceGroupName $Workspace.ResourceGroupName -WorkspaceName $Workspace.Name -SavedSearchName MySavedSearch


			ResourceId        : subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/MySavedSearch
			ResourceName      : OMSWorkspace/MySavedSearch
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

		Get-AzureRmResource -ResourceId $ResourceId -ApiVersion "2015-03-20";
	}
	catch
	{
		throw $_;
	}
}
Function Get-OMSSavedSearchSchedule
{
	<#
		.SYNOPSIS
			Return the schedule for a SavedSearch
		.DESCRIPTION
			This function will return the Schedule for a SavedSearch. A schedule defines the frequency a search is run
			and is commonly used in Alerts.
		.PARAMETER SubscriptionId
			The SubscriptId that the OMS Workspace is tied to
		.PARAMETER ResourceGroupName
			The name of the ResourceGroup where the OMS object can be found in the Portak
		.PARAMETER WorkspaceName
			The name of the Workspace you are accessing
		.PARAMETER SavedSearchName
			The name of the SavedSearch you wish to get.
		.PARAMETER Subscription
			A subscription object that contains subscriptionId as a property. You can use the Get-AzureRmSubscription
			cmdlet to retrieve this
		.PARAMETER Workspace
			A workspace object that contains the resourceGroupName and Name property of a workspace. You can use the
			Get-AzureRmOperationalInsightsWorkspace, or the Get-OMSWorkspace cmdlet in this module
		.PARAMETER SavedSearch
			A savedsearch object that is returned from Get-OMSSavedSearch cmdlet
		.EXAMPLE
			$Subscription = Get-AzureRmSubscription
			$Workspace = Get-AzureRmOperationalInsightsWorkspace

			Get-OMSSavedSearchSchedule -Subscription $Subscription -Workspace $Workspace -SavedSearch $SavedSearch


			ResourceId        : subscriptions/5ae2b1cf-46af-4e6f-88b4-c59e344c7efc/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/MySavedSearch/schedules/MySavedSearch
			ResourceName      : OMSWorkspace/MySavedSearch/MySavedSearch
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches/schedules
			ResourceGroupName : OMS-RG
			Properties        : @{Interval=5; QueryTimeSpan=5; Enabled=True; NearRealTime=False}
			ETag              : W/"datetime'2016-10-19T00%3A42%3A27.3128973Z'"

		.EXAMPLE
			Get-OMSSavedSearchSchedule -SubscriptionId $Subscription.SubscriptionId -ResourceGroupName $Workspace.ResourceGroupName -WorkspaceName $Workspace.Name -SavedSearchName MySavedSearch


			ResourceId        : subscriptions/5ae2b1cf-46af-4e6f-88b4-c59e344c7efc/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/MySavedSearch/schedules/MySavedSearch
			ResourceName      : OMSWorkspace/MySavedSearch/MySavedSearch
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches/schedules
			ResourceGroupName : OMS-RG
			Properties        : @{Interval=5; QueryTimeSpan=5; Enabled=True; NearRealTime=False}
			ETag              : W/"datetime'2016-10-19T00%3A42%3A27.3128973Z'"

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
		[Parameter(Mandatory=$True,ParameterSetName='strings',Position=4)]
		[string]$SavedSearchName,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=1)]
		[object]$Subscription,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=2)]
		[object]$Workspace,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=3)]
		[object]$SavedSearch
	)
	try
	{
		$ErrorActionPreference = 'Stop';
		$Error.Clear();

		if ($Subscription)
		{
			$SavedSearchName = $SavedSearch.ResourceName.Split('/')[1];
			$ResourceId = "/subscriptions/$($Subscription.SubscriptionId)/resourceGroups/$($Workspace.ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($Workspace.Name)/savedSearches/$($SavedSearchName)/schedules/$($SavedSearchName)";
		}
		else
		{
			$ResourceId = "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/savedSearches/$($SavedSearchName)/schedules/$($SavedSearchName)";
		}

		Get-AzureRmResource -ResourceId $ResourceId -ApiVersion "2015-03-20";
	}
	catch
	{
		throw $_;
	}
}
Function Get-OMSSavedSearchAction
{
	<#
		.SYNOPSIS
			Return a collection of Action objects
		.DESCRIPTION
			This function will return a list of Action objects from a provided SavedSearch. These actions can be any number 
			of things, but the most common are Alerts and Webhooks.
		.PARAMETER SubscriptionId
			The SubscriptId that the OMS Workspace is tied to
		.PARAMETER ResourceGroupName
			The name of the ResourceGroup where the OMS object can be found in the Portak
		.PARAMETER WorkspaceName
			The name of the Workspace you are accessing
		.PARAMETER SavedSearchName
			The name of the SavedSearch you wish to get.
		.PARAMETER Subscription
			A subscription object that contains subscriptionId as a property. You can use the Get-AzureRmSubscription
			cmdlet to retrieve this
		.PARAMETER Workspace
			A workspace object that contains the resourceGroupName and Name property of a workspace. You can use the
			Get-AzureRmOperationalInsightsWorkspace, or the Get-OMSWorkspace cmdlet in this module
		.PARAMETER SavedSearch
			A savedsearch object that is returned from Get-OMSSavedSearch cmdlet
		.PARAMETER ActionType
			This is one of two current ActionTypes, Alert or Webhook.
		.EXAMPLE
			$Subscription = Get-AzureRmSubscription
			$Workspace = Get-AzureRmOperationalInsightsWorkspace

			Get-OMSSavedSearchAction -Subscription $Subscription -Workspace $Workspace -SavedSearch $SavedSearch -ActionType Alert


			Name              : MySavedSearch|MySavedSearch|mythreshold
			ResourceId        : subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/MySavedSearch/schedules/MySavedSearch/Actions/mythreshold
			ResourceName      : OMSWorkspace/MySavedSearch/MySavedSearch/mythreshold
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches/schedules/Actions
			ResourceGroupName : OMS-RG
			Properties        : @{Type=Alert; Name=System Log - EventID 6008 - Unexpected Shutdown; Description=This monitor triggers an alert when the system log records an unexpected shutdown event (6008); Threshold=; Severity=Critical; ScheduleTypeSpecified=False; Version=1}
			ETag              : W/"datetime'2016-09-21T11%3A03%3A13.3808626Z'"

		.EXAMPLE
			Get-OMSSavedSearchAction -SubscriptionId $Subscription.SubscriptionId -ResourceGroupName $Workspace.ResourceGroupName -WorkspaceName $Workspace.Name -SavedSearchName MySavedSearch


			Name              : MySavedSearch|MySavedSearch|mythreshold
			ResourceId        : subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/MySavedSearch/schedules/MySavedSearch/Actions/mythreshold
			ResourceName      : OMSWorkspace/MySavedSearch/MySavedSearch/mythreshold
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches/schedules/Actions
			ResourceGroupName : OMS-RG
			Properties        : @{Type=Alert; Name=System Log - EventID 6008 - Unexpected Shutdown; Description=This monitor triggers an alert when the system log records an unexpected shutdown event (6008); Threshold=; Severity=Critical; ScheduleTypeSpecified=False; Version=1}
			ETag              : W/"datetime'2016-09-21T11%3A03%3A13.3808626Z'"

			Name              : MySavedSearch|MySavedSearch|mywebhookaction
			ResourceId        : subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/MySavedSearch/schedules/MySavedSearch/Actions/mywebhookaction
			ResourceName      : OMSWorkspace/MySavedSearch/MySavedSearch/mywebhookaction
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches/schedules/Actions
			ResourceGroupName : OMS-RG
			Properties        : @{Type=Webhook; Name=System Log - EventID 6008 - Unexpected Shutdown; WebhookUri=https://webhook.localhost.com/api/webhooks/; CustomPayload={
								"workspaceId":"#workspaceid",
								"alertName":"#alertrulename",
								"alertValue":"#thresholdvalue",
								"searchInterval":"#searchinterval",
								"IncludeSearchResults":true ,
								"Remediation" : "https://wiki.localhost.com/Azure+Alerts#AzureAlerts-SystemLog-EventID6008-UnexpectedShutdown",
								"Description": "#description",
								"NotificationType":"public"
								}; Version=1}
			ETag              : W/"datetime'2016-09-21T11%3A03%3A14.162071Z'"

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
		[Parameter(Mandatory=$True,ParameterSetName='strings',Position=4)]
		[string]$SavedSearchName,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=1)]
		[object]$Subscription,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=2)]
		[object]$Workspace,
		[Parameter(Mandatory=$True,ParameterSetName='objects',Position=3)]
		[object]$SavedSearch,
		[Parameter(Mandatory=$False,ParameterSetName='strings')]
		[Parameter(Mandatory=$False,ParameterSetName='objects')]
		[ValidateSet('Alert','Webhook')]
		[string]$ActionType
	)
	try
	{
		$ErrorActionPreference = 'Stop';
		$Error.Clear();

		if ($Subscription)
		{
			$SavedSearchName = $SavedSearch.ResourceName.Split('/')[1];
			$ResourceId = "/subscriptions/$($Subscription.SubscriptionId)/resourceGroups/$($Workspace.ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($Workspace.Name)/savedSearches/$($SavedSearchName)/schedules/$($SavedSearchName)/actions";
		}
		else
		{
			$ResourceId = "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/savedSearches/$($SavedSearchName)/schedules/$($SavedSearchName)/actions";
		}

		Get-AzureRmResource -ResourceId $ResourceId -ApiVersion "2015-03-20" |ForEach-Object {$_ |Where-Object {$_.Properties.Type -eq $ActionType}};
	}
	catch
	{
		throw $_;
	}
}
Function New-OMSSavedSearch
{
	<#
		.SYNOPSIS
			Create a new saved search in OMS
		.DESCRIPTION
			This function will create a new SavedSearch in OMS
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
			The name of the SavedSearch you wish to get
		.PARAMETER DisplayName
			The name of the search displayed in OMS
		.PARAMETER Category
			The name of the category to group this search into. Categories are all ad-hoc
		.PARAMETER OmsQuery
			A valid OMS Log Search query
		.PARAMETER Version
			A number representing the version of this search
		.EXAMPLE
			$Subscription = Get-AzureRmSubscription
			$Workspace = Get-AzureRmOperationalInsightsWorkspace

			New-OMSSavedSearch -Subscription $Subscription -Workspace $Workspace -SavedSearchName EventID6008 -DisplayName 'This is the saved search' -Category EVENTIDs -OmsQuery 'Type=Event EventLog="System" EventID:6008' -Version 1


			ResourceId        : subscriptions/64d906f5-cc8b-48c0-84fc-9529834ec29b/resourceGroups/OMS-RG/providers/Microsoft.OperationalInsights/workspaces/OMSWorkspace/savedSearches/eventid6008
			ResourceName      : OMSWorkspace/eventid6008
			ResourceType      : Microsoft.OperationalInsights/workspaces/savedSearches
			ResourceGroupName : OMS-RG
			Properties        : @{Category=EVENTIDs; DisplayName=This is the saved search; Query=Type=Event EventLog="System" EventID:6008; Version=1}
			ETag              : W/"datetime'2016-11-04T21%3A47%3A28.3364814Z'"

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
		[Parameter(Mandatory=$True,ParameterSetName='strings')]
		[Parameter(Mandatory=$True,ParameterSetName='objects')]
		[object]$SavedSearchName,
		[Parameter(Mandatory=$True,ParameterSetName='strings')]
		[Parameter(Mandatory=$True,ParameterSetName='objects')]
		[string]$DisplayName,
		[Parameter(Mandatory=$True,ParameterSetName='strings')]
		[Parameter(Mandatory=$True,ParameterSetName='objects')]
		[string]$Category,
		[Parameter(Mandatory=$True,ParameterSetName='strings')]
		[Parameter(Mandatory=$True,ParameterSetName='objects')]
		[string]$OmsQuery,
		[Parameter(Mandatory=$True,ParameterSetName='strings')]
		[Parameter(Mandatory=$True,ParameterSetName='objects')]
		[int]$Version
	)
	try
	{
		$ErrorActionPreference = 'Stop';
		$Error.Clear();

		$Properties = New-Object -TypeName psobject -Property @{
			Category = $Category
			DisplayName = $DisplayName
			Query = $OmsQuery
			Version = $Version
		}

		if ($Subscription)
		{
			$ResourceId = "/subscriptions/$($Subscription.SubscriptionId)/resourceGroups/$($Workspace.ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($Workspace.Name)/savedSearches/$($SavedSearchName)";
		}
		else
		{
			$ResourceId = "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/savedSearches/$($SavedSearchName)";
		}

		New-AzureRmResource -ResourceId $ResourceId -ApiVersion "2015-03-20" -Properties $Properties -Force;
	}
	catch
	{
		throw $_;
	}
}
Function Set-OMSSavedSearch
{
	<#
		.SYNOPSIS
		.DESCRIPTION
		.PARAMETER
		.EXAMPLE
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
		[Parameter(Mandatory=$True,ParameterSetName='objects')]
		[object]$SavedSearch,
		[Parameter(Mandatory=$True,ParameterSetName='strings')]
		[object]$SavedSearchName,
		[Parameter(Mandatory=$False,ParameterSetName='strings')]
		[Parameter(Mandatory=$False,ParameterSetName='objects')]
		[string]$DisplayName,
		[Parameter(Mandatory=$False,ParameterSetName='strings')]
		[Parameter(Mandatory=$False,ParameterSetName='objects')]
		[string]$Category,
		[Parameter(Mandatory=$False,ParameterSetName='strings')]
		[Parameter(Mandatory=$False,ParameterSetName='objects')]
		[string]$OmsQuery,
		[Parameter(Mandatory=$False,ParameterSetName='strings')]
		[Parameter(Mandatory=$False,ParameterSetName='objects')]
		[int]$Version
	)
	try
	{
		$ErrorActionPreference = 'Stop';
		$Error.Clear();

		if ($SavedSearchName)
		{
			$SavedSearch = Get-OMSSavedSearch -SubscriptionId $SubscriptionId -ResourceGroupName $ResourceGroupName -WorkspaceName $WorkspaceName -SavedSearchName $SavedSearchName;
		}
		
		$CurrentProperties = $SavedSearch.Properties;

		if ($DisplayName){$CurrentProperties.DisplayName = $DisplayName};
		if ($Category){$CurrentProperties.Category = $Category};
		if ($OmsQuery){$CurrentProperties.Query = $OmsQuery};
		if ($Version){$CurrentProperties.Version = $Version};

		if ($Subscription)
		{
			$SavedSearchName = $SavedSearch.ResourceName.Split('/')[1];
			$ResourceId = "/subscriptions/$($Subscription.SubscriptionId)/resourceGroups/$($Workspace.ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($Workspace.Name)/savedSearches/$($SavedSearchName)";
		}
		else
		{
			$ResourceId = "/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($WorkspaceName)/savedSearches/$($SavedSearchName)";
		}

		Set-AzureRmResource -ResourceId $ResourceId -ApiVersion "2015-03-20" -Properties $CurrentProperties -Force;
	}
	catch
	{
		throw $_;
	}
}