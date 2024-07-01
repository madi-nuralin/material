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

		// Add usage stats display options
        $this->addOption('materialBaseColour', 'FieldOptions', [
            'type' => 'radio',
            'label' => 'Base colour',
            'options' => [
                [
                    'value' => 'green',
                    'label' => 'Green',
                ],
                [
                    'value' => 'indigo',
                    'label' => 'Indigo',
                ],
                [
                    'value' => 'blue',
                    'label' => 'Blue',
                ],
                [
                    'value' => 'sky',
                    'label' => 'Sky',
                ],
                [
                    'value' => 'orange',
                    'label' => 'Orange',
                ],
            ],
            'default' => 'sky',
        ]);

		$request = Application::get()->getRequest();

		$templateManager = TemplateManager::getManager($request);
		$templateManager->assign('jquery', $this->getJqueryPath($request));
		$templateManager->assign('jqueryUI', $this->getJqueryUIPath($request));

		$plugins = [
			'material_button_primary' => ['block', 'smartyMaterialButtonPrimary'],
			'material_label' => ['block', 'smartyMaterialLabel'],
			'material_select' => ['block', 'smartyMaterialSelect'],
			'material_input' => ['function', 'smartyMaterialInput'],
			'material_checkbox' => ['function', 'smartyMaterialCheckbox'],
			'material_select_date_a11y' => ['function', 'smartyMaterialSelectDateA11y']
		];

		foreach ($plugins as $key => $value) {
			$templateManager->unregisterPlugin($value[0], $key);
			$templateManager->registerPlugin($value[0], $key, [$this, $value[1]], false);
		}

		// Load primary stylesheet
		$this->addStyle('stylesheet', 'styles/dist/output.css');

		// Load alpinejs for this theme
		$this->addScript('alpinejs', 'js/alpinejs@3.x.x/dist/cdn.min.js');
		$this->addScript('mainjs', 'js/main.js');

		// Add navigation menu areas for this theme
		$this->addMenuArea(['primary', 'user']);
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
            throw new Exception('You must provide a prefix, legend, start_year and end_year when using html_select_date_a11y.');
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
}

if (!PKP_STRICT_MODE) {
	class_alias('\APP\plugins\themes\material\MaterialThemePlugin', '\MaterialThemePlugin');
}
