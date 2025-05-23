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
	<ul id="openid-provider-list">
		{if $legacyLogin}
			<li class="margin-top-30"><strong>{translate key='plugins.generic.openid.select.legacy' journalName=$siteTitle|escape}</strong></li>
			<li class="page_login">
				<form class="cmp_form cmp_form login" id="login" method="post" action="{$loginUrl}">
					{csrf}
					<fieldset class="fields">
						<div class="username">
							<label>
								<span class="label">
									{translate key="user.username"}
									<span class="required" aria-hidden="true">*</span>
									<span class="pkp_screen_reader">
										{translate key="common.required"}
									</span>
								</span>
								<input type="text" name="username" id="username" value="{$username|escape}" maxlength="32" required aria-required="true">
							</label>
						</div>
						<div class="password">
							<label>
								<span class="label">
									{translate key="user.password"}
									<span class="required" aria-hidden="true">*</span>
									<span class="pkp_screen_reader">
										{translate key="common.required"}
									</span>
								</span>
								<input type="password" name="password" id="password" value="{$password|escape}" maxlength="32" required aria-required="true">

								<a href="{url page="login" op="lostPassword"}">
									{translate key="user.login.forgotPassword"}
								</a>

							</label>
						</div>
						<div class="remember checkbox">
							<label>
								<input type="checkbox" name="remember" id="remember" value="1">
								<span class="label">
									{translate key="user.login.rememberUsernameAndPassword"}
								</span>
							</label>
						</div>
						<div class="buttons">
							<button class="submit" type="submit">
								{translate key="user.login"}
							</button>
						</div>
					</fieldset>
				</form>
			</li>
		{/if}
		{if $linkList}
			<li class="margin-top-30"><strong>{translate key='plugins.generic.openid.select.provider.help'}</strong></li>
			{foreach from=$linkList key=name item=url}
				{if $name == 'custom'}
					<li><a id="openid-provider-{$name}" href="{$url}">
							<div>
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
							</div>
						</a>
					</li>
				{else}
					<li class=""><a id="openid-provider-{$name}" href="{$url}">
							<div>
								<img src="{$openIDImageURL}{$name}-sign-in.png" alt="{$name}"/>
								<span>{{translate key="plugins.generic.openid.select.provider.$name"}}</span>
							</div>
						</a>
					</li>
				{/if}
			{/foreach}
		{/if}
	</ul>
</div><!-- .page -->
{include file="frontend/components/footer.tpl"}
