{*
 * @file /templates/frontend/components/ui/materialInput.tpl
 *
 * Copyright (c) 2024 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Smarty function to generate a custom input component
 * Usage: {material_input name="inputName" placeholder="Enter text..."}
 *}
{function material_input id name class type value maxlength required ariaRequired autocomplete placeholder}
  {assign var="materialBaseColour" value=$activeTheme->getOption('materialBaseColour')}
  <input class="{$class} border-gray-300 focus:border-{$materialBaseColour}-300 focus:ring focus:ring-{$materialBaseColour}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white"
    {if isset($id)}
      id="{$id}"
    {/if}
    {if isset($name)}
      name="{$name}"
    {/if}
    {if isset($type)}
      type="{$type}"
    {/if}
    {if isset($value)}
      value="{$value|default:""|escape}"
    {/if}
    {if isset($maxlength)}
      maxlength="{$maxlength|escape}"
    {/if}
    {if isset($required)}
      required
    {/if}
    {if isset($ariaRequired)}
      aria-required="{$ariaRequired}"
    {/if}
    {if isset($autocomplete)}
      autocomplete="{$autocomplete}"
    {/if}
    {if isset($placeholder)}
      placeholder="{$placeholder|escape}"
    {/if}
  />
{/function}
