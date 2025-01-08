{* @file /templates/frontend/components/ui/material_icon_logo.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Svg logo icon
 *}

<svg xmlns="http://www.w3.org/2000/svg" class="{if $small===true}w-8 h-8{else}w-12 h-12{/if} text-{$activeTheme->getOption('materialBaseColour')}-400" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
	<circle cx="12" cy="12" r="10"></circle>
	<circle cx="12" cy="12" r="3"></circle>
</svg>
