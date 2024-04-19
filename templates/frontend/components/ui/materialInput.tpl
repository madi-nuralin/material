{*
 * @file /templates/frontend/components/ui/materialInput.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Smarty function to generate a custom input component
 * Usage: {material_input name="inputName" placeholder="Enter text..."}
 *}
{function material_input id name class type placeholder}
  <input class="{$class} shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
    id="{$id}"
    name="{$name}"
    type="{$type}"
    placeholder="{$placeholder}">
{/function}
