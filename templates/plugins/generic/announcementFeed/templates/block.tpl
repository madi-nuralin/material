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
<li>
	<h3>
		<a class="font-normal text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300">
			{translate key="announcement.announcements"}
		</a>
	</h3>

	<ol role="list" class="mt-2 space-y-3 pl-5 text-slate-500 dark:text-slate-400">
		<li>
			<a class="hover:text-slate-600 dark:hover:text-slate-300" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"atom"}">
				<img src="{$baseUrl}/lib/pkp/templates/images/atom.svg" alt="{translate key="plugins.generic.announcementfeed.atom.altText"}">
			</a>
		</li>
		<li>
			<a class="hover:text-slate-600 dark:hover:text-slate-300" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"rss2"}">
				<img src="{$baseUrl}/lib/pkp/templates/images/rss20_logo.svg" alt="{translate key="plugins.generic.announcementfeed.rss2.altText"}">
			</a>
		</li>
		<li>
			<a class="hover:text-slate-600 dark:hover:text-slate-300" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"rss"}">
				<img src="{$baseUrl}/lib/pkp/templates/images/rss10_logo.svg" alt="{translate key="plugins.generic.announcementfeed.rss1.altText"}">
			</a>
		</li>
	</ol>
</li>