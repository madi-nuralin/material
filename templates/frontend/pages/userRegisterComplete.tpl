{**
 * templates/frontend/pages/userRegisterComplete.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief A landing page displayed to users upon successful registration
 *}
{include file="frontend/components/header.tpl"}
{assign var="baseColour2" value=$activeTheme->getOption('baseColour2')}
<div class="page page_register_complete">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$pageTitle}
	<h1>
		{translate key=$pageTitle}
	</h1>
	<p>
		{translate key="user.login.registrationComplete.instructions"}
	</p>
	<ul class="registration_complete_actions">
		{if array_intersect(array(\PKP\security\Role::ROLE_ID_MANAGER, \PKP\security\Role::ROLE_ID_SUB_EDITOR, \PKP\security\Role::ROLE_ID_ASSISTANT, \PKP\security\Role::ROLE_ID_REVIEWER), (array)$userRoles)}
			<li class="view_submissions">
				<a href="{url page="submissions"}">
					{translate key="user.login.registrationComplete.manageSubmissions"}
				</a>
			</li>
		{/if}
		{if $currentContext}
			<li class="new_submission">
				<a href="{url page="submission"}">
					{translate key="user.login.registrationComplete.newSubmission"}
				</a>
			</li>
		{/if}
		<li class="edit_profile">
			<a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="user" op="profile"}">
				{translate key="user.editMyProfile"}
			</a>
		</li>
		<li class="browse">
			<a href="{url page="index"}">
				{translate key="user.login.registrationComplete.continueBrowsing"}
			</a>
		</li>
	</ul>
</div>

{include file="frontend/components/footer.tpl"}
