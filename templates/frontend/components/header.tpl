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
<html lang="{$currentLocale|replace:"_":"-"}"
	xml:lang="{$currentLocale|replace:"_":"-"}"
	{literal}
  		x-data="{ darkMode: localStorage.getItem('darkMode') || localStorage.setItem('darkMode', 'light') }" 
  		x-init="$watch('darkMode', val => localStorage.setItem('darkMode', val))" 
  		x-bind:class="{'dark': darkMode === 'dark' || (darkMode === 'system' && window.matchMedia('(prefers-color-scheme: dark)').matches)}"
  	{/literal}>

{if !$pageTitleTranslated}
	{capture assign="pageTitleTranslated"}
		{translate key=$pageTitle}
	{/capture}
{/if}
{include file="frontend/components/headerHead.tpl"}

{assign
   var="materialBaseColour"
   value=$activeTheme->getOption('materialBaseColour')}

<body class="bg-white dark:bg-slate-900 pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

{if $requestedPage !== 'login' && $requestedPage !== 'user'}

	<!-- ======= Header ======= -->
	<header class="sticky top-0 z-50 flex flex-none flex-wrap items-center justify-between bg-white px-4 py-5 shadow-md shadow-slate-900/5 transition duration-500 sm:px-6 lg:px-8 dark:shadow-none dark:bg-slate-900/95 dark:backdrop-blur dark:[@supports(backdrop-filter:blur(0))]:bg-slate-900/75">
		{* Skip to content nav links *}
		{*include file="frontend/components/skipLinks.tpl"*}

		{material_sidestack class="flex xl:hidden"}
			<div class="space-y-9">
				<div class="mt-5 lg:hidden">
					{capture assign="primaryMenu"}
						{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
					{/capture}
					{$primaryMenu}
				</div>
				<div class="xl:hidden">
					{include file="frontend/components/sidebar.tpl"}
				</div>
				<div class="md:hidden">
					{load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user" liClass="profile"}
				</div>
			</div>
		{/material_sidestack}

		<div class="relative flex flex-grow basis-0 items-center">
			{include file="frontend/components/logo.tpl" small=true}
		</div>
		<div class="flex items-center space-x-2">
			{* Search form *}
			{if $currentContext && $requestedPage !== 'search'}
				<div class="pkp_navigation_search_wrapper">
					<a href="{url page="search"}" class="flex h-8 w-8 items-center justify-center rounded-xl shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5">
						{include file="frontend/components/ui/material_icon_search.tpl"}
					</a>
				</div>
			{/if}
			{*include file="frontend/components/ui/localeSelector.tpl"*}
			{include file="frontend/components/ui/material_theme_selector.tpl"}
			{load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user hidden md:flex" liClass="profile"}
		</div>
	</header>

	{if $requestedPage == 'index' || $requestedPage == ''}
		{if $currentContext}
			{include file="frontend/components/headerSection.tpl"}
		{/if}
	{/if}

	{capture assign="primaryMenu"}
		{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
	{/capture}

	<div class="relative mx-auto flex w-full max-w-8xl flex-auto justify-center sm:px-2 lg:px-8 xl:px-12">
		<div class="hidden lg:relative lg:block lg:flex-none">
			<div class="absolute inset-y-0 right-0 w-[50vw] bg-slate-50 dark:hidden">
			</div>
			<div class="absolute bottom-0 right-0 top-16 hidden h-12 w-px bg-gradient-to-t from-slate-800 dark:block">
			</div>
			<div class="absolute bottom-0 right-0 top-28 hidden w-px bg-slate-800 dark:block">
			</div>
			<div class="sticky top-[4.75rem] -ml-0.5 h-[calc(100vh-4.75rem)] w-64 overflow-y-auto overflow-x-hidden py-16 pl-0.5 pr-8 xl:w-72 xl:pr-16 scrollbar-thin scrollbar-thumb-gray-400 scrollbar-track-gray-200 dark:scrollbar-thumb-gray-600 dark:scrollbar-track-gray-800">
				<nav class="text-base lg:text-sm">
					{* Primary navigation menu for current application *}
					{$primaryMenu}
				</nav>
			</div>
		</div>

		{* Wrapper for page content and sidebars *}
		{if $isFullWidth}
			{assign var=hasSidebar value=0}
		{/if}

		{* Main *}
		<main class="min-w-0 max-w-2xl flex-auto px-4 py-16 lg:max-w-none lg:pl-8 lg:pr-0 xl:px-16 dark:text-white">
			<a id="pkp_content_main"></a>
			<article>
				<!--div class="prose prose-slate max-w-none dark:prose-invert dark:text-slate-400 prose-headings:scroll-mt-28 prose-headings:font-display prose-headings:font-normal lg:prose-headings:scroll-mt-[8.5rem] prose-lead:text-slate-500 dark:prose-lead:text-slate-400 prose-a:font-semibold dark:prose-a:text-sky-400 prose-a:no-underline prose-a:shadow-[inset_0_-2px_0_0_var(--tw-prose-background,#fff),inset_0_calc(-1*(var(--tw-prose-underline-size,4px)+2px))_0_0_var(--tw-prose-underline,theme(colors.sky.300))] hover:prose-a:[--tw-prose-underline-size:6px] dark:[--tw-prose-background:theme(colors.slate.900)] dark:prose-a:shadow-[inset_0_calc(-1*var(--tw-prose-underline-size,2px))_0_0_var(--tw-prose-underline,theme(colors.sky.800))] dark:hover:prose-a:[--tw-prose-underline-size:6px] prose-pre:rounded-xl prose-pre:bg-slate-900 prose-pre:shadow-lg dark:prose-pre:bg-slate-800/60 dark:prose-pre:shadow-none dark:prose-pre:ring-1 dark:prose-pre:ring-slate-300/10 dark:prose-hr:border-slate-800"-->
				<div  class="prose prose-slate max-w-none prose-a:text-{$materialBaseColour}-400 dark:prose-a:text-{$materialBaseColour}-400 dark:prose-invert dark:text-slate-400 dark:prose-lead:text-slate-400 prose-headings:font-normal">
{else}
	<main class="min-h-screen flex flex-col sm:justify-center items-center pt-6 sm:pt-0 bg-gray-100 dark:bg-gray-900 dark:text-white" role="main">
		<a id="pkp_content_main"></a>
{/if}
