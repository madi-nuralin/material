{**
 * templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2000-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}
{assign var="baseColour2" value=$activeTheme->getOption('baseColour2')}

<div>
	{include file="frontend/components/local/logo.tpl" small=false}
</div>

<div class="w-full sm:max-w-md mt-6 px-6 py-4 bg-white shadow-md overflow-hidden sm:rounded-lg dark:bg-gray-700 page page_login space-y-2">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}
	<h1 class="text-2xl">
		{translate key="user.login"}
	</h1>

	<p>
		{translate key="common.requiredField"}
	</p>
	{* A login message may be displayed if the user was redireceted to the
	   login page from another request. Examples include if login is required
	   before dowloading a file. *}
	{if $loginMessage}
		<p>
			{translate key=$loginMessage}
		</p>
	{/if}

	<form id="login" method="post" action="{$loginUrl}" role="form">
		{csrf}

		{if $error}
			<div class="pkp_form_error font-medium text-red-600 mb-2">
				{translate key=$error reason=$reason}
			</div>
		{/if}

		<input type="hidden" name="source" value="{$source|default:""|escape}" />

		<fieldset class="space-y-4">
			<div class="username">
				<label class="block font-medium text-sm text-gray-700 dark:text-gray-400">
					{translate key="user.usernameOrEmail"}
					<span class="required" aria-hidden="true">*</span>
				</label>
				<input type="text"
					name="username"
					id="username"
					value="{$username|default:""|escape}"
					maxlength="32"
					required
					aria-required="true"
					autocomplete="username"
					class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
			</div>

			<div class="password">
				<label class="block font-medium text-sm text-gray-700 dark:text-gray-400">
					{translate key="user.password"}
					<span class="required" aria-hidden="true">*</span>
				</label>
				<input type="password"
					name="password"
					id="password"
					value="{$password|default:""|escape}"
					password="true"
					maxlength="32"
					required
					aria-required="true"
					autocomplete="current-password"
					class="border-gray-300 focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white mt-1 block w-full">
			</div>

			<div>
				<a href="{url page="login" op="lostPassword"}">
					{translate key="user.login.forgotPassword"}
				</a>
			</div>

			<div class="remember checkbox">
				<label class="flex items-center">
					<input type="checkbox"
						name="remember"
						id="remember"
						value="1"
						checked="$remember"
						class="rounded border-gray-300 text-{$baseColour2}-600 shadow-sm focus:border-{$baseColour2}-300 focus:ring focus:ring-{$baseColour2}-200 focus:ring-opacity-50">
					<span class="label ml-2 text-sm text-gray-600">
						{translate key="user.login.rememberUsernameAndPassword"}
					</span>
				</label>
			</div>

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
				<button class="rounded-full bg-{$baseColour2}-300 py-2 px-4 text-sm font-semibold text-slate-900 hover:bg-{$baseColour2}-200 focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-{$baseColour2}-300/50 active:bg-{$baseColour2}-500" type="submit">
					{translate key="user.login"}
				</button>

				{if !$disableUserReg}
					{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
					<a href="{$registerUrl}" class="register">
						{translate key="user.login.registerNewAccount"}
					</a>
				{/if}
			</div>
		</fieldset>
	</form>
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
