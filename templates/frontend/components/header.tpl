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

		<nav class="navbar navbar-expand-lg navbar-dark scrolling-navbar d-flex flex-column" id="navbar" style="background-color: #860d14;">
			<div class="container">
				
				{if $displayPageHeaderLogo}
					<a 
						href="{url page="index" router=$smarty.const.ROUTE_PAGE}"
						class="navbar-brand is_img">
						<img
							src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
							width="{$displayPageHeaderLogo.width|escape}"
							height="{$displayPageHeaderLogo.height|escape}"
							{if $displayPageHeaderLogo.altText != ''}
								alt="{$displayPageHeaderLogo.altText|escape}"
							{/if}
							class="img-fluid"
							style="max-width: 180px;"/>
					</a>
				{else}
					<a class="navbar-brand" href="#">
						<strong>OJS App</strong>
					</a>
				{/if}

				<button 
					class="navbar-toggler"
					type="button"
					data-mdb-toggle="collapse"
					data-mdb-target="#navbarContent"
					aria-controls="navbarContent"
					aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="fas fa-bars"></span>
				</button>

				<div class="collapse navbar-collapse justify-content-end" id="navbarContent">
					{capture assign="primaryMenu"}
						{load_menu name="primary" id="_navigationPrimary" ulClass="_pkp_navigation_primary" liClass=""}
					{/capture}

					{* Primary navigation menu for current application *}
					{$primaryMenu}
				</div>
			</div>
			
		</nav>

		<nav class="navbar navbar-expand-lg navbar-light scrolling-navbar d-flex flex-column">
			<div class="container">
				<div class="navbar-collapse d-flex justify-content-end">
					{include file="frontend/components/navigationMenu2.tpl"}
					{* User navigation *}
					{load_menu name="user" id="_navigationUser" ulClass="_pkp_navigation_user flex-row justify-content-end" liClass="profile px-2 px-md-0"}
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
