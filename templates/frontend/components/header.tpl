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

	<!-- ======= Header ======= -->
	<header id="header" class="fixed-top d-flex align-items-center">
	  	{* Skip to content nav links *}
		{* include file="frontend/components/skipLinks.tpl"*}
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

				{* Primary navigation menu for current application *}
				{$primaryMenu}
	      	</nav><!-- .navbar -->

	      	<nav class="navbar navbar-expand-lg navbar-dark scrolling-navbar d-flex flex-column shadow-0">
				<div class="container">
					<div class="navbar-collapse d-flex justify-content-end">
						{include file="frontend/components/navigationMenu2.tpl"}
						{* User navigation *}
						{load_menu name="user" id="_navigationUser" ulClass="_pkp_navigation_user flex-row justify-content-end" liClass="profile px-2 px-md-0"}
					</div>
				</div>
			</nav>
	      	{include file="frontend/components/navigationMenuMobile.tpl"}
	    </div>
  	</header><!-- End Header -->

  {if $requestedPage == 'index' || $requestedPage == ''}
	  <!-- ======= Hero Section ======= -->
	  <section class="hero-section" id="hero">

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
	            	{if $currentContext}
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
			        {else}
			        	<h1 data-aos="fade-right">
			              	{translate key="context.contexts"}
			            </h1>
			        {/if}
	            </div>
	            {if $requestedPage !== ''}
		            <div class="col-lg-4 iphone-wrap">
						{assign var="thumb" value=$currentJournal->getLocalizedSetting('journalThumbnail')}
						{if $thumb}
							<img class="phone-2" data-aos="fade-right" src="{$publicFilesDir}{*$currentJournal->getId()*}/{$thumb.uploadName|escape:"url"}">
						{/if}
		            </div>
		        {/if}
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
