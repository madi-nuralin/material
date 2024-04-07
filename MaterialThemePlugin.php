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
		$this->addOption('issueArchiveColumns', 'FieldText', [
			'label' => __('plugins.themes.material.option.issueArchiveColumns.label'),
			'description' => __('plugins.themes.material.option.issueArchiveColumns.description'),
			'default' => 1
		]);

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

		$this->addOption('disablePrefixAndTitle', 'FieldOptions', [
			'label' => __('plugins.themes.material.option.disablePrefixAndTitle.label'),
			'description' => __('plugins.themes.material.option.disablePrefixAndTitle.description'),
				'options' => [
				[
					'value' => true,
					'label' => __('plugins.themes.material.option.disablePrefixAndTitle.option')
				],
			],
			'default' => false,
		]);

		$this->addOption('disableArticleSubtitle', 'FieldOptions', [
			'label' => __('plugins.themes.material.option.disableArticleSubtitle.label'),
			'description' => __('plugins.themes.material.option.disableArticleSubtitle.description'),
				'options' => [
				[
					'value' => true,
					'label' => __('plugins.themes.material.option.disableArticleSubtitle.option')
				],
			],
			'default' => false,
		]);

		$request = Application::get()->getRequest();
		$templateManager = TemplateManager::getManager($request);
		/*$templateManager->assign('themes', array(
			array('name' => 'System', 'path' => 'frontend/components/ui/systemIcon.tpl'),
			array('name' => 'Light', 'path' => 'frontend/components/ui/lightIcon.tpl'),
			array('name' => 'Dark', 'path' => 'frontend/components/ui/darkIcon.tpl')
		));*/

		// Load primary stylesheet
		$this->addStyle('stylesheet', 'styles/dist/output.css');

		// Store additional LESS variables to process based on options
		$additionalLessVariables = array();
		if ($this->getOption('issueArchiveColumns') > 0) {
			$additionalLessVariables[] = '@issue-archive-columns:' . $this->getOption('issueArchiveColumns') . ';';
		}

		// Get homepage image and use as header background if useAsHeader is true
		/*$context = Application::get()->getRequest()->getContext();
		if ($context && $this->getOption('useHomepageImageAsHeader')) {
			$publicFileManager = new PublicFileManager();
			$publicFilesDir = $request->getBaseUrl() . '/' . $publicFileManager->getContextFilesPath($context->getId());

			$homepageImage = $context->getLocalizedData('homepageImage');
			$homepageImageUrl = $publicFilesDir . '/' . $homepageImage['uploadName'];

			$this->addStyle(
				'homepageImage',
				'.pkp_structure_head { background: center / cover no-repeat url("' . $homepageImageUrl . '");}',
				['inline' => true]
			);

			$additionalLessVariables[] = '@bg-image-url:"' . $homepageImageUrl . '";';
		}*/

		// Pass additional LESS variables based on options
		if (!empty($additionalLessVariables)) {
			$this->modifyStyle(
				'stylesheet', array('addLessVariables' => join("\n", $additionalLessVariables))
			);
		}

		// Load alpinejs for this theme
		$this->addScript('alpinejs', 'js/alpinejs@3.x.x/dist/cdn.min.js');
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
}

if (!PKP_STRICT_MODE) {
	class_alias('\APP\plugins\themes\material\MaterialThemePlugin', '\MaterialThemePlugin');
}
