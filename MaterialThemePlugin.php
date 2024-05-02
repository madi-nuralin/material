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
        $this->addOption('baseColour2', 'FieldOptions', [
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
		//$templateManager->assign('', obj);
		$templateManager->registerPlugin('block', 'material_button_primary', [$this, 'smartyMaterialButtonPrimary'], false);
		$templateManager->registerPlugin('block', 'material_label', [$this, 'smartyMaterialLabel'], false);
		$templateManager->registerPlugin('block', 'material_select', [$this, 'smartyMaterialSelect'], false);
		$templateManager->registerPlugin('function', 'material_input', [$this, 'smartyMaterialInput']);
		$templateManager->registerPlugin('function', 'material_checkbox', [$this, 'smartyMaterialCheckbox']);

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

	public function smartyMaterialButtonPrimary($params, $content, $smarty, &$repeat) {
		$default = "";
		$default .= " rounded-full";
		$default .= " bg-{$this->getOption('baseColour2')}-300";
		$default .= " py-2";
		$default .= " px-4";
		$default .= " text-sm";
		$default .= " font-semibold";
		$default .= " text-slate-900";
		$default .= " hover:bg-{$this->getOption('baseColour2')}-200";
		$default .= " focus:outline-none";
		$default .= " focus-visible:outline-2";
		$default .= " focus-visible:outline-offset-2";
		$default .= " focus-visible:outline-{$this->getOption('baseColour2')}-300/50";
		$default .= " active:bg-{$this->getOption('baseColour2')}-500";

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
		$default .= " focus:border-{$this->getOption('baseColour2')}-300";
		$default .= " focus:ring";
		$default .= " focus:ring-{$this->getOption('baseColour2')}-200";
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
		$default .= " focus:border-{$this->getOption('baseColour2')}-300";
		$default .= " focus:ring";
		$default .= " focus:ring-{$this->getOption('baseColour2')}-200";
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

		return "<input $sa>";
	}

	public function smartyMaterialCheckbox($params, $smarty) {
		$default = "";
		$default .= " rounded-md";
		$default .= " border-gray-300";
		$default .= " text-{$this->getOption('baseColour2')}-600";
		$default .= " shadow-sm";
		$default .= " focus:border-{$this->getOption('baseColour2')}-300";
		$default .= " focus:ring";
		$default .= " focus:ring-{$this->getOption('baseColour2')}-200";
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
}

if (!PKP_STRICT_MODE) {
	class_alias('\APP\plugins\themes\material\MaterialThemePlugin', '\MaterialThemePlugin');
}
