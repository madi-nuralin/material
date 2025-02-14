{* @file /templates/frontend/components/ui/material_icon_dark.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Svg dark icon
 *}
{assign var="materialBaseColour" value=$activeTheme->getOption('materialBaseColour')}

<svg aria-hidden="true" viewBox="0 0 16 16" class="h-4 w-4 fill-{$materialBaseColour}-400">
  <path
    fillRule="evenodd"
    clipRule="evenodd"
    d="M7.23 3.333C7.757 2.905 7.68 2 7 2a6 6 0 1 0 0 12c.68 0 .758-.905.23-1.332A5.989 5.989 0 0 1 5 8c0-1.885.87-3.568 2.23-4.668ZM12 5a1 1 0 0 1 1 1 1 1 0 0 0 1 1 1 1 0 1 1 0 2 1 1 0 0 0-1 1 1 1 0 1 1-2 0 1 1 0 0 0-1-1 1 1 0 1 1 0-2 1 1 0 0 0 1-1 1 1 0 0 1 1-1Z"
  />
</svg>
