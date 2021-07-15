{**
 * templates/settingsForm.tpl
 *
 * Copyright (c) 2015-2019 University of Pittsburgh
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Copyright (c) 2017-2019 University Library Heidelberg
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * ORCID Profile plugin settings
 *
 *}

<script>
	$(function() {ldelim}
		// Attach the form handler.
		$('#orcidProfileSettingsForm').pkpHandler('$.pkp.controllers.form.AjaxFormHandler');
	{rdelim});
</script>

<form class="pkp_form" id="orcidProfileSettingsForm" method="post" action="{url router=$smarty.const.ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="settings" save=true}">
	<div id="orcidProfileSettings">

		<p id="description">
			{translate key="plugins.generic.orcidProfile.manager.settings.description" }
		</p>

		{csrf}
		{include file="controllers/notification/inPlaceNotification.tpl" notificationId="orcidProfileSettingsFormNotification"}
		{fbvFormArea id="orcidApiSettings" title="plugins.generic.orcidProfile.manager.settings.title"}
			{fbvFormSection}
				{if $globallyConfigured}
				<p>
					{translate key="plugins.generic.orcidProfile.manager.settings.description.globallyconfigured"}
				</p>
				{/if}
				{fbvElement id="orcidProfileAPIPath" type="select" translate="true" from=$orcidApiUrls selected=$orcidProfileAPIPath required="true" label="plugins.generic.orcidProfile.manager.settings.orcidProfileAPIPath" disabled=$globallyConfigured}
				{fbvElement type="text" id="orcidClientId" value=$orcidClientId required="true" label="plugins.generic.orcidProfile.manager.settings.orcidClientId" maxlength="40" size=$fbvStyles.size.MEDIUM disabled=$globallyConfigured}
				{if $globallyConfigured}
					<p>
						{translate key="plugins.generic.orcidProfile.manager.settings.orcidClientSecret"}: <i>{translate key="plugins.generic.orcidProfile.manager.settings.hidden"}</i>
					</p>
				{else}
					{fbvElement type="text" id="orcidClientSecret" value=$orcidClientSecret required="true" label="plugins.generic.orcidProfile.manager.settings.orcidClientSecret" maxlength="40" size=$fbvStyles.size.MEDIUM disabled=$globallyConfigured}
				{/if}
			{/fbvFormSection}
		{/fbvFormArea}
		{fbvFormSection for="sendMailToAuthorsOnPublication" title="plugins.generic.orcidProfile.manager.settings.mailSectionTitle" list="true"}
			{fbvElement type="checkbox" name="sendMailToAuthorsOnPublication" label="plugins.generic.orcidProfile.manager.settings.sendMailToAuthorsOnPublication" id="sendMailToAuthorsOnPublication" checked=$sendMailToAuthorsOnPublication}
		{/fbvFormSection}
		{fbvFormSection for="logLevel" title="plugins.generic.orcidProfile.manager.settings.logSectionTitle"}
			<p class="pkp_help">{translate key="plugins.generic.orcidProfile.manager.settings.logLevel.help"}</p>
			{fbvElement id="logLevel" name="logLevel" type="select" from=$logLevelOptions selected=$logLevel}
		{/fbvFormSection}
		{fbvFormButtons}
		<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
	</div>
</form>
