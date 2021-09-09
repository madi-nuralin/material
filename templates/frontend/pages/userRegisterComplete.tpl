{**
 * templates/frontend/pages/userRegisterComplete.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief A landing page displayed to users upon successful registration
 *}
{include file="frontend/components/header.tpl"}
<div class="row d-flex justify-content-center align-items-center">
	<div class="col-lg-7 col-md-12 bg-white overflow-auto">
		<div class="page page_register_complete">
			{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$pageTitle}

			<div class="d-flex justify-content-center mb-3">
				{if $displayPageHeaderLogo}
					<a href="{$homeUrl}" class="navbar-brand is_img">
						<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{/if} class="img-fluid" style="max-width: 180px;"/>
					</a>
				{/if}
			</div>

			<h1 class="text-center">
				{translate key=$pageTitle}
			</h1>
			<p>
				{translate key="user.login.registrationComplete.instructions"}
			</p>

			<div class="row">
				{if array_intersect(array(ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER), (array)$userRoles)}
				<div class="col-lg-6 col-md-6 col-sm-6 col-12 item-mb">
					<div class="view_submissions bg-body text-center text-uppercase text-truncate shadow pt-5 pb-5 mb-4 rounded-5">
						<a href="{url page="submissions"}">
							<i class="fas fa-link fa-3x"></i><br/><br/>
							{translate key="user.login.registrationComplete.manageSubmissions"}
						</a>
					</div>
				</div>
				{/if}
				{if $currentContext}
				<div class="col-lg-6 col-md-6 col-sm-6 col-12 item-mb">
					<div class="new_submission bg-body text-center text-uppercase text-truncate shadow pt-5 pb-5 mb-4 rounded-5">
						<a href="{url page="submission" op="wizard"}">
							<i class="fas fa-pen-nib fa-3x"></i><br/><br/>
							{translate key="user.login.registrationComplete.newSubmission"}
						</a>
					</div>
				</div>
				{/if}
				<div class="col-lg-6 col-md-6 col-sm-6 col-12 item-mb">
					<div class="edit_profile bg-body text-center text-uppercase text-truncate shadow pt-5 pb-5 mb-4 rounded-5">
						<a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="profile"}">
							<i class="fas fa-user-circle fa-3x"></i><br/><br/>
							{translate key="user.editMyProfile"}
						</a>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6 col-12 item-mb">
					<div class="browse bg-body text-center text-uppercase text-truncate shadow pt-5 pb-5 mb-4 rounded-5">
						<a href="{url page="index"}">
							<i class="fas fa-book fa-3x"></i><br/><br/>
							{translate key="user.login.registrationComplete.continueBrowsing"}
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
