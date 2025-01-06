{**
 * plugins/generic/announcementFeed/templates/block.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Announcement feed plugin navigation sidebar.
 *
 *}

{material_menu_item}
	{material_menu_link}
		{translate key="announcement.announcements"}
	{/material_menu_link}

	{material_submenu}
		{material_submenu_item}
			{material_submenu_link url="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"atom"}"}
				<img src="{$baseUrl}/lib/pkp/templates/images/atom.svg" alt="{translate key="plugins.generic.announcementfeed.atom.altText"}">
			{/material_submenu_link}
		{/material_submenu_item}
		{material_submenu_item}
			{material_submenu_link url="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"rss2"}"}
				<img src="{$baseUrl}/lib/pkp/templates/images/rss20_logo.svg" alt="{translate key="plugins.generic.announcementfeed.rss2.altText"}">
			{/material_submenu_link}
		{/material_submenu_item}
		{material_submenu_item}
			{material_submenu_link url="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"rss"}"}
				<img src="{$baseUrl}/lib/pkp/templates/images/rss10_logo.svg" alt="{translate key="plugins.generic.announcementfeed.rss1.altText"}">
			{/material_submenu_link}
		{/material_submenu_item}
	{/material_submenu}
{/material_menu_item}
