<?php

/**
 * @file plugins/themes/material/MaterialThemePlugin.inc.php
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class MaterialThemePlugin
 *
 * @brief Material theme
 */

namespace APP\plugins\themes\material;

use APP\core\Application;
use APP\file\PublicFileManager;
use PKP\config\Config;
use PKP\session\SessionManager;
use APP\template\TemplateManager;
use PKP\components\forms\context\PKPAppearanceForm;
use PKP\core\HookRegistry;
use PKP\core\PKPApplication;
use PKP\facades\Locale;
use PKP\plugins\Hook;
use PKP\statistics\PKPUsageStatsService;
use PKP\cache\CacheManager;
use PKP\plugins\PluginRegistry;
use PKP\db\DAORegistry;
use PKP\core\PKPTemplateManager;
use PKP\log\PKPLog;
use PKP\core\Core;
use APP\template\TemplateManager as AppTemplateManager;
use Exception;

class MaterialThemePlugin extends \PKP\plugins\ThemePlugin
{
    /**
     * @copydoc ThemePlugin::isActive()
     */
    public function isActive() {
        if (SessionManager::isDisabled()) {
            return true;
        }
        return parent::isActive();
    }

    /**
     * Initialize the theme's styles, scripts and hooks. This is run on the
     * currently active theme and it's parent themes.
     *
     */
    public function init() {

        // Register theme options
        $this->addOption('showDescriptionInJournalIndex', 'FieldOptions', [
            'label' => __('manager.setup.contextSummary'),
                'options' => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.material.option.showDescriptionInJournalIndex.option'),
                ],
            ],
            'default' => false,
        ]);
        $this->addOption('useHomepageImageAsHeader', 'FieldOptions', [
            'label' => __('plugins.themes.material.option.useHomepageImageAsHeader.label'),
            'description' => __('plugins.themes.material.option.useHomepageImageAsHeader.description'),
            'options' => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.material.option.useHomepageImageAsHeader.option')
                ],
            ],
            'default' => false,
        ]);

        // Add usage stats display options
        $this->addOption('materialBaseColour', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.material.option.colour.label'),
            'description' => __('plugins.themes.material.option.colour.description'),
            'options' => [
                [
                    'value' => 'green',
                    'label' => __('plugins.themes.material.option.colour.green'),
                ],
                [
                    'value' => 'blue',
                    'label' => __('plugins.themes.material.option.colour.blue'),
                ],
                [
                    'value' => 'sky',
                    'label' => __('plugins.themes.material.option.colour.sky'),
                ],
                [
                    'value' => 'indigo',
                    'label' => __('plugins.themes.material.option.colour.indigo'),
                ],
                [
                    'value' => 'orange',
                    'label' => __('plugins.themes.material.option.colour.orange'),
                ],
            ],
            'default' => 'sky',
        ]);

        // Add font selection option
        $this->addOption('materialFontFamily', 'FieldOptions', [
            'type' => 'select',
            'label' => __('plugins.themes.material.option.font.label'),
            'description' => __('plugins.themes.material.option.font.description'),
            'options' => [
                [
                    'value' => 'System Default',
                    'label' => __('plugins.themes.material.option.font.systemDefault'),
                ],
                // --- Local Fonts ---
                [
                    'value' => 'Comic Sans MS', // Matches directory name in /fonts/
                    'label' => 'Comic Sans MS (Local)', // Indicate it's local
                ],
                [
                    'value' => 'Monaco FB', // Matches directory name in /fonts/
                    'label' => 'Monaco FB (Local)', // Indicate it's local
                ],
                // --- Google Fonts ---
                [
                    'value' => 'Roboto', // Google Font example
                    'label' => 'Roboto (Google)',
                ],
                [
                    'value' => 'Lato', // Google Font example
                    'label' => 'Lato (Google)',
                ],
                [
                    'value' => 'Open Sans', // Google Font example
                    'label' => 'Open Sans (Google)',
                ],
                [
                    'value' => 'Source Sans Pro', // Google Font example
                    'label' => 'Source Sans Pro (Google)',
                ],
            ],
            'default' => 'System Default',
        ]);

        $request = Application::get()->getRequest();

        $templateManager = TemplateManager::getManager($request);
        $templateManager->assign('jquery', $this->getJqueryPath($request));
        $templateManager->assign('jqueryUI', $this->getJqueryUIPath($request));

        $plugins = [
            'material_button_primary' => ['block', 'smartyMaterialButtonPrimary'],
            'material_button_secondary' => ['block', 'smartyMaterialButtonSecondary'],
            'material_label' => ['block', 'smartyMaterialLabel'],
            'material_select' => ['block', 'smartyMaterialSelect'],
            'material_dropdown' => ['block', 'smartyMaterialDropdown'],
            'material_dropdown_trigger' => ['block', 'smartyMaterialDropdownTrigger'],
            'material_dropdown_body' => ['block', 'smartyMaterialDropdownBody'],
            'material_dropdown_item' => ['block', 'smartyMaterialDropdownItem'],
            'material_menu' => ['block', 'smartyMaterialMenu'],
            'material_menu_item' => ['block', 'smartyMaterialMenuItem'],
            'material_menu_link' => ['block', 'smartyMaterialMenuLink'],
            'material_submenu' => ['block', 'smartyMaterialSubmenu'],
            'material_submenu_item' => ['block', 'smartyMaterialSubmenuItem'],
            'material_submenu_link' => ['block', 'smartyMaterialSubmenuLink'],
            'material_sidestack' => ['block', 'smartyMaterialSidestack'],
            'material_input' => ['function', 'smartyMaterialInput'],
            'material_checkbox' => ['function', 'smartyMaterialCheckbox'],
            'material_select_date_a11y' => ['function', 'smartyMaterialSelectDateA11y']
        ];

        foreach ($plugins as $key => $value) {
            $templateManager->unregisterPlugin($value[0], $key);
            $templateManager->registerPlugin($value[0], $key, [$this, $value[1]], false);
        }

        // Get homepage image and use as header background if useAsHeader is true
        $context = Application::get()->getRequest()->getContext();
        if ($context) {
            if ($this->getOption('useHomepageImageAsHeader')) {
                if ($homepageImage = $context->getLocalizedData('homepageImage')) {
                    $publicFileManager = new PublicFileManager();
                    $publicFilesDir = $request->getBaseUrl() . '/' . $publicFileManager->getContextFilesPath($context->getId());
                    $homepageImageUrl = $publicFilesDir . '/' . $homepageImage['uploadName'];
                    $templateManager->assign('homepageImageUrl', $homepageImageUrl);
                }
            }   
        }

        $templateManager->assign('gradientImageUrl',
            $request->getBaseUrl() . '/plugins/themes/material/resources/gradient-noise-purple.png');

        // Load primary stylesheet
        $this->addStyle('stylesheet', 'styles/dist/output.css');

        // Load alpinejs for this theme
        $this->addScript('alpinejs', 'js/alpinejs@3.x.x/dist/cdn.min.js');
        $this->addScript('mainjs', 'js/main.js');

        // Add navigation menu areas for this theme
        $this->addMenuArea(['primary', 'user']);

        // Add hooks
        Hook::add('TemplateManager::display', [$this, 'addSiteWideData']);
        Hook::add('Form::config::before', [$this, 'addAppearanceFormFields']);

        // Hook for adding font styles
        Hook::add('Templates::Common::Header::Includes', [$this, '_addFontStyles']);

        // Hook for adding galley stats
        Hook::add('ArticleHandler::view::articleData', [$this, '_addGalleyStats']);
    }

    /**
     * Get the name of the settings file to be installed on new journal
     * creation.
     *
     * @return string
     */
    public function getContextSpecificPluginSettingsFile() {
        return $this->getPluginPath() . '/settings.xml';
    }

    /**
     * Get the name of the settings file to be installed site-wide when
     * OJS is installed.
     *
     * @return string
     */
    public function getInstallSitePluginSettingsFile() {
        return $this->getPluginPath() . '/settings.xml';
    }

    /**
     *
     * Get the display name of this plugin
     *
     * @return string
     */
    public function getDisplayName() {
        return __('plugins.themes.material.name');
    }

    /**
     * Get the description of this plugin
     *
     * @return string
     */
    public function getDescription() {
        return __('plugins.themes.material.description');
    }

    /**
     * Get the jquery path
     *
     * @return string
     */
    public function getJqueryPath($request) {
        $min = Config::getVar('general', 'enable_minified') ? '.min' : '';
        return $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jquery/jquery' . $min . '.js';
    }

    /**
     * Get the jqueryUI path
     *
     * @return string
     */
    public function getJqueryUIPath($request) {
        $min = Config::getVar('general', 'enable_minified') ? '.min' : '';
        return $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jqueryui/jquery-ui' . $min . '.js';
    }

    public function smartyMaterialButtonPrimary($params, $content, $smarty, &$repeat) {
        $default = "";
        $default .= " rounded-full";
        $default .= " bg-{$this->getOption('materialBaseColour')}-300";
        $default .= " py-2";
        $default .= " px-4";
        $default .= " text-sm";
        $default .= " font-semibold";
        $default .= " text-slate-900";
        $default .= " hover:bg-{$this->getOption('materialBaseColour')}-200";
        $default .= " focus:outline-none";
        $default .= " focus-visible:outline-2";
        $default .= " focus-visible:outline-offset-2";
        $default .= " focus-visible:outline-{$this->getOption('materialBaseColour')}-300/50";
        $default .= " active:bg-{$this->getOption('materialBaseColour')}-500";

        $attributes = array();
        array_push($attributes, 'id');
        array_push($attributes, 'name');
        array_push($attributes, 'type');

        $sa = '';
        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        if (!$repeat) {
            return "$content</button>";
        } else {
            return "<button $sa>";
        }
    }

    public function smartyMaterialButtonSecondary($params, $content, $smarty, &$repeat) {
        $default = "flex h-8 items-center justify-center rounded-lg shadow-md shadow-black/5 ring-1
            ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5 px-3 text-sm
            dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300";

        $attributes = ['id', 'name', 'type'];

        $sa = '';
        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        if (!$repeat) {
            return "$content</button>";
        } else {
            return "<button $sa>";
        }
    }

    public function smartyMaterialLabel($params, $content, $smarty, &$repeat) {
        $default = "";
        $default .= " leading-none";
        $default .= " font-medium";
        $default .= " text-sm";
        $default .= " text-gray-700";
        $default .= " dark:text-gray-400";

        $attributes = array();
        array_push($attributes, 'id');
        array_push($attributes, 'name');
        array_push($attributes, 'for');

        $sa = '';
        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        if (!$repeat) {
            return "$content</label>";
        } else {
            return "<label $sa>";
        }
    }

    public function smartyMaterialSelect($params, $content, $smarty, &$repeat) {
        $default = "";
        $default .= " border-gray-300";
        $default .= " focus:border-{$this->getOption('materialBaseColour')}-300";
        $default .= " focus:ring";
        $default .= " focus:ring-{$this->getOption('materialBaseColour')}-200";
        $default .= " focus:ring-opacity-50";
        $default .= " rounded-md";
        $default .= " shadow-sm";
        $default .= " dark:bg-gray-800";
        $default .= " dark:border-gray-500";
        $default .= " dark:text-white";

        $attributes = array();
        array_push($attributes, 'id');
        array_push($attributes, 'type');
        array_push($attributes, 'name');
        array_push($attributes, 'checked');
        array_push($attributes, 'required');
        array_push($attributes, 'maxlength');
        array_push($attributes, 'autocomplete');
        array_push($attributes, 'aria-required');

        $sa = '';
        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        if (!$repeat) {
            return "$content</select>";
        } else {
            return "<select $sa>";
        }
    }

    public function smartyMaterialDropdown($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</div>";
        } else {
            return "<div x-data=\"{ open: false }\" class=\"relative text-left\">";
        }
    }

    public function smartyMaterialDropdownTrigger($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a>";
        } else {
            return <<<HTML
                <a @mouseover="open = true" @mouseleave="open = false" href="{$params['url']}"
                    class="flex h-8 items-center text-slate-500 justify-center rounded-xl shadow-md shadow-black/5 ring-1
                        ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5 px-3 text-sm
                        dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300">
            HTML;
        }
    }

    public function smartyMaterialDropdownBody($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</ul></div>";
        } else {
            return <<<HTML
                <div @mouseover="open = true" @mouseleave="open = false" x-show="open"
                    x-transition:enter="transition ease-out duration-300" 
                    x-transition:enter-start="opacity-0 transform -translate-y-2" 
                    x-transition:enter-end="opacity-100 transform translate-y-0" 
                    x-transition:leave="transition ease-in duration-200" 
                    x-transition:leave-start="opacity-100 transform translate-y-0" 
                    x-transition:leave-end="opacity-0 transform -translate-y-2"
                    class="absolute right-0 z-10 mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg
                        ring-1 ring-black ring-opacity-5 focus:outline-none dark:bg-slate-800">
                    <ul class="py-1" role="list">
            HTML;
        }
    }

    public function smartyMaterialDropdownItem($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a></li>";
        } else {
            return <<<HTML
                <li class="{$params['class']}">
                    <a href="{$params['url']}" class="text-gray-700 dark:text-gray-400 block px-4 py-2 text-sm">
            HTML;
        }
    }

    public function smartyMaterialMenu($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</ul>";
        } else {
            return <<<HTML
                <ul id="{$params['id']}" role="list" class="{$params['class']} space-y-9">
            HTML;
        }
    }

    public function smartyMaterialMenuItem($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</li>";
        } else {
            return <<<HTML
                <li class="{$params['class']}">
            HTML;
        }
    }

    public function smartyMaterialMenuLink($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a>";
        } else {
            return <<<HTML
                <a href="{$params['url']}" class="font-display font-medium text-slate-900 dark:text-white">
            HTML;
        }
    }

    public function smartyMaterialSubmenu($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</ul>";
        } else {
            return <<<HTML
                <ul role="list" class="mt-2 space-y-2 border-l-2 border-slate-100 lg:mt-4 lg:space-y-4 lg:border-slate-200 dark:border-slate-800">
            HTML;
        }
    }

    public function smartyMaterialSubmenuItem($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</li>";
        } else {
            return <<<HTML
                <li class="{$params['class']} relative">
            HTML;
        }
    }

    public function smartyMaterialSubmenuLink($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a>";
        } else {
            return <<<HTML
                <a href="{$params['url']}" class="block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full text-slate-500 before:hidden before:bg-slate-300 hover:text-slate-600 hover:before:block dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300">
            HTML;
        }
    }

    public function smartyMaterialSidestack($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return <<<HTML
                                $content
                            </div>
                        </div>
                    </div>
                    <div style="position:fixed;top:1px;left:1px;width:1px;height:0;padding:0;margin:-1px;overflow:hidden;clip:rect(0, 0, 0, 0);white-space:nowrap;border-width:0;display:none">             
                    </div>
                </div>
            HTML;
        } else {
            return <<<HTML
                <div class="mr-6 {$params['class']}" x-data="{ open: false }">
                    <button type="button"
                        class="relative"
                        aria-label="Open navigation"
                        x-on:click="open = !open" x-show="!open">
                        <svg aria-hidden="true"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke-width="2"
                            stroke-linecap="round"
                            class="h-6 w-6 stroke-slate-500" x-show="!open">
                            <path d="M4 7h16M4 12h16M4 17h16"></path>
                        </svg>
                    </button>

                    <div class="h-screen fixed inset-0 z-50 flex items-start overflow-y-auto bg-slate-900/50 pr-10 backdrop-blur xl:hidden"
                        aria-label="Navigation"
                        id="headlessui-dialog-:R35la:"
                        role="dialog"
                        aria-modal="true"
                        data-headlessui-state="open"
                        x-show="open"
                        x-transition:enter="transition-transform transition-opacity ease-out duration-300" 
                        x-transition:enter-start="-translate-x-full opacity-0 blur-sm"
                        x-transition:enter-end="translate-x-0 opacity-100 blur-none"
                        x-transition:leave="transition-transform transition-opacity ease-in duration-300"
                        x-transition:leave-start="translate-x-0 opacity-100 blur-none"
                        x-transition:leave-end="-translate-x-full opacity-0 blur-sm">
                        <div class="min-h-full w-full max-w-xs bg-white px-4 pb-12 pt-5 sm:px-8 dark:bg-slate-900"
                            id="headlessui-dialog-panel-:r3:"
                            data-headlessui-state="open">
                            <div class="flex items-center flex h-8 w-8 items-center justify-center border border-slate-200 dark:border-slate-700 rounded-xl shadow-sm shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5">
                                <button type="button"
                                    class="relative"
                                    aria-label="Open navigation"
                                    x-on:click="open = !open" x-show="open">
                                    <svg aria-hidden="true"
                                        viewBox="0 0 24 24"
                                        fill="none"
                                        stroke-width="2"
                                        stroke-linecap="round"
                                        class="h-6 w-6 stroke-slate-500 hover:stroke-slate-600">
                                        <path d="M5 5l14 14M19 5l-14 14"></path>
                                    </svg>
                                </button>
                            </div>
                            <div class="pt-5" id="headlessui-dialog-panel-:r4:">
            HTML;
        }
    }

    public function smartyMaterialInput($params, $smarty) {
        $default = "";
        $default .= " border-gray-300";
        $default .= " focus:border-{$this->getOption('materialBaseColour')}-300";
        $default .= " focus:ring";
        $default .= " focus:ring-{$this->getOption('materialBaseColour')}-200";
        $default .= " focus:ring-opacity-50";
        $default .= " rounded-md";
        $default .= " shadow-sm";
        $default .= " dark:bg-gray-800";
        $default .= " dark:border-gray-500";
        $default .= " dark:text-white";

        $attributes = array();
        array_push($attributes, 'id');
        array_push($attributes, 'type');
        array_push($attributes, 'name');
        array_push($attributes, 'checked');
        array_push($attributes, 'required');
        array_push($attributes, 'maxlength');
        array_push($attributes, 'autocomplete');
        array_push($attributes, 'aria-required');
        array_push($attributes, 'placeholder');

        $sa = '';
        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        return "<input $sa>";
    }

    public function smartyMaterialCheckbox($params, $smarty) {
        $default = "";
        $default .= " rounded-md";
        $default .= " border-gray-300";
        $default .= " text-{$this->getOption('materialBaseColour')}-600";
        $default .= " shadow-sm";
        $default .= " focus:border-{$this->getOption('materialBaseColour')}-300";
        $default .= " focus:ring";
        $default .= " focus:ring-{$this->getOption('materialBaseColour')}-200";
        $default .= " focus:ring-opacity-50";
        $default .= " dark:bg-gray-800";

        $attributes = array();
        array_push($attributes, 'id');
        array_push($attributes, 'name');
        array_push($attributes, 'value');
        array_push($attributes, 'checked');
        array_push($attributes, 'required');

        $sa = '';

        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        return "<input type=\"checkbox\" $sa>";
    }

    public function smartyMaterialSelectDateA11y($params, $smarty)
    {
        $default = "";
        $default .= " border-gray-300";
        $default .= " focus:border-{$this->getOption('materialBaseColour')}-300";
        $default .= " focus:ring";
        $default .= " focus:ring-{$this->getOption('materialBaseColour')}-200";
        $default .= " focus:ring-opacity-50";
        $default .= " rounded-md";
        $default .= " shadow-sm";
        $default .= " dark:bg-gray-800";
        $default .= " dark:border-gray-500";
        $default .= " dark:text-white";

        if (!isset($params['prefix'], $params['legend'], $params['start_year'], $params['end_year'])) {
            throw new \Exception('You must provide a prefix, legend, start_year and end_year when using html_select_date_a11y.');
        }
        $prefix = $params['prefix'];
        $legend = $params['legend'];
        $time = $params['time'] ?? '';
        $startYear = $params['start_year'];
        $endYear = $params['end_year'];
        $yearEmpty = $params['year_empty'] ?? '';
        $monthEmpty = $params['month_empty'] ?? '';
        $dayEmpty = $params['day_empty'] ?? '';
        $yearLabel = $params['year_label'] ?? __('common.year');
        $monthLabel = $params['month_label'] ?? __('common.month');
        $dayLabel = $params['day_label'] ?? __('common.day');

        $years = [];
        $i = $startYear;
        while ($i <= $endYear) {
            $years[$i] = $i;
            $i++;
        }

        $months = [];
        for ($i = 1; $i <= 12; $i++) {
            $months[$i] = date('M', strtotime('2020-' . $i . '-01'));
        }

        $days = [];
        for ($i = 1; $i <= 31; $i++) {
            $days[$i] = $i;
        }

        $currentYear = $currentMonth = $currentDay = '';
        if ($time) {
            $currentYear = (int) substr($time, 0, 4);
            $currentMonth = (int) substr($time, 5, 2);
            $currentDay = (int) substr($time, 8, 2);
        }

        $output = '<fieldset><legend>' . $legend . '</legend>';
        $output .= '<div class="space-x-2">';
        //$output .= '<label for="' . $prefix . 'Year">' . $yearLabel . '</label>';
        $output .= '<select id="' . $prefix . 'Year" name="' . $prefix . 'Year" class="' . $default . '">';
        $output .= '<option>' . $yearEmpty . '</option>';
        foreach ($years as $value => $label) {
            $selected = $currentYear === $value ? ' selected' : '';
            $output .= '<option value="' . $value . '"' . $selected . '>' . $label . '</option>';
        }
        $output .= '</select>';
        //$output .= '<label for="' . $prefix . 'Month">' . $monthLabel . '</label>';
        $output .= '<select id="' . $prefix . 'Month" name="' . $prefix . 'Month" class="' . $default . '">';
        $output .= '<option>' . $monthEmpty . '</option>';
        foreach ($months as $value => $label) {
            $selected = $currentMonth === $value ? ' selected' : '';
            $output .= '<option value="' . $value . '"' . $selected . '>' . $label . '</option>';
        }
        $output .= '</select>';
        //$output .= '<label for="' . $prefix . 'Day">' . $dayLabel . '</label>';
        $output .= '<select id="' . $prefix . 'Day" name="' . $prefix . 'Day" class="' . $default . '">';
        $output .= '<option>' . $dayEmpty . '</option>';
        foreach ($days as $value => $label) {
            $selected = $currentDay === $value ? ' selected' : '';
            $output .= '<option value="' . $value . '"' . $selected . '>' . $label . '</option>';
        }
        $output .= '</select>';
        $output .= '</div>';
        $output .= '</fieldset>';

        return $output;
    }

    /**
     * Add font styles to the header
     *
     * @param string $hookName
     * @param array $params
     * @return bool
     */
    public function _addFontStyles($hookName, $params)
    {
        $templateMgr = $params[0];
        $selectedFont = $this->getOption('materialFontFamily');
        $fontStyles = ''; // Initialize CSS string

        if ($selectedFont && $selectedFont !== 'System Default') {

            // Define Google Fonts and their URL parameters
            $googleFonts = [
                'Roboto' => 'Roboto:wght@400;700',
                'Lato' => 'Lato:wght@400;700',
                'Open Sans' => 'Open+Sans:wght@400;700',
                'Source Sans Pro' => 'Source+Sans+Pro:wght@400;700',
            ];

            // Define Local Fonts (Key should match option value and directory name)
            // Value could be more complex later (e.g., array of file names/weights)
            $localFonts = [
                'Comic Sans MS' => 'comicsans', // Base filename assumed (e.g., comicsans.woff2)
                'Monaco FB' => 'monacofb',     // Base filename assumed (e.g., monacofb.woff2)
            ];

            $request = Application::get()->getRequest();
            $baseUrl = $request->getBaseUrl();
            $pluginPath = $this->getPluginPath();
            $fontBaseUrl = $baseUrl . '/' . $pluginPath . '/fonts/';

            // Check if selected font is a Google Font
            if (array_key_exists($selectedFont, $googleFonts)) {
                $fontParam = $googleFonts[$selectedFont];
                $templateMgr->addStyleSheet(
                    'googleFont-' . $selectedFont,
                    'https://fonts.googleapis.com/css2?family=' . $fontParam . '&display=swap',
                    ['inline' => false]
                );
            // Check if selected font is a Local Font
            } elseif (array_key_exists($selectedFont, $localFonts)) {
                $fontDir = $selectedFont; // Directory name matches the option value
                $fontFileNameBase = $localFonts[$selectedFont]; // Base filename

                // Construct @font-face rule (prioritize woff2, fallback to woff/ttf if needed)
                // NOTE: Assumes standard file naming like 'comicsans.woff2', 'comicsans.woff', etc.
                // You might need to adjust this based on your actual font file names.
                $fontFaceRule = "@font-face {\n";
                $fontFaceRule .= "  font-family: '" . $selectedFont . "';\n"; // Use the selected name
                $fontFaceRule .= "  src: ";
                $sources = [];
                // Add more formats/weights/styles as needed
                $sources[] = "url('" . $fontBaseUrl . $fontDir . "/" . $fontFileNameBase . ".woff2') format('woff2')";
                // Example fallbacks (uncomment/add if you have these files):
                // $sources[] = "url('" . $fontBaseUrl . $fontDir . "/" . $fontFileNameBase . ".woff') format('woff')";
                // $sources[] = "url('" . $fontBaseUrl . $fontDir . "/" . $fontFileNameBase . ".ttf') format('truetype')";
                $fontFaceRule .= implode(",\n       ", $sources) . ";\n";
                $fontFaceRule .= "  font-weight: normal;\n"; // Adjust if needed
                $fontFaceRule .= "  font-style: normal;\n";  // Adjust if needed
                $fontFaceRule .= "  font-display: swap;\n";
                $fontFaceRule .= "}\n";

                $fontStyles .= $fontFaceRule;

                // Add rules for bold/italic if separate files exist and are needed
                // Example for bold (assuming 'comicsans_bold.woff2'):
                /*
                $fontFaceRuleBold = "@font-face {\n";
                $fontFaceRuleBold .= "  font-family: '" . $selectedFont . "';\n";
                $fontFaceRuleBold .= "  src: url('" . $fontBaseUrl . $fontDir . "/" . $fontFileNameBase . "_bold.woff2') format('woff2');\n"; // Adjust filename
                $fontFaceRuleBold .= "  font-weight: bold;\n";
                $fontFaceRuleBold .= "  font-style: normal;\n";
                $fontFaceRuleBold .= "  font-display: swap;\n";
                $fontFaceRuleBold .= "}\n";
                $fontStyles .= $fontFaceRuleBold;
                */
            }

            // Add inline style to apply the font-family to the body
            $fontStack = $selectedFont === 'System Default' ?
                'ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"' :
                "'" . $selectedFont . "', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, \"Helvetica Neue\", Arial, \"Noto Sans\", sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""; // Ensure the selected font is first

            $fontStyles .= "body { font-family: {$fontStack}; }\n";

            // Add all generated styles (including @font-face and body rule) to header
            if (!empty($fontStyles)) {
                $templateMgr->addHeader('materialThemeFontStyles', "<style>\n" . $fontStyles . "</style>");
            }
        }

        return false; // Continue processing hooks
    }

    /**
     * Add galley download statistics to the article view template (Refactored Version)
     *
     * @param string $hookName
     * @param array $params Hook parameters ($article, $issue, $galley)
     * @return bool
     */
    public function _addGalleyStats($hookName, $params)
    {
        $templateMgr = PKPTemplateManager::getManager(); // Or use AppTemplateManager if appropriate
        $article = $params[0];
        $galleys = $article->getGalleys();
        $statsArray = [];

        if (empty($galleys)) {
            $templateMgr->assign('galleyStats', $statsArray);
            return false;
        }

        // --- Dependency Checks ---
        $usageStatsPlugin = PluginRegistry::getPlugin('generic', 'usageStatsPlugin');
        if (!$usageStatsPlugin || !$usageStatsPlugin->getEnabled()) {
            PKPLog::log('Material Theme: Usage Statistics plugin is not enabled. Skipping galley stats.');
            $templateMgr->assign('galleyStats', $statsArray);
            return false;
        }
        if (!class_exists('\PKP\statistics\PKPUsageStatsService') || !DAORegistry::getDAO('MetricsDAO')) {
             PKPLog::log('Material Theme: Required statistics classes or DAO not found. Skipping galley stats.');
             $templateMgr->assign('galleyStats', $statsArray);
             return false;
        }
        // --- End Dependency Checks ---

        $context = PKPApplication::getRequest()->getContext();
        $contextId = $context ? $context->getId() : Core::CONTEXT_ID_NONE;
        $articleId = $article->getId();

        // --- Caching Logic ---
        $cacheManager = CacheManager::getManager();
        $cache = $cacheManager->getFileCache(); // Or getMemcacheCache(), getAPCCache() if configured
        $cacheKey = 'material_galley_stats_' . $contextId . '_' . $articleId;
        $cachedStats = $cache->getCache($cacheKey);

        if ($cachedStats !== null) {
            $templateMgr->assign('galleyStats', $cachedStats);
            return false; // Found in cache, no need to query
        }
        // --- End Caching Logic ---

        try {
            $galleyIds = array_map(function($galley) { return $galley->getId(); }, $galleys);

            $metricsDao = DAORegistry::getDAO('MetricsDAO');
            $metricsResult = $metricsDao->getMetrics(
                PKPApplication::ASSOC_TYPE_GALLEY,
                $contextId,
                $galleyIds,
                null, // submission_id (not needed when querying by galley IDs)
                null, // issue_id (not needed)
                null, // country_id (not needed)
                null, // file_type (not needed)
                null, // assoc_object_type (not needed)
                null, // assoc_object_id (not needed)
                null, // date_start (null for all time)
                null, // date_end (null for all time)
                PKPUsageStatsService::METRIC_TYPE_COUNTER // Standard download metric type
            );

            // Process results into the desired array format [galleyId => count]
            foreach ($metricsResult as $row) {
                $galleyId = (int) $row['assoc_id'];
                $count = (int) $row['metric'];
                if (!isset($statsArray[$galleyId])) {
                    $statsArray[$galleyId] = 0;
                }
                $statsArray[$galleyId] += $count;
            }

            // Store the fetched results in cache for 1 hour (3600 seconds)
            $cache->setCache($cacheKey, $statsArray, 3600);

        } catch (\Exception $e) {
            PKPLog::log('Material Theme: Error fetching galley statistics for article ID ' . $articleId . ': ' . $e->getMessage());
            $statsArray = []; // Ensure an empty array is assigned on error
        }

        $templateMgr->assign('galleyStats', $statsArray);

        return false; // Continue processing hooks
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\themes\material\MaterialThemePlugin', '\MaterialThemePlugin');
}
