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

<div class="row d-flex justify-content-center align-items-center">
	<div class="col-lg-5 col-md-12 bg-white overflow-auto">

		<div class="page page_lost_password p-4">
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
						<label for="email" class="col-12 form-check-label label">
							<span class="label">
								{translate key="user.login.registeredEmail"}
								<span class="required" aria-hidden="true">*</span>
								<span class="pkp_screen_reader">
									{translate key="common.required"}
								</span>
							</span>
						</label>
						<div class="col-12">
							<input type="email" name="email" id="email" value="{$email|escape}" required aria-required="true" class="form-control">
						</div>
					</div>
					<div class="d-flex flex-column align-items-center justify-content-center">
						<button class="btn btn-primary btn-lg col-12 mb-4" type="submit">
							{translate key="user.login.resetPassword"}
						</button>

						{if !$disableUserReg}
							{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
							<a href="{$registerUrl}" class="login btn btn-lg btn-light text-dark col-12 mb-4">
								{translate key="user.login.registerNewAccount"}
							</a>
						{/if}
					</div>
				</div>

			</form>

		</div><!-- .page -->
	</div>
</div>

{include file="frontend/components/footer.tpl"}
