{* @file /templates/frontend/components/ui/material_label.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Smarty function to generate a custom input component
 * Usage: {material_label name="labelName" for="labelFor" value="labelValue"}
 *}
{function material_label id name for class value}
  <label class="{$class|escape} block font-medium text-sm text-gray-700 dark:text-gray-400"
    id="{$id}"
    name="{$name}"
    for="{$for}">
    {$value|escape}
  </label>
{/function}
