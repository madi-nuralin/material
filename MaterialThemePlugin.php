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
		$class = "rounded-full bg-{$this->getOption('baseColour2')}-300 py-2 px-4 text-sm font-semibold text-slate-900 hover:bg-{$this->getOption('baseColour2')}-200 focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-{$this->getOption('baseColour2')}-300/50 active:bg-{$this->getOption('baseColour2')}-500";

		$id = isset($params['id']) ? "id=\"{$params['id']}\"" : '';
		$type = isset($params['type']) ? "type=\"{$params['type']}\"" : '';
		$class = isset($params['class']) ? "class=\"$class {$params['class']}\"" : "class=\"$class\"";

		if (!$repeat) {
			return "$content</button>";
		} else {
			return "<button $class $id $type>";
		}
	}

	public function smartyMaterialLabel($params, $content, $smarty, &$repeat) {
		$class = 'leading-none font-medium text-sm text-gray-700 dark:text-gray-400';
		$for = isset($params['for']) ? "for=\"{$params['for']}\"" : '';
		$class = isset($params['class']) ? "class=\"$class {$params['class']}\"" : "class=\"$class\"";

		if (!$repeat) {
			return "$content</label>";
		} else {
			return "<label $class $for>";
		}
	}

	public function smartyMaterialSelect($params, $content, $smarty, &$repeat) {
		$id = isset($params['id']) ? "id=\"{$params['id']}\"" : '';
		$type = isset($params['type']) ? "type=\"{$params['type']}\"" : '';
		$name = isset($params['name']) ? "name=\"{$params['name']}\"" : '';
		$value = isset($params['value']) ? "value=\"{$params['value']}\"" : '';
		$required = isset($params['required']) ? "required=\"{$params['required']}\"" : '';
		$maxlength = isset($params['maxlength']) ? "maxlength=\"{$params['maxlength']}\"" : '';
		$autocomplete = isset($params['autocomplete']) ? "autocomplete=\"{$params['autocomplete']}\"" : '';
		$ariaRequired = isset($params['aria-required']) ? "aria-required=\"{$params['aria-required']}\"" : '';
		$class = "border-gray-300 focus:border-{$this->getOption('baseColour2')}-300 focus:ring focus:ring-{$this->getOption('baseColour2')}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white";
		$class = isset($params['class']) ? "class=\"$class {$params['class']}\"" : "class=\"$class\"";

		if (!$repeat) {
			return "$content</select>";
		} else {
			return "<select $class $type $name $id $maxlength $required $autocomplete $ariaRequired>";
		}
	}

	public function smartyMaterialInput($params, $smarty) {
		$id = isset($params['id']) ? "id=\"{$params['id']}\"" : '';
		$type = isset($params['type']) ? "type=\"{$params['type']}\"" : '';
		$name = isset($params['name']) ? "name=\"{$params['name']}\"" : '';
		$value = isset($params['value']) ? "value=\"{$params['value']}\"" : '';
		$checked = isset($params['checked']) ? "checked=\"{$params['checked']}\"" : '';
		$required = isset($params['required']) ? "required=\"{$params['required']}\"" : '';
		$maxlength = isset($params['maxlength']) ? "maxlength=\"{$params['maxlength']}\"" : '';
		$autocomplete = isset($params['autocomplete']) ? "autocomplete=\"{$params['autocomplete']}\"" : '';
		$ariaRequired = isset($params['aria-required']) ? "aria-required=\"{$params['aria-required']}\"" : '';
		$class = "border-gray-300 focus:border-{$this->getOption('baseColour2')}-300 focus:ring focus:ring-{$this->getOption('baseColour2')}-200 focus:ring-opacity-50 rounded-md shadow-sm dark:bg-gray-800 dark:border-gray-500 dark:text-white";
		$class = isset($params['class']) ? "class=\"$class {$params['class']}\"" : "class=\"$class\"";

		return "<input $class $type $name $id $maxlength $required $autocomplete $ariaRequired $checked>";
	}

	public function smartyMaterialCheckbox($params, $smarty) {
		$id = isset($params['id']) ? "id=\"{$params['id']}\"" : '';
		$name = isset($params['name']) ? "name=\"{$params['name']}\"" : '';
		$value = isset($params['value']) ? "value=\"{$params['value']}\"" : '';
		$checked = isset($params['checked']) ? "checked=\"{$params['checked']}\"" : '';
		$required = isset($params['required']) ? "required=\"{$params['required']}\"" : '';

		$class = "rounded-md border-gray-300 text-{$this->getOption('baseColour2')}-600 shadow-sm focus:border-{$this->getOption('baseColour2')}-300 focus:ring focus:ring-{$this->getOption('baseColour2')}-200 focus:ring-opacity-50 dark:bg-gray-800";
		$class = isset($params['class']) ? "class=\"$class {$params['class']}\"" : "class=\"$class\"";

		return "<input $class type=\"checkbox\" $name $id $maxlength $required $autocomplete $ariaRequired $checked>";
	}
}

if (!PKP_STRICT_MODE) {
	class_alias('\APP\plugins\themes\material\MaterialThemePlugin', '\MaterialThemePlugin');
}
