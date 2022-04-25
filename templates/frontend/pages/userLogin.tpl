{**
 * templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

<div class="row d-flex justify-content-center align-items-center">
	<div class="col-lg-5 col-md-12 bg-white overflow-auto">
		
		<div class="page page_login p-4">
			{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}

			<h1 class="text-center">
				{translate key="user.login"}
			</h1>

			{* A login message may be displayed if the user was redireceted to the
			   login page from another request. Examples include if login is required
			   before dowloading a file. *}
			{if $loginMessage}
				<p>
					{translate key=$loginMessage}
				</p>
			{/if}

			
			<form class="_cmp_form rounded" id="login" method="post" action="{$loginUrl}">
				{csrf}

				{if $error}
					<div class="pkp_form_error">
						{translate key=$error reason=$reason}
					</div>
				{/if}

				<input type="hidden" name="source" value="{$source|escape}" />

				<fieldset class="fields">
					<div class="username form-group mb-4">
						<label class="form-check-label" for="username">
							{translate key="user.username"}
						</label>
						<input type="text" name="username" id="username" value="{$username|escape}" maxlength="32" required aria-required="true" class="form-control">
					</div>
					<div class="password form-group mb-4">
						<label class="form-check-label" for="password">
							{translate key="user.password"}
						</label>
						<input type="password" name="password" id="password" value="{$password|escape}" password="true" maxlength="32" required aria-required="true" class="form-control">
						<span class="pkp_screen_reader">
							{translate key="common.required"}
						</span>
						
					</div>
					<div class="form-group mb-4">
						<a href="{url page="login" op="lostPassword"}">
							{translate key="user.login.forgotPassword"}
						</a>
					</div>
					<div class="remember form-group mb-4">
						<input type="checkbox" name="remember" id="remember" value="1" checked="$remember" class="form-check-input">
						<label class="form-check-label" for="remember">
							{translate key="user.login.rememberUsernameAndPassword"}
						</label>
					</div>
					<div class="d-flex flex-column justify-content-end align-items-center">
						<button class="btn btn-lg btn-primary btn-md mb-3 w-100" type="submit">
							{translate key="user.login"}
						</button>
						{if !$disableUserReg}
							{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
							<a href="{$registerUrl}" class="register btn btn-lg btn-md btn-light w-100">
								{translate key="user.login.registerNewAccount"}
							</a>
						{/if}
					</div>
				</fieldset>
				
			</form>
		</div><!-- .page -->
	</div>
</div>
{include file="frontend/components/footer.tpl"}
