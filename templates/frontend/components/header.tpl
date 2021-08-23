{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
{strip}
	{* Determine whether a logo or title string is being displayed *}
	{assign var="showingLogo" value=true}
	{if !$displayPageHeaderLogo}
		{assign var="showingLogo" value=false}
	{/if}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}

<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

{if $requestedPage !== 'login' && $requestedPage !== 'user'}
	{* Header *}
	<header class="_pkp_structure_head" id="_headerNavigationContainer" role="banner">
		{* Skip to content nav links *}
		{include file="frontend/components/skipLinks.tpl"}

		<nav class="navbar navbar-expand-xxl2 navbar-light bg-white">

			<div class="container-fluid">

				{if $displayPageHeaderLogo}
					<a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="navbar-brand is_img">
						<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{/if} class="img-fluid" style="max-width: 180px;"/>
					</a>
				{/if}

				<div class="d-flex flex-row align-items-center">
					<!-- Button trigger modal -->
					<button type="button" class="btn btn-light btn-floating mx-2 my-2 navbar-toggler2" data-mdb-toggle="modal" data-mdb-target="#navbarModal">
						<i class="fas fa-home"></i>
					</button>
					<!-- Modal -->
					<div class="modal fade" id="navbarModal" tabindex="-1" aria-labelledby="navbarModalLabel" aria-hidden="true">
						<div class="modal-dialog mw-100 mx-1 my-1 mt-0">
							<div class="modal-content mt-1">
								<div class="modal-header" style="border-bottom: 0 none;">
									<div class="d-flex flex-row align-items-center">
										{include file="frontend/components/navigationMenu2.tpl"}

										{* User navigation *}
										{load_menu name="user" id="_navigationUser" ulClass="_pkp_navigation_user flex-row" liClass="profile"}
									</div>
									<button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
								</div>
							</div>
						</div>
					</div>

					<button class="navbar-toggler btn btn-light btn-floating" type="button" data-mdb-toggle="collapse" data-mdb-target="#navbar0" aria-controls="navbarExample01" aria-expanded="false" aria-label="Toggle navigation">
						<i class="fas fa-th-large"></i>
					</button>
				</div>

				<div class="collapse navbar-collapse justify-content-between flex-wrap" id="navbar0">
					
					{capture assign="primaryMenu"}
						{load_menu name="primary" id="_navigationPrimary" ulClass="_pkp_navigation_primary" liClass=""}
					{/capture}

					{* Primary navigation menu for current application *}
					{$primaryMenu}

					<div class="navbar-collapse2 align-items-center">
						{include file="frontend/components/navigationMenu2.tpl"}
						{* User navigation *}
						{load_menu name="user" id="_navigationUser" ulClass="_pkp_navigation_user navbar-collapse2" liClass="profile"}
					</div>
				</div>
			</div>
		</nav>

		{if $homepageImage}
			{if $activeTheme->getOption('useHomepageImageAsHeader')}
				<!-- Background image -->
				<div class="p-5 text-center bg-image parallax" style="background-image: url('{$publicFilesDir}/homepageImage_ru_RU.jpg'); min-height: 1000px;">
					<div class="mask" style="background-color: rgba(0, 0, 0, 0.6);">
						<div class="d-flex justify-content-center align-items-center h-100">
							<div class="text-white">
				<!-- Background image -->
			{else}
				<!-- No background image -->
				<div class="p-5 text-center bg-light">
					<div class="">
						<div class="d-flex justify-content-center align-items-center">
							<div class="text-dark">
				<!-- No background image -->
			{/if}
							<h1 class="mb-3 text-uppercase" style="font-family: 'Montserrat', sans-serif; font-weight: 500">{$displayPageHeaderTitle|escape}</h1>
							{* Journal Description *}
							{if $activeTheme->getOption('showDescriptionInJournalIndex')}
								<h5 class="mb-3" style="font-family: 'Montserrat', sans-serif; font-weight: 400">
									{$currentContext->getLocalizedData('description')}
								</h5>
							{/if}
							<a class="btn btn-primary btn-lg btn-rounded text-uppercase pt-4 pb-4" href="{url router=$smarty.const.ROUTE_PAGE page="about" op="submissions"}" role="button" style="font-size: 16px; font-family: 'Montserrat', sans-serif;" 
							>{translate key="plugins.themes.material.makeSubmission"}</a
							>
						</div>
					</div>
				</div>
			</div>
		{/if}

	</header><!-- .pkp_structure_head -->


	{* Wrapper for page content and sidebars *}
	{if $isFullWidth}
		{assign var=hasSidebar value=0}
	{/if}

	{* Main *}
	<main class="container pt-4" role="main">
		<a id="pkp_content_main"></a>
{else}
	<main class="container-fluid" role="main">
		<a id="pkp_content_main"></a>
{/if}
