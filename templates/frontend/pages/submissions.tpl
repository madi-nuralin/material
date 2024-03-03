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
	{*include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.submissions"*}
	

	<div class="my-8 flex rounded-3xl p-6 bg-amber-50 dark:bg-slate-800/60 dark:ring-1 dark:ring-slate-300/10">
		<svg aria-hidden="true" viewBox="0 0 32 32" fill="none" class="h-8 w-8 flex-none [--icon-foreground:theme(colors.amber.900)] [--icon-background:theme(colors.amber.100)]">
			<defs><radialGradient cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" id=":S5:-gradient" gradientTransform="rotate(65.924 1.519 20.92) scale(25.7391)"><stop stop-color="#FDE68A" offset=".08"></stop><stop stop-color="#F59E0B" offset=".837"></stop></radialGradient><radialGradient cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" id=":S5:-gradient-dark" gradientTransform="matrix(0 24.5 -24.5 0 16 5.5)"><stop stop-color="#FDE68A" offset=".08"></stop><stop stop-color="#F59E0B" offset=".837"></stop></radialGradient></defs><g class="dark:hidden"><circle cx="20" cy="20" r="12" fill="url(#:S5:-gradient)"></circle><path d="M3 16c0 7.18 5.82 13 13 13s13-5.82 13-13S23.18 3 16 3 3 8.82 3 16Z" fill-opacity="0.5" class="fill-[var(--icon-background)] stroke-[color:var(--icon-foreground)]" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path><path d="m15.408 16.509-1.04-5.543a1.66 1.66 0 1 1 3.263 0l-1.039 5.543a.602.602 0 0 1-1.184 0Z" class="fill-[var(--icon-foreground)] stroke-[color:var(--icon-foreground)]" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path><path d="M16 23a1 1 0 1 0 0-2 1 1 0 0 0 0 2Z" fill-opacity="0.5" stroke="currentColor" class="fill-[var(--icon-background)] stroke-[color:var(--icon-foreground)]" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path></g><g class="hidden dark:inline"><path fill-rule="evenodd" clip-rule="evenodd" d="M2 16C2 8.268 8.268 2 16 2s14 6.268 14 14-6.268 14-14 14S2 23.732 2 16Zm11.386-4.85a2.66 2.66 0 1 1 5.228 0l-1.039 5.543a1.602 1.602 0 0 1-3.15 0l-1.04-5.543ZM16 20a2 2 0 1 0 0 4 2 2 0 0 0 0-4Z" fill="url(#:S5:-gradient-dark)"></path></g>
		</svg>
		<div class="ml-4 flex-auto">
			<p class="m-0 font-display text-xl text-amber-900 dark:text-amber-500">
				
			</p>
			<div class="prose _mt-2.5 text-amber-800 [--tw-prose-underline:theme(colors.amber.400)] [--tw-prose-background:theme(colors.amber.50)] prose-a:text-amber-900 prose-code:text-amber-900 dark:text-slate-300 dark:[--tw-prose-underline:theme(colors.sky.700)] dark:prose-code:text-slate-300">
				<p>
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
				</p>
			</div>
		</div>
	</div>

	<hr>

	{if $submissionChecklist}
		<div>
			<h2>
				{translate key="about.submissionPreparationChecklist"}
			</h2>
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/submissionChecklist" sectionTitleKey="about.submissionPreparationChecklist"}
			<p>
				{translate key="about.submissionPreparationChecklist.description"}
			</p>
			<ul class="">
				{foreach from=$submissionChecklist item=checklistItem}
					<li class="">
						{$checklistItem}{*.content|nl2br*}
					</li>
				{/foreach}
			</ul>
		</div>
	{/if}

	{if $currentContext->getLocalizedData('authorGuidelines')}
		<hr>

		<div class="author_guidelines" id="authorGuidelines">
			<h2>
				{translate key="about.authorGuidelines"}
			</h2>
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/authorGuidelines" sectionTitleKey="about.authorGuidelines"}
			<p>
				{$currentContext->getLocalizedData('authorGuidelines')}
			</p>
		</div>
	{/if}

	<hr>

	<h2>
		{translate key="section.sections"}
	</h2>

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
		<hr>
		<div class="copyright_notice">
			<h4>
				{translate key="about.copyrightNotice"}
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/authorGuidelines" sectionTitleKey="about.copyrightNotice"}
			</h4>
			{$currentContext->getLocalizedData('copyrightNotice')}
		</div>
	{/if}

	{if $currentContext->getLocalizedData('privacyStatement')}
		<hr>
		<div class="privacy_statement" id="privacyStatement">
			<h2>
				{translate key="about.privacyStatement"}
			</h2>
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="setup/privacy" sectionTitleKey="about.privacyStatement"}
			<p>
				{$currentContext->getLocalizedData('privacyStatement')}
			</p>
		</div>
	{/if}

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
