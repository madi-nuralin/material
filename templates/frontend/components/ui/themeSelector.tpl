{assign var="active" value='Light'}

{foreach $themes as $theme}
  {if $active == $theme.name}
    <button class="flex h-8 w-8 items-center justify-center rounded-lg shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5" aria-label="Theme" id="headlessui-listbox-button-:r1:" type="button" aria-haspopup="listbox" aria-expanded="false" data-headlessui-state="" aria-labelledby="headlessui-listbox-label-:r0: headlessui-listbox-button-:r1:" onclick="document.documentElement.classList.add('dark')">
      {include file=$theme.path}
    </button>
  {/if}
{/foreach}