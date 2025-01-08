{**
 * templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Password reset form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<div>
	{include file="frontend/components/logo.tpl" small=false}
</div>

<div class="w-full sm:max-w-md mt-6 px-6 py-4 bg-white shadow-md overflow-hidden sm:rounded-lg dark:bg-gray-700 page page_login space-y-2">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login.resetPassword"}
	<h1>
		{translate key="user.login.resetPassword"}
	</h1>

	<p>{translate key="user.login.resetPasswordInstructions"}</p>

	<form class="_cmp_form _lost_password" id="lostPasswordForm" action="{url page="login" op="requestResetPassword"}" method="post">
		{csrf}
		{if $error}
			<div class="pkp_form_error text-danger">
				{translate key=$error}
			</div>
		{/if}

		<div class="fields">
			<div class="_email row mb-4 align-items-center">
				{material_label for="email"}
					{translate key="user.login.registeredEmail"}
					<span class="required" aria-hidden="true">*</span>
				{/material_label}

				{material_input type="email"
					name="email"
					id="email"
					value="{$email|escape}"
					required="true"
					aria-required="true"
					class="mt-1 block w-full"}
			</div>
			<div class="buttons space-x-2">
				{material_button_primary type="submit"}
					{translate key="user.login.resetPassword"}
				{/material_button_primary}

				{if !$disableUserReg}
					{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
					<a href="{$registerUrl}" class="login inline-block rounded-full bg-slate-800 py-2 px-4 text-sm font-medium text-white hover:bg-slate-700 focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-white/50 active:text-slate-400">
						{translate key="user.login.registerNewAccount"}
					</a>
				{/if}
			</div>
		</div>

	</form>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
