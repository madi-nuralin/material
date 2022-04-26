{**
 * lib/pkp/templates/layouts/backend.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Common site header.
 *}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>{title|strip_tags value=$pageTitle}</title>
	{load_header context="backend"}
	{load_stylesheet context="backend"}
	{load_script context="backend"}
</head>
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

	<script type="text/javascript">
		// Initialise JS handler.
		$(function() {ldelim}
			$('body').pkpHandler(
				'$.pkp.controllers.SiteHandler',
				{ldelim}
					{include file="controllers/notification/notificationOptions.tpl"}
				{rdelim});
		{rdelim});
	</script>

	<div id="app" class="app {if $isLoggedInAs} app--isLoggedInAs{/if}">
		<header class="app__header" role="banner">
			<nav class="navbar navbar-expand-xxl navbar-light border-bottom bg-white shadow-0">
				<div class="container-fluid flex-nowrap">

					{if $availableContexts}
						<dropdown class="app__headerAction app__contexts" v-cloak>
							<template slot="button">
								<icon icon="sitemap"></icon>
								<span class="-screenReader">{translate key="context.contexts"}</span>
							</template>
							<ul>
								{foreach from=$availableContexts item=$availableContext}
									{if !$currentContext || $availableContext->name !== $currentContext->getLocalizedData('name')}
										<li>
											<a href="{$availableContext->url|escape}" class="pkpDropdown__action">
												{$availableContext->name|escape}
											</a>
										</li>
									{/if}
								{/foreach}
							</ul>
						</dropdown>
					{/if}
					{if $currentContext}
						<a class="app__contextTitle" href="{url page="index"}">
							{$currentContext->getLocalizedData('name')}
						</a>
					{elseif $siteTitle}
						<a class="app__contextTitle" href="{$baseUrl}">
							{$siteTitle}
						</a>
					{else}
						<div class="app__contextTitle">
							{translate key="common.software"}
						</div>
					{/if}

					<div class="app__headerActions" v-cloak>

						{block name="menu"}
							<nav v-if="!!menu && Object.keys(menu).length > 1" class="_app__nav" aria-label="{translate key="common.navigation.site"}">
								<div class="dropdown">
									<a class="nav-link text-dark dropdown-toggle  hidden-arrow" type="button" id="dropdownMenuButton2"  data-mdb-toggle="dropdown" aria-expanded="false">
										<i class="fas fa-grip-vertical"></i>
									</a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark" aria-labelledby="dropdownMenuButton2">
										<li v-for="(menuItem, key) in menu" :key="key" :class="!!menuItem.submenu ? '_app__navGroup' : ''">
											<hr v-if="!!menuItem.submenu" class="dropdown-divider">
											<a v-else class="dropdown-item" :class="menuItem.isCurrent ? 'app__navItem--isCurrent' : ''" :href="menuItem.url">
												{{ menuItem.name }}
											</a>
											<ul v-if="!!menuItem.submenu" class="list-unstyled">
												<li v-for="(submenuItem, submenuKey) in menuItem.submenu" :key="submenuKey">
													<a class="dropdown-item" :class="submenuItem.isCurrent ? 'app__navItem--isCurrent' : ''" :href="submenuItem.url">
														{{ submenuItem.name }}
													</a>
												</li>
											</ul>
										</li>
									</ul>
								</div>
							</nav>
						{/block}

						{if $currentUser}
							{call_hook name="Template::Layout::Backend::HeaderActions"}
							<div class="_app__headerAction _app__tasks">
								<a class="nav-link nav-link text-dark " ref="tasksButton" @click="openTasks">
									<i class="fa fa-bell"></i>
									<span class="-screenReader">{translate key="common.tasks"}</span>
									<span v-if="unreadTasksCount" class="badge rounded-pill badge-notification bg-danger">{{ unreadTasksCount }}</span>
								</a>
							</div>
							<div class="dropdown">
								<a class="nav-link nav-link text-dark dropdown-toggle" type="button" id="dropdownMenuButton" data-mdb-toggle="dropdown" aria-expanded="false">
									<i class="fa fa-user"></i>
									{*if $isUserLoggedInAs}
										<icon icon="user-circle" class="app__userNav__isLoggedInAsWarning"></icon>
									{/if}
									<span class="-screenReader">{$currentUser->getData('username')}</span>*}
								</a>
								<ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end" aria-labelledby="dropdownMenuButton">
									{if $supportedLocales|@count > 1}
										{foreach from=$supportedLocales item="locale" key="localeKey"}
											<li>
												<a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path=$localeKey}" class="dropdown-item">
													{if $localeKey == $currentLocale}
														<!--icon icon="check" :inline="true"></icon-->
														<input type="checkbox" class="form-check-input" checked="" disabled="">
														{$locale|escape}
													{else}
														<input type="checkbox" class="form-check-input" disabled="">
														{$locale|escape}
													{/if}
												</a>
											</li>
										{/foreach}
										<li>
											<hr class="dropdown-divider" />
										</li>
									{/if}
									{if $isUserLoggedInAs}
										<li>
											{translate key="manager.people.signedInAs" username=$currentUser->getData('username')}
											<a href="{url router=$smarty.const.ROUTE_PAGE page="login" op="signOutAsUser"}" class="app__userNav__logOutAs">{translate key="user.logOutAs" username=$currentUser->getData('username')}</a>.
										</li>
									{/if}
									<li v-if="backToDashboardLink">
										<a :href="backToDashboardLink.url" class="dropdown-item">
											{{ backToDashboardLink.name }}
										</a>
									</li>
									<li>
										<a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="profile"}" class="dropdown-item">
											{translate key="user.profile.editProfile"}
										</a>
									</li>
									<li>
										{if $isUserLoggedInAs}
											<a href="{url router=$smarty.const.ROUTE_PAGE page="login" op="signOutAsUser"}" class="dropdown-item">
												{translate key="user.logOutAs" username=$currentUser->getData('username')}
											</a>
										{else}
											<a href="{url router=$smarty.const.ROUTE_PAGE page="login" op="signOut"}" class="dropdown-item">
												{translate key="user.logOut"}
											</a>
										{/if}
									</li>
								</ul>
							</div>
						{/if}
					</div>
				</div>
			</nav>
		</header>

		{* Swap the navigation menu for a back-to-dashboard link when only one item exists *}
		<nav v-if="backToDashboardLink" class="app__returnHeader" aria-label="{translate key="common.navigation.site"}">
			<a class="app__returnHeaderLink" :href="backToDashboardLink.url">
				{{ backToDashboardLabel }}
			</a>
		</nav>

		<div class="app__body">

			<main class="app__main">
				<div class="app__page{if $pageWidth} app__page--{$pageWidth}{/if}">
					{block name="breadcrumbs"}
						{if $breadcrumbs}
							<nav class="app__breadcrumbs" role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
								<ol>
									{foreach from=$breadcrumbs item="breadcrumb" name="breadcrumbs"}
										<li>
											{if $smarty.foreach.breadcrumbs.last}
												<span aria-current="page">{$breadcrumb.name|escape}</span>
											{else}
												<a href="{$breadcrumb.url|escape}">
													{$breadcrumb.name|escape}
												</a>
												<span class="app__breadcrumbsSeparator" aria-hidden="true">{translate key="navigation.breadcrumbSeparator"}</span>
											{/if}
										</li>
									{/foreach}
								</ol>
							</nav>
						{/if}
					{/block}

					{block name="page"}{/block}

				</div>
			</main>
		</div>
		<div
			aria-live="polite"
			aria-atomic="true"
			class="app__notifications"
			ref="notifications"
			role="status"
		>
			<transition-group name="app__notification">
				<notification v-for="notification in notifications" :key="notification.key" :type="notification.type" :can-dismiss="true" @dismiss="dismissNotification(notification.key)">
					{{ notification.message }}
				</notification>
			</transition-group>
		</div>
	</div>

	<script type="text/javascript">
		pkp.registry.init('app', {$pageComponent|json_encode}, {$state|json_encode});
	</script>

	<script type="text/javascript">
		// Initialize JS handler
		$(function() {ldelim}
			$('#pkpHelpPanel').pkpHandler(
				'$.pkp.controllers.HelpPanelHandler',
				{ldelim}
					helpUrl: {url|json_encode page="help" escape=false},
					helpLocale: '{$currentLocale|substr:0:2}',
				{rdelim}
			);
		{rdelim});
	</script>
	<div id="pkpHelpPanel" class="pkp_help_panel" tabindex="-1">
		<div class="panel">
			<div class="header">
				<a href="#" class="pkpHomeHelpPanel home">
					{translate key="help.toc"}
				</a>
				<a href="#" class="pkpCloseHelpPanel close">
					{translate key="common.close"}
				</a>
			</div>
			<div class="content">
				{include file="common/loadingContainer.tpl"}
			</div>
			<div class="footer">
				<a href="#" class="pkpPreviousHelpPanel previous">
					{translate key="help.previous"}
				</a>
				<a href="#" class="pkpNextHelpPanel next">
					{translate key="help.next"}
				</a>
			</div>
		</div>
	</div>

</body>
{load_script context="backend-onload"}
</html>
