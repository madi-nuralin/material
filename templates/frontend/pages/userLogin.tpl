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
	<div class="col-lg-7 col-md-12 bg-white overflow-auto">
		
		<div class="page page_login p-4">
			{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}
			
			<div class="d-flex justify-content-center mb-3">
				{if $displayPageHeaderLogo}
					<a href="{$homeUrl}" class="navbar-brand is_img">
						<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{/if} class="img-fluid" style="max-width: 180px;"/>
					</a>
				{/if}
			</div>

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

			
			<form class="cmp_form" id="login" method="post" action="{$loginUrl}">
				{csrf}

				{if $error}
					<div class="pkp_form_error">
						{translate key=$error reason=$reason}
					</div>
				{/if}

				<input type="hidden" name="source" value="{$source|escape}" />

				<fieldset class="fields">
					<legend class="pkp_screen_reader">{translate key="user.login"}</legend>
					<div class="username form-group mb-4">
						<input type="text" name="username" id="username" value="{$username|escape}" maxlength="32" required aria-required="true" class="form-control" placeholder="{translate key="user.username"}">
					</div>
					<div class="password form-group mb-4">
						<input type="password" name="password" id="password" value="{$password|escape}" password="true" maxlength="32" required aria-required="true" class="form-control" placeholder="{translate key="user.password"}">
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
					<div class="d-flex flex-column justify-content-center align-items-center">
						<button class="btn btn-primary btn-lg col-12 mb-4" type="submit">
							{translate key="user.login"}
						</button>
						{if !$disableUserReg}
							{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
							<a href="{$registerUrl}" class="register btn btn-lg btn-light col-12 mb-3">
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
