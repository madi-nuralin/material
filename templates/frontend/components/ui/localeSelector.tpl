{*assign var="locales" value=$currentJournal->getSupportedLocaleNames()*}
{*foreach from=$locales item=localeName key=localeKey}
          <li class="locale_{$localeKey|escape}{if $localeKey == $currentLocale} current{/if}" lang="{$localeKey|replace:"_":"-"}">
            <a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path=$localeKey source=$smarty.server.REQUEST_URI}" class="dropdown-item">
              {$localeName}
            </a>
          </li>
        {/foreach*}

<button class="flex h-8 w-8 items-center justify-center rounded-lg shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5" aria-label="Theme" id="headlessui-listbox-button-:r1:" type="button" aria-haspopup="listbox" aria-expanded="false" data-headlessui-state="" aria-labelledby="headlessui-listbox-label-:r0: headlessui-listbox-button-:r1:">
  {include file="frontend/components/ui/compassIcon.tpl"}
</button>
