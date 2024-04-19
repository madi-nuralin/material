 * @file /templates/frontend/components/ui/materialLabel.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Smarty function to generate a custom input component
 * Usage: {material_label name="labelName" for="labelFor" value="labelValue"}
 *}
{function material_label id name for class value}
  <label class="{$class} shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
    id="{$id}"
    name="{$name}"
    for="{$for}">
    {$value}
  </label>
{/function}
