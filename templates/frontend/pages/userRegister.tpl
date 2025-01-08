{**
 * templates/frontend/pages/userRegister.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * User registration form.
 *
 * @uses $primaryLocale string The primary locale for this journal/press
 *}
{include file="frontend/components/header.tpl" pageTitle="user.register"}

<div>
	{include file="frontend/components/logo.tpl" small=false}
</div>

<div class="w-full sm:max-w-md mt-6 px-6 py-4 bg-white shadow-md overflow-hidden sm:rounded-lg dark:bg-gray-700 page page_register">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.register"}
	<h1 class="text-2xl">
		{translate key="user.register"}
	</h1>

	<p>
		{translate key="common.requiredField"}
	</p>

	<form class="cmp_form register space-y-4" id="register" method="post" action="{url op="register"}" role="form">
		{csrf}

		{if $source}
			<input type="hidden" name="source" value="{$source|escape}" />
		{/if}

		{include file="common/formErrors.tpl"}

		{include file="frontend/components/registrationForm.tpl"}

		{* When a user is registering with a specific journal *}
		{if $currentContext}

			<fieldset class="consent">
				{if $currentContext->getData('privacyStatement')}
					{* Require the user to agree to the terms of the privacy policy *}
					<legend class="pkp_screen_reader">{translate key="user.register.form.privacyConsentLabel"}</legend>
					<div class="fields">
						<div class="optin optin-privacy">
							{material_label class="flex"}
								<span>
									{if $privacyConsent}
										{material_checkbox name="privacyConsent"
											value="1"
											checked="checked"}
									{else}
										{material_checkbox name="privacyConsent"
											value="1"}
									{/if}
								</span>
								<span class="ml-2">
									{capture assign="privacyUrl"}
										{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}
									{/capture}
									{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
								</span>
							{/material_label}
						</div>
					</div>
				{/if}
				{* Ask the user to opt into public email notifications *}
				<div class="fields">
					<div class="optin optin-email">
						{material_label class="flex"}
							<span>
								{if $emailConsent}
									{material_checkbox name="emailConsent"
										value="1"
										checked="checked"}
								{else}
									{material_checkbox name="emailConsent"
										value="1"}
								{/if}
							</span>
							<span class="ml-2">
								{translate key="user.register.form.emailConsent"}
							</span>
						{/material_label}
					</div>
				</div>
			</fieldset>

			{* Allow the user to sign up as a reviewer *}
			{assign var=contextId value=$currentContext->getId()}
			{assign var=userCanRegisterReviewer value=0}
			{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
				{if $userGroup->getPermitSelfRegistration()}
					{assign var=userCanRegisterReviewer value=$userCanRegisterReviewer+1}
				{/if}
			{/foreach}
			{if $userCanRegisterReviewer}
				<fieldset class="reviewer">
					<legend>
						{translate key="user.reviewerPrompt"}
					</legend>
					{if $userCanRegisterReviewer > 1}
						{capture assign="checkboxLocaleKey"}user.reviewerPrompt.userGroup{/capture}
					{else}
						{capture assign="checkboxLocaleKey"}user.reviewerPrompt.optin{/capture}
					{/if}
					<div class="fields">
						<div id="reviewerOptinGroup" class="optin">
							{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
								{if $userGroup->getPermitSelfRegistration()}
									{material_label class="flex"}
										{assign var="userGroupId" value=$userGroup->getId()}
										<span>
											{if in_array($userGroupId, $userGroupIds)} 
												{material_checkbox
													name="reviewerGroup[{$userGroupId}]"
													value="1"
													checked="checked"}
											{else}
												{material_checkbox
													name="reviewerGroup[{$userGroupId}]"
													value="1"}
											{/if}
										</span>
										<span class="ml-2">
											{translate key=$checkboxLocaleKey userGroup=$userGroup->getLocalizedName()}
										</span>
									{/material_label}
								{/if}
							{/foreach}
						</div>
						<div id="reviewerInterests" class="reviewer_interests">
							{material_label for="interests"}
								{translate key="user.interests"}
							{/material_label}
							{material_input type="text"
								name="interests"
								id="interests"
								value="{$interests|default:''|escape}"
								class="mt-1 block w-full"}
						</div>
					</div>
				</fieldset>
			{/if}
		{/if}

		{include file="frontend/components/registrationFormContexts.tpl"}

		{* When a user is registering for no specific journal, allow them to
		   enter their reviewer interests *}
		{if !$currentContext}
			<div class="fields">
				<div class="reviewer_nocontext_interests">
					{material_label}
						{translate key="user.register.noContextReviewerInterests"}
					{/material_label}
					{material_input type="text"
						name="interests"
						id="interests"
						value="{$interests|default:''|escape}"
						class="mt-1 block w-full"}
				</div>
			</div>

			{* Require the user to agree to the terms of the privacy policy *}
			{if $siteWidePrivacyStatement}
				<div class="fields">
					<div class="optin optin-privacy">
						<label>
							{if $privacyConsent[\PKP\core\PKPApplication::CONTEXT_ID_NONE]} 
								{material_checkbox
									name="privacyConsent[{\PKP\core\PKPApplication::CONTEXT_ID_NONE}]"
									id="privacyConsent[{\PKP\core\PKPApplication::CONTEXT_ID_NONE}]"
									value="1"
									checked="checked"}
							{else}
								{material_checkbox
									name="privacyConsent[{\PKP\core\PKPApplication::CONTEXT_ID_NONE}]"
									id="privacyConsent[{\PKP\core\PKPApplication::CONTEXT_ID_NONE}]"
									value="1"}
							{/if}
							{capture assign="privacyUrl"}{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
							{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
						</label>
					</div>
				</div>
			{/if}

			{* Ask the user to opt into public email notifications *}
			<div class="fields mt-2">
				<div class="optin optin-email">
					{material_label class="flex"}
						<span>
							{if $emailConsent} 
								{material_checkbox name="emailConsent"
									value="1"
									checked="checked"}
							{else}
								{material_checkbox name="emailConsent"
									value="1"}
							{/if}
						</span>
						<span class="ml-2">
							{translate key="user.register.form.emailConsent"}
						</span>
					{/material_label}
				</div>
			</div>
		{/if}

		{* recaptcha spam blocker *}
		{if $recaptchaPublicKey}
			<fieldset class="recaptcha_wrapper">
				<div class="fields">
					<div class="recaptcha">
						<div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}">
						</div><label for="g-recaptcha-response" style="display:none;" hidden>Recaptcha response</label>
					</div>
				</div>
			</fieldset>
		{/if}

		<div class="buttons space-x-2">
			{material_button_primary type="submit"}
				{translate key="user.register"}
			{/material_button_primary}

			{capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
			<a href="{url page="login" source=$rolesProfileUrl}" class="login inline-block rounded-full bg-slate-800 py-2 px-4 text-sm font-medium text-white hover:bg-slate-700 focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-white/50 active:text-slate-400">{translate key="user.login"}</a>
		</div>
	</form>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}

