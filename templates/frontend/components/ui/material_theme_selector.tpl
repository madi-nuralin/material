{* @file /templates/frontend/components/ui/material_theme_selector.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Theme selector (dark, light and system)
 *}

<div>
  <button class="flex h-8 w-8 items-center justify-center rounded-xl shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5" aria-label="Theme" id="headlessui-listbox-button-:r1:" type="button" aria-haspopup="listbox" aria-expanded="false" data-headlessui-state="" aria-labelledby="headlessui-listbox-label-:r0: headlessui-listbox-button-:r1:" {literal}@click="darkMode = darkMode === 'light' ? 'dark' : darkMode === 'dark' ? 'system' : 'light'"{/literal}>
    <div {literal}x-show="darkMode && darkMode == 'light'"{/literal}>
      {include file="frontend/components/ui/material_icon_light.tpl"}
    </div>
    <div {literal}x-show="darkMode && darkMode == 'dark'"{/literal}>
      {include file="frontend/components/ui/material_icon_dark.tpl"}
    </div>
    <div {literal}x-show="!darkMode || darkMode === 'system'"{/literal}>
      {include file="frontend/components/ui/material_icon_system.tpl"}
    </div>
  </button>
</div>
