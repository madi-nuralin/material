{**
 * templates/openidLogin.tpl
 *
 * Copyright (c) 2020 Leibniz Institute for Psychology Information (https://leibniz-psychology.org/)
 * Copyright (c) 2024 Simon Fraser University
 * Copyright (c) 2024 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * Display the OpenID sign in page
 *}

{include file="frontend/components/header.tpl" pageTitle='plugins.generic.openid.select.provider'}

<div>
	{include file="frontend/components/logo.tpl" small=false}
</div>

<div class="w-full sm:max-w-md mt-6 px-6 py-4 bg-white shadow-md overflow-hidden sm:rounded-lg dark:bg-gray-700 page page_login space-y-2">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey='plugins.generic.openid.select.provider'}
	<h1 class="text-2xl">
		{translate key='plugins.generic.openid.select.provider'}
	</h1>

	{if $loginMessage}
		<div>
			<p>
				{translate key=$loginMessage}
			</p>
		</div>
	{/if}
	{if $openidError}
		<div class="my-6 flex rounded-3xl p-6 bg-red-50 dark:bg-slate-800/60 dark:ring-1 dark:ring-slate-300/10">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" class="text-red-900 h-6 w-6 flex-none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>

			<div class="ml-4 flex-auto">
				<p class="not-prose font-display text-red-900 dark:text-red-500">
					{translate key=$errorMsg supportEmail=$supportEmail}
				</p>
				<div class="prose mt-2.5 text-red-800 [--tw-prose-underline:var(--color-red-400)] [--tw-prose-background:var(--color-red-50)] prose-a:text-red-900 prose-code:text-red-900 dark:text-slate-300 dark:[--tw-prose-underline:var(--color-sky-700)] dark:prose-code:text-slate-300">
					{if $reason}
						<p>{$reason}</p>
					{/if}
				</div>
			</div>
		</div>
		{if not $legacyLogin && not $accountDisabled}
			<div class="my-6 flex rounded-3xl p-6 bg-sky-50 dark:bg-slate-800/60 dark:ring-1 dark:ring-slate-300/10">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" class="text-sky-900 h-6 w-6 flex-none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M16.2 7.8l-2 6.3-6.4 2.1 2-6.3z"/></svg>

				<div class="ml-4 flex-auto">
					<p class="not-prose font-display text-sky-900 dark:text-sky-500">
						{translate key="plugins.generic.openid.error.legacy.link" legacyLoginUrl={url page="login" op="legacyLogin"}}
					</p>
					<div class="prose mt-2.5 text-sky-800 [--tw-prose-underline:var(--color-sky-400)] [--tw-prose-background:var(--color-sky-50)] prose-a:text-sky-900 prose-code:text-sky-900 dark:text-slate-300 dark:[--tw-prose-underline:var(--color-sky-700)] dark:prose-code:text-slate-300">
					</div>
				</div>
			</div>
		{/if}
	{/if}
	<ul id="_openid-provider-list">
		{if $legacyLogin}
			<li class="my-6">
				<strong>{translate key='plugins.generic.openid.select.legacy' journalName=$siteTitle|escape}</strong>
			</li>
			<li class="page_login">
				<form class="cmp_form cmp_form login" id="login" method="post" action="{$loginUrl}">
					{csrf}
					<fieldset class="space-y-4">
						<div class="username">
							{material_label for="username"}
								{translate key="user.username"}
								<span class="required" aria-hidden="true">*</span>
							{/material_label}

							{material_input type="text"
								name="username"
								id="username"
								value="{$username|escape}"
								maxlength="32"
								required="true"
								aria-required="true"
								autocomplete="username"
								class="mt-1 block w-full"}
						</div>
						<div class="password">
							{material_label for="password"}
								{translate key="user.password"}
								<span class="required" aria-hidden="true">*</span>
							{/material_label}

							{material_input type="password"
								name="password"
								id="password"
								value="{$password|escape}"
								password="true"
								maxlength="32"
								required="true"
								aria-required="true"
								class="mt-1 block w-full"}
						</div>
						<div>
							<a href="{url page="login" op="lostPassword"}">
								{translate key="user.login.forgotPassword"}
							</a>
						</div>
						<div class="remember checkbox">
							<label class="flex items-center">
								{material_checkbox name="remember"
									id="remember"
									value="1"
									checked="$remember"}
								<span class="label ml-2 text-sm text-gray-600 dark:text-gray-400">
									{translate key="user.login.rememberUsernameAndPassword"}
								</span>
							</label>
						</div>
						<div class="buttons">
							{material_button_primary type="submit"}
								{translate key="user.login"}
							{/material_button_primary}
						</div>
					</fieldset>
				</form>
			</li>
		{/if}
		{if $linkList}
			<li class="mt-5"><strong>{translate key='plugins.generic.openid.select.provider.help'}</strong></li>
			{foreach from=$linkList key=name item=url}
				<li class="mt-4">
					<a id="openid-provider-{$name}" href="{$url}">
						<div class="flex items-center flex h-8 items-center text-slate-500 rounded-xl shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5 px-3 text-sm dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300 space-x-2">
							{if $name == 'custom'}
								{if $customBtnImg}
									<img src="{$customBtnImg}" alt="{$name}">
								{else}
									<img src="{$openIDImageURL}{$name}-sign-in.png" alt="{$name}">
								{/if}
								<span>
									{if isset($customBtnTxt)}
										{$customBtnTxt}
									{else}
										{{translate key="plugins.generic.openid.select.provider.$name"}}
									{/if}
								</span>
							{else}
								<img class="w-4 h-4" src="{$openIDImageURL}{$name}-sign-in.png" alt="{$name}"/>
								<p>{{translate key="plugins.generic.openid.select.provider.$name"}}</p>
							{/if}
						</div>
					</a>
				</li>
			{/foreach}
		{/if}
	</ul>
</div><!-- .page -->
{include file="frontend/components/footer.tpl"}
