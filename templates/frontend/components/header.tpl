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

	<header class="sticky top-0 z-50 flex flex-none flex-wrap items-center justify-between bg-white px-4 py-5 shadow-md shadow-slate-900/5 transition duration-500 sm:px-6 lg:px-8 dark:shadow-none dark:bg-transparent">
		<div class="relative flex flex-grow basis-0 items-center"><a aria-label="Home page" href="/"><svg aria-hidden="true" viewBox="0 0 36 36" fill="none" class="h-9 w-9 lg:hidden"><g fill="none" stroke="#38BDF8" stroke-linejoin="round" stroke-width="3"><path d="M10.308 5L18 17.5 10.308 30 2.615 17.5 10.308 5z"></path><path d="M18 17.5L10.308 5h15.144l7.933 12.5M18 17.5h15.385L25.452 30H10.308L18 17.5z"></path></g></svg><svg aria-hidden="true" viewBox="0 0 227 36" fill="none" class="hidden h-9 w-auto fill-slate-700 lg:block dark:fill-sky-100"><g fill="none" stroke="#38BDF8" stroke-linejoin="round" stroke-width="3"><path d="M10.308 5L18 17.5 10.308 30 2.615 17.5 10.308 5z"></path><path d="M18 17.5L10.308 5h15.144l7.933 12.5M18 17.5h15.385L25.452 30H10.308L18 17.5z"></path></g><path d="M55.96 26.2c-1.027 0-1.973-.173-2.84-.52a6.96 6.96 0 01-2.24-1.5 6.979 6.979 0 01-1.46-2.3c-.347-.893-.52-1.867-.52-2.92 0-1.027.18-1.973.54-2.84a6.71 6.71 0 011.52-2.28 6.922 6.922 0 012.3-1.52 7.48 7.48 0 012.86-.54c.667 0 1.32.093 1.96.28a6.12 6.12 0 011.78.78 5.7 5.7 0 011.4 1.24l-1.88 2.08a6.272 6.272 0 00-1-.82 3.728 3.728 0 00-1.08-.54 3.542 3.542 0 00-1.2-.2 4.14 4.14 0 00-1.62.32 3.991 3.991 0 00-1.3.9 4.197 4.197 0 00-.9 1.38 4.755 4.755 0 00-.32 1.78c0 .667.107 1.273.32 1.82.213.533.513.993.9 1.38.387.373.847.667 1.38.88.547.2 1.147.3 1.8.3a4.345 4.345 0 002.34-.68c.347-.213.653-.46.92-.74l1.46 2.34c-.32.36-.753.687-1.3.98a7.784 7.784 0 01-1.8.7c-.667.16-1.34.24-2.02.24zm6.99-.2l5.48-14h2.68l5.46 14h-3.08l-2.82-7.54c-.08-.213-.18-.487-.3-.82a922.595 922.595 0 00-.68-2.12 13.694 13.694 0 01-.24-.86l.54-.02c-.08.307-.174.627-.28.96-.094.32-.194.653-.3 1-.108.333-.22.66-.34.98-.12.32-.234.633-.34.94L65.91 26h-2.96zm2.54-2.94l.98-2.42h6.42l1 2.42h-8.4zm19.794 3.14c-1.026 0-1.973-.173-2.84-.52a6.96 6.96 0 01-2.24-1.5 6.98 6.98 0 01-1.46-2.3c-.346-.893-.52-1.867-.52-2.92 0-1.027.18-1.973.54-2.84a6.71 6.71 0 011.52-2.28 6.923 6.923 0 012.3-1.52 7.48 7.48 0 012.86-.54c.667 0 1.32.093 1.96.28a6.118 6.118 0 011.78.78c.547.347 1.014.76 1.4 1.24l-1.88 2.08a6.272 6.272 0 00-1-.82 3.728 3.728 0 00-1.08-.54 3.542 3.542 0 00-1.2-.2 4.14 4.14 0 00-1.62.32 3.992 3.992 0 00-1.3.9 4.197 4.197 0 00-.9 1.38 4.755 4.755 0 00-.32 1.78c0 .667.107 1.273.32 1.82.214.533.514.993.9 1.38.387.373.847.667 1.38.88.547.2 1.147.3 1.8.3a4.345 4.345 0 002.34-.68 4.53 4.53 0 00.92-.74l1.46 2.34c-.32.36-.753.687-1.3.98a7.784 7.784 0 01-1.8.7c-.666.16-1.34.24-2.02.24zm17.469-.2V12h3v14h-3zm-8.82 0V12h3v14h-3zm1.2-5.62l.02-2.72h9.14v2.72h-9.16zM110.402 26V12h9.46v2.64h-6.54v8.72h6.68V26h-9.6zm1.4-5.86v-2.56h7.1v2.56h-7.1zM122.437 26l5.48-14h2.68l5.46 14h-3.08l-2.82-7.54c-.08-.213-.18-.487-.3-.82l-.34-1.06-.34-1.06a14.73 14.73 0 01-.24-.86l.54-.02c-.08.307-.173.627-.28.96a63.3 63.3 0 01-.3 1c-.106.333-.22.66-.34.98-.12.32-.233.633-.34.94l-2.82 7.48h-2.96zm2.54-2.94l.98-2.42h6.42l1 2.42h-8.4zM139.023 26V12h5.74c1.027 0 1.953.173 2.78.52.84.333 1.56.813 2.16 1.44a6.097 6.097 0 011.4 2.2c.32.853.48 1.8.48 2.84 0 1.027-.16 1.973-.48 2.84a6.438 6.438 0 01-1.38 2.22 6.394 6.394 0 01-2.16 1.44c-.84.333-1.773.5-2.8.5h-5.74zm3-2.18l-.32-.52h2.96c.6 0 1.14-.1 1.62-.3.48-.213.887-.5 1.22-.86.347-.373.607-.827.78-1.36.173-.533.26-1.127.26-1.78a5.56 5.56 0 00-.26-1.76 3.595 3.595 0 00-.78-1.36 3.323 3.323 0 00-1.22-.86 3.948 3.948 0 00-1.62-.32h-3.02l.38-.48v9.6zM158.671 26l-5.58-14h3.18l2.92 7.58c.16.413.293.78.4 1.1.12.307.22.6.3.88.093.267.18.533.26.8.08.253.16.533.24.84l-.58.02c.107-.413.213-.793.32-1.14.107-.36.227-.733.36-1.12.133-.387.3-.847.5-1.38l2.76-7.58h3.16l-5.62 14h-2.62zm8.114 0l5.48-14h2.68l5.46 14h-3.08l-2.82-7.54c-.08-.213-.18-.487-.3-.82l-.34-1.06-.34-1.06a13.293 13.293 0 01-.24-.86l.54-.02c-.08.307-.173.627-.28.96a63.3 63.3 0 01-.3 1c-.107.333-.22.66-.34.98-.12.32-.233.633-.34.94l-2.82 7.48h-2.96zm2.54-2.94l.98-2.42h6.42l1 2.42h-8.4zM183.371 26V12h2.68l7.74 10.46h-.56c-.054-.413-.1-.813-.14-1.2l-.12-1.2c-.027-.413-.054-.833-.08-1.26-.014-.44-.027-.9-.04-1.38a56.825 56.825 0 01-.02-1.6V12h2.94v14h-2.72l-7.9-10.56.76.02c.066.693.12 1.287.16 1.78a36.623 36.623 0 01.18 2.2c.026.267.04.52.04.76.013.24.02.493.02.76V26h-2.94zm23.175.2c-1.027 0-1.973-.173-2.84-.52-.853-.36-1.6-.86-2.24-1.5a6.979 6.979 0 01-1.46-2.3c-.347-.893-.52-1.867-.52-2.92 0-1.027.18-1.973.54-2.84a6.71 6.71 0 011.52-2.28 6.919 6.919 0 012.3-1.52 7.48 7.48 0 012.86-.54c.667 0 1.32.093 1.96.28a6.12 6.12 0 011.78.78 5.7 5.7 0 011.4 1.24l-1.88 2.08a6.259 6.259 0 00-1-.82 3.721 3.721 0 00-1.08-.54 3.54 3.54 0 00-1.2-.2 4.14 4.14 0 00-1.62.32 3.991 3.991 0 00-1.3.9 4.206 4.206 0 00-.9 1.38 4.76 4.76 0 00-.32 1.78c0 .667.107 1.273.32 1.82.213.533.513.993.9 1.38.387.373.847.667 1.38.88.547.2 1.147.3 1.8.3a4.35 4.35 0 002.34-.68c.347-.213.653-.46.92-.74l1.46 2.34c-.32.36-.753.687-1.3.98a7.773 7.773 0 01-1.8.7c-.667.16-1.34.24-2.02.24zm8.649-.2V12h9.46v2.64h-6.54v8.72h6.68V26h-9.6zm1.4-5.86v-2.56h7.1v2.56h-7.1z"></path></svg></a></div>
		<div class="flex space-x-2">
			{include file="frontend/components/ui/themeSelector.tpl"}
			{include file="frontend/components/ui/localeSelector.tpl"}
		</div>
	</header>


	<!-- ======= Header ======= -->
{*
	<header id="header" class="sticky top-0 z-50 flex flex-none flex-wrap items-center justify-between bg-white px-4 py-5 shadow-md shadow-slate-900/5 transition duration-500 sm:px-6 lg:px-8 dark:shadow-none dark:bg-transparent">
  	{* Skip to content nav links *
	{* include file="frontend/components/skipLinks.tpl"*
    <div class="container d-flex justify-content-between align-items-center">
    	<div class="logo">
    		{if $displayPageHeaderLogo}
				<a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="navbar-brand _is_img">
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
				<!--a class="navbar-brand text-white" href="#">
					<strong>OJS App</strong>
				</a-->
			{/if}

		</div>

		<nav id="navbar" class="navbar navbar-dark flex-row shadow-0">
			{capture assign="primaryMenu"}
				{load_menu name="primary" id="_navigationPrimary" ulClass="_pkp_navigation_primary" liClass=""}
			{/capture}

			{* Primary navigation menu for current application *
			{$primaryMenu}
			
      	</nav><!-- .navbar -->

      	<nav class="navbar navbar-expand-lg navbar-dark scrolling-navbar d-flex flex-column shadow-0">
			<div class="container">
				<div class="navbar-collapse d-flex justify-content-end">
					{include file="frontend/components/navigationMenu2.tpl"}
					{* User navigation *
					{load_menu name="user" id="_navigationUser" ulClass="_pkp_navigation_user flex-row justify-content-end" liClass="profile px-2 px-md-0"}
				</div>
			</div>
		</nav>
      	{include file="frontend/components/navigationMenuMobile.tpl"}
    </div>
  </header><!-- End Header -->
*}
  {if $requestedPage == 'index' || $requestedPage == ''}
	  <!-- ======= Hero Section ======= -->
	  <section class="hero-section" id="hero">
	  {*if $activeTheme->getOption('useHomepageImageAsHeader')}
	  <section class="hero-section" id="hero" style="background-image: url('{$publicFilesDir}/homepageImage_ru_RU.jpg');">
	  {/if*}

	    <div class="wave">

	      <svg width="100%" height="355px" viewBox="0 0 1920 355" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
	        <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
	          <g id="Apple-TV" transform="translate(0.000000, -402.000000)" fill="#FFFFFF">
	            <path d="M0,439.134243 C175.04074,464.89273 327.944386,477.771974 458.710937,477.771974 C654.860765,477.771974 870.645295,442.632362 1205.9828,410.192501 C1429.54114,388.565926 1667.54687,411.092417 1920,477.771974 L1920,757 L1017.15166,757 L0,757 L0,439.134243 Z" id="Path"></path>
	          </g>
	        </g>
	      </svg>

	    </div>

	    <div class="container">
	      <div class="row align-items-center">
	        <div class="col-12 hero-text-image">
	          <div class="row">
	            <div class="col-lg-8 text-center text-lg-start">
	              <h1 data-aos="fade-right">
	              	{$displayPageHeaderTitle|escape}
	              </h1>
	              {if $activeTheme->getOption('showDescriptionInJournalIndex')}
	              	<div class="mb-5" data-aos="fade-right" data-aos-delay="100">
	              		{$currentContext->getLocalizedData('description')}
	              	</div>
	              {/if}
	              <p data-aos="fade-right" data-aos-delay="200" data-aos-offset="-500">
	              	<a
	              		class="btn btn-outline-white text-uppercase pt-4 pb-4"
	              		href="{url router=$smarty.const.ROUTE_PAGE page="about" op="submissions"}"
	              		role="button">
	              		{translate key="plugins.themes.material.makeSubmission"}
	              	</a>
	              </p>
	            </div>
	            <div class="col-lg-4 iphone-wrap">

									{assign var="thumb" value=$currentJournal->getLocalizedSetting('journalThumbnail')}
									{if $thumb}
										<img class="phone-2" data-aos="fade-right" src="{$publicFilesDir}{*$currentJournal->getId()*}/{$thumb.uploadName|escape:"url"}">
									{/if}
																
	              <!--img src="assets/img/phone_1.png" alt="Image" class="phone-1" data-aos="fade-right"-->
	              <!--img src="assets/img/phone_2.png" alt="Image" class="phone-2" data-aos="fade-right" data-aos-delay="200"-->
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>

	  </section><!-- End Hero -->
	{/if}



	{* Wrapper for page content and sidebars *}
	{if $isFullWidth}
		{assign var=hasSidebar value=0}
	{/if}

	{* Main *}
	<main class="" role="main">
		<a id="pkp_content_main"></a>

		{if $requestedPage != 'index' && $requestedPage != ''}
		
			<section class="hero-section inner-page">
			  <div class="wave">

			    <svg width="1920px" height="265px" viewBox="0 0 1920 265" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
			      <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
			        <g id="Apple-TV" transform="translate(0.000000, -402.000000)" fill="#FFFFFF">
			          <path d="M0,439.134243 C175.04074,464.89273 327.944386,477.771974 458.710937,477.771974 C654.860765,477.771974 870.645295,442.632362 1205.9828,410.192501 C1429.54114,388.565926 1667.54687,411.092417 1920,477.771974 L1920,667 L1017.15166,667 L0,667 L0,439.134243 Z" id="Path"></path>
			        </g>
			      </g>
			    </svg>

			  </div>

			  <div class="container">
			    <div class="row align-items-center">
			      <div class="col-12">
			        <div class="row justify-content-center">
			          <div class="col-md-10 text-center hero-text">
			            <h1 data-aos="fade-up" data-aos-delay="">{$pageTitleTranslated}</h1>
			            <p class="mb-5" data-aos="fade-up" data-aos-delay="100"></p>
			          </div>
			        </div>
			      </div>
			    </div>
			  </div>

			</section>
		{/if}
{else}
	<main class="container-fluid" role="main">
		<a id="pkp_content_main"></a>
{/if}
