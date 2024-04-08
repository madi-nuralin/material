{**
 * templates/frontend/components/mobileNavigation.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief mobile navigation list for OJS
 *
 *}

<div class="mr-6 flex xl:hidden" {literal}x-data="{ open: false }"{/literal}>
	<button type="button"
		class="relative"
		aria-label="Open navigation"
		{literal}x-on:click="open = !open" x-show="!open"{/literal}>
		<svg aria-hidden="true"
			viewBox="0 0 24 24"
			fill="none"
			stroke-width="2"
			stroke-linecap="round"
			class="h-6 w-6 stroke-slate-500" {literal}x-show="!open"{/literal}>
			<path d="M4 7h16M4 12h16M4 17h16"></path>
		</svg>
	</button>

	<div class="fixed inset-0 z-50 flex items-start overflow-y-auto bg-slate-900/50 pr-10 backdrop-blur xl:hidden"
		aria-label="Navigation"
		id="headlessui-dialog-:R35la:"
		role="dialog"
		aria-modal="true"
		data-headlessui-state="open"
		x-show="open">
		<div class="min-h-full w-full max-w-xs bg-white px-4 pb-12 pt-5 sm:px-6 dark:bg-slate-900"
			id="headlessui-dialog-panel-:r3:"
			data-headlessui-state="open">
			<div class="flex items-center">
				<button type="button"
					class="relative"
					aria-label="Open navigation"
					{literal}x-on:click="open = !open" x-show="open"{/literal}>
					<svg aria-hidden="true"
						viewBox="0 0 24 24"
						fill="none"
						stroke-width="2"
						stroke-linecap="round"
						class="h-6 w-6 stroke-slate-500">
						<path d="M5 5l14 14M19 5l-14 14"></path>
					</svg>
				</button>
			</div>
			<div>
				<div class="mt-5 lg:hidden">
					{capture assign="primaryMenu"}
						{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
					{/capture}
					{$primaryMenu}
				</div>
				{include file="frontend/components/sidebar.tpl"}
			</div>
		</div>
	</div>
	<div style="position:fixed;top:1px;left:1px;width:1px;height:0;padding:0;margin:-1px;overflow:hidden;clip:rect(0, 0, 0, 0);white-space:nowrap;border-width:0;display:none">				
	</div>
</div>
