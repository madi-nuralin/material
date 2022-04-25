{**
 * templates/frontend/pages/userRegister.tpl
 *
 * Copyright (c) 2021 Ьфвш Тгкфдшт
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * User registration form.
 *
 * @uses $primaryLocale string The primary locale for this journal/press
 *}
{include file="frontend/components/header.tpl" pageTitle="user.register"}

<div class="row d-flex justify-content-center">
	<div class="col-lg-5 col-md-12 bg-white">
		<div class="page page_register p-4">

			{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.register"}

			<h1 class="text-center">
				{translate key="user.register"}
			</h1>

			<form class="_cmp_form register needs-validation" id="register" method="post" action="{url op="register"}">
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
								<div class="optin optin-privacy form-group mb-4">
									<input type="checkbox" name="privacyConsent" value="1"{if $privacyConsent} checked="checked"{/if} class="form-check-input" id="privacy_consent">
									{capture assign="privacyUrl"}{url router=$smarty.const.ROUTE_PAGE page="about" op="privacy"}{/capture}
									<label class="form-check-label" for="privacy_consent">
										{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
									</label>
								</div>
							</div>
						{/if}
						{* Ask the user to opt into public email notifications *}
						<div class="fields">
							<div class="optin optin-email form-group mb-4">
								<input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if} class="form-check-input" id="email_consent" />
								<label class="form-check-label" for="email_consent">
									{translate key="user.register.form.emailConsent"}
								</label>
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
							{if $userCanRegisterReviewer > 1}
								<legend>
									{translate key="user.reviewerPrompt"}
								</legend>
								{capture assign="checkboxLocaleKey"}user.reviewerPrompt.userGroup{/capture}
							{else}
								{capture assign="checkboxLocaleKey"}user.reviewerPrompt.optin{/capture}
							{/if}
							<div class="fields">
								<div id="reviewerOptinGroup" class="optin form-group mb-4">
									{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
										{if $userGroup->getPermitSelfRegistration()}
											{assign var="userGroupId" value=$userGroup->getId()}
											<input type="checkbox" name="reviewerGroup[{$userGroupId}]" value="1"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if} class="form-check-input" id="reviewerGroup[{$userGroupId}]">
											
											<label class="form-check-label" for="reviewerGroup[{$userGroupId}]">
												{translate key=$checkboxLocaleKey userGroup=$userGroup->getLocalizedName()}
											</label>
										{/if}
									{/foreach}
								</div>
								<div id="reviewerInterests" class="reviewer_interests mb-4 align-items-center">
									<label class="form-check-label label text-sm-end text-start" for="interests">
										{translate key="user.interests"}
									</label> 
									<div class="">
										<input type="text" name="interests" id="interests" value="{$interests|escape}" class="form-control">
									</div>
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
							<label>
								<span class="label">
									{translate key="user.register.noContextReviewerInterests"}
								</span>
								<input type="text" name="interests" id="interests" value="{$interests|escape}">
							</label>
						</div>
					</div>

					{* Require the user to agree to the terms of the privacy policy *}
					{if $siteWidePrivacyStatement}
						<div class="fields">
							<div class="optin optin-privacy">
								<label>
									<input type="checkbox" name="privacyConsent[{$smarty.const.CONTEXT_ID_NONE}]" id="privacyConsent[{$smarty.const.CONTEXT_ID_NONE}]" value="1"{if $privacyConsent[$smarty.const.CONTEXT_ID_NONE]} checked="checked"{/if}>
									{capture assign="privacyUrl"}{url router=$smarty.const.ROUTE_PAGE page="about" op="privacy"}{/capture}
									{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
								</label>
							</div>
						</div>
					{/if}

					{* Ask the user to opt into public email notifications *}
					<div class="fields">
						<div class="optin optin-email">
							<label>
								<input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
								{translate key="user.register.form.emailConsent"}
							</label>
						</div>
					</div>
				{/if}

				{* recaptcha spam blocker *}
				{if $reCaptchaHtml}
					<fieldset class="recaptcha_wrapper">
						<div class="fields">
							<div class="recaptcha">
								{$reCaptchaHtml}
							</div>
						</div>
					</fieldset>
				{/if}

				<div class="d-flex flex-column align-items-center justify-content-center">
					<button class="btn btn-primary btn-lg col-12 mb-4" type="submit">
						{translate key="user.register"}
					</button>

					{capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
					<a href="{url page="login" source=$rolesProfileUrl}" class="login btn btn-lg btn-light text-dark col-12 mb-4">{translate key="user.login"}</a>
				</div>
			</form>

		</div><!-- .page -->
	</div>
</div>

{include file="frontend/components/footer.tpl"}
