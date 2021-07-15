{**
 * templates/authorFormOrcid.tpl
 *
 * Copyright (c) 2017-2019 University Library Heidelberg
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Extensions to Submissioni Metadata Author add/edit Form
 *
 *}
{fbvFormSection list="true" title="ORCID" translate=false}
	{if $orcidAccessToken}
		<p>{translate key='plugins.generic.orcidProfile.author.accessTokenStored' orcidAccessScope=$orcidAccessScope} {$orcidAccessExpiresOn|date_format:$datetimeFormatShort}</p>
	{/if}
	{if $orcidAccessDenied}
		<p>{translate key='plugins.generic.orcidProfile.author.accessDenied'} {$orcidAccessDenied|date_format:$datetimeFormatShort}</p>
	{/if}
	{if !$orcidAuthenticated}
		<p>{translate key='plugins.generic.orcidProfile.author.unauthenticated'}</p>
	{/if}
	{fbvElement type="checkbox" label="plugins.generic.orcidProfile.author.requestAuthorization" id="requestOrcidAuthorization" checked=false}
	{if $orcid}
	{fbvElement type="checkbox" label="plugins.generic.orcidProfile.author.deleteORCID" id="deleteOrcid" checked=false}
	{else}
	{fbvElement type="checkbox" label="plugins.generic.orcidProfile.author.deleteORCID" id="deleteOrcid" checked=false disabled=true}
	{/if}
{/fbvFormSection}
<script type="text/javascript">
	$(document).ready(function() {ldelim}
		var orcidInput = $('input[name=orcid]');
		orcidInput.attr('type', 'hidden');
		// make the container div use the whole available space
		orcidInput.parent().removeClass('pkp_helpers_quarter');
		{if $orcid}
		{* Display the ORCID id as an link *}
		{if $orcidAuthenticated}
		var orcidIconSvg = {$orcidIcon|json_encode}
		{else}
		var orcidIconSvg = '';
		{/if}
		var orcidLink = $('<a href="{$orcid}" target="_blank">' + orcidIconSvg + '{$orcid|escape}</a>');
		orcidLink.insertAfter(orcidInput);
		{else}
		$('<span>{translate key='plugins.generic.orcidProfile.author.orcidEmptyNotice'}</span>').insertAfter(orcidInput);
		{/if}
	{rdelim});
</script>
