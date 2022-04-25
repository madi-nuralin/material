{**
 * templates/frontend/pages/submissions.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the editorial team.
 *
 * @uses $currentContext Journal|Press The current journal or press
 * @uses $submissionChecklist array List of requirements for submissions
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<div class="page page_submissions container">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.submissions"}
	

	<hr class="my-4">

	<div class="note note-warning">
		{if $sections|@count == 0 || $currentContext->getData('disableSubmissions')}
			{translate key="author.submit.notAccepting"}
		{else}
			{if $isUserLoggedIn}
				{capture assign="newSubmission"}<a href="{url page="submission" op="wizard"}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}
				{capture assign="viewSubmissions"}<a href="{url page="submissions"}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}
					{translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
			{else}
				{capture assign="login"}<a href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>{/capture}
				{capture assign="register"}<a href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.register"}</a>{/capture}
					{translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
			{/if}
		{/if}
	</div>
	
	<hr class="my-4">

	{if $submissionChecklist}
		<div class="">
			<h4>
				{translate key="about.submissionPreparationChecklist"}
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/submissionChecklist" sectionTitleKey="about.submissionPreparationChecklist"}
			</h4>
			{translate key="about.submissionPreparationChecklist.description"}
			<ul class="">
				{foreach from=$submissionChecklist item=checklistItem}
					<li class="">
						{$checklistItem.content|nl2br}
					</li>
				{/foreach}
			</ul>
		</div>
	{/if}

	{if $currentContext->getLocalizedData('authorGuidelines')}
	<hr class="my-4">
	<div class="author_guidelines" id="authorGuidelines">
		<h4>
			{translate key="about.authorGuidelines"}
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/authorGuidelines" sectionTitleKey="about.authorGuidelines"}
		</h4>
		{$currentContext->getLocalizedData('authorGuidelines')}
	</div>
	{/if}

	<hr class="my-4">

	<h4>
		{translate key="section.sections"}
	</h4>
	<ol>
	{foreach from=$sections item="section"}
		{if $section->getLocalizedPolicy()}
			<li class="section_policy">
				<h6 style="text-transform: capitalize !important;">{$section->getLocalizedTitle()|escape}</h6>
				{$section->getLocalizedPolicy()}
				{if $isUserLoggedIn}
					{capture assign="sectionSubmissionUrl"}
						{url page="submission" op="wizard" sectionId=$section->getId()}
					{/capture}
					<p>
						{*translate key="about.onlineSubmissions.submitToSection" name=$section->getLocalizedTitle() url=$sectionSubmissionUrl*}
						<a href="{$sectionSubmissionUrl}" class="btn btn-primary">{translate key="plugins.themes.material.makeSubmission"}</a>
					</p>
				{/if}
			</li>
		{/if}
	{/foreach}
</ol>

	{if $currentContext->getLocalizedData('copyrightNotice')}
		<hr class="my-4">
		<div class="copyright_notice">
			<h4>
				{translate key="about.copyrightNotice"}
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/authorGuidelines" sectionTitleKey="about.copyrightNotice"}
			</h4>
			{$currentContext->getLocalizedData('copyrightNotice')}
		</div>
	{/if}

	{if $currentContext->getLocalizedData('privacyStatement')}
	<hr class="my-4">
	<div class="privacy_statement" id="privacyStatement">
		<h4>
			{translate key="about.privacyStatement"}
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="setup/privacy" sectionTitleKey="about.privacyStatement"}
		</h4>
		{$currentContext->getLocalizedData('privacyStatement')}
	</div>
	{/if}

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
