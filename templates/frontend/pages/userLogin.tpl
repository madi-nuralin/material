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

<div class="page page_login space-y-2">
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

	<form class="space-y-2" id="login" method="post" action="{$loginUrl}" role="form">
		{csrf}

		{if $error}
			<div class="pkp_form_error text-red">
				{translate key=$error reason=$reason}
			</div>
		{/if}

		<input type="hidden" name="source" value="{$source|default:""|escape}" />

		<fieldset class="space-y-2">
			<div class="username flex">
				<label class="block w-1/2">
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
					class="block w-1/2">
			</div>

			<div class="password flex">
				<label class="block w-1/2">
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
					class="block w-1/2">
			</div>

			<div>
				<a href="{url page="login" op="lostPassword"}">
					{translate key="user.login.forgotPassword"}
				</a>
			</div>

			<div class="remember checkbox">
				<label>
					<input type="checkbox"
						name="remember"
						id="remember"
						value="1"
						checked="$remember">
					<span class="label">
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
				<button class="rounded-full bg-sky-300 py-2 px-4 text-sm font-semibold text-slate-900 hover:bg-sky-200 focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-sky-300/50 active:bg-sky-500" type="submit">
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
