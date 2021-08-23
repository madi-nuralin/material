<?php

/**
 * @file plugins/themes/material/MaterialThemePlugin.inc.php
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class MaterialThemePlugin
 * @ingroup plugins_themes_material
 *
 * @brief Material theme
 */

import('lib.pkp.classes.plugins.ThemePlugin');

class MaterialThemePlugin extends ThemePlugin {
	/**
	 * @copydoc ThemePlugin::isActive()
	 */
	public function isActive() {
		if (defined('SESSION_DISABLE_INIT')) return true;
		return parent::isActive();
	}

	/**
	 * Initialize the theme's styles, scripts and hooks. This is run on the
	 * currently active theme and it's parent themes.
	 *
	 * @return null
	 */
	public function init() {
		AppLocale::requireComponents(LOCALE_COMPONENT_PKP_MANAGER, LOCALE_COMPONENT_APP_MANAGER);

		/**
		 *  Register theme options
		 */
		$this->addOption('baseColour', 'FieldColor', [
			'label' => __('plugins.themes.material.option.colour.label'),
			'description' => __('plugins.themes.material.option.colour.description'),
			'default' => '#1E6292',
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

		/**
		 *  Load primary stylesheet
		 */
		$this->addStyle(
			'stylesheet', 'styles/index.less'
		);
		// Load icon font FontAwesome - http://fontawesome.io/
		$this->addStyle(
			'fontAwesome', $request->getBaseUrl() . '/lib/pkp/styles/fontawesome/fontawesome.css', array('baseUrl' => '')
		);
		// Load icon font FontAwesome
		$this->addStyle(
			'fontAwesome-5.15', 'vendor/fontawesome/css/all.min.css'
		);
		// Load MDB library (Material Design for Bootstrap)
		$this->addStyle(
			'mdb-css','vendor/mdb/css/mdb.min.css'
		);

		// Store additional LESS variables to process based on options
		$additionalLessVariables = array();

		// Pass additional LESS variables based on options
		if (!empty($additionalLessVariables)) {
			$this->modifyStyle(
				'stylesheet', array('addLessVariables' => join("\n", $additionalLessVariables))
			);
		}

		// Get homepage image and use as header background if useAsHeader is true
		$context = Application::get()->getRequest()->getContext();
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
		}

		// Add scripts
		// Load jQuery from a CDN or, if CDNs are disabled, from a local copy.
		$min = Config::getVar('general', 'enable_minified') ? '.min' : '';
		$jquery = $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jquery/jquery' . $min . '.js';
		$jqueryUI = $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jqueryui/jquery-ui' . $min . '.js';
		// Use an empty `baseUrl` argument to prevent the theme from looking for
		// the files within the theme directory
		$this->addScript('jQuery', $jquery, array('baseUrl' => ''));
		$this->addScript('jQueryUI', $jqueryUI, array('baseUrl' => ''));

		// Load MDB library (Material Design for Bootstrap)
		$this->addScript('mdb-js', 'vendor/mdb/js/mdb.min.js');

		// Load custom JavaScript for this theme
		$this->addScript('material', 'js/main.js');

		// Add navigation menu areas for this theme
		$this->addMenuArea(array('primary', 'user'));


		/**
		 *  Backend stylesheet 
		 */
		$this->addStyle(
			'backend-stylesheet', 'styles/backend/index.less', array('contexts' => 'backend')
		);
		// Load Backend MDB library (Material Design for Bootstrap)
		$this->addStyle(
			'backend-mdb-css', 'vendor/mdb/css/mdb.min.css', array('contexts' => 'backend')
		);
		// Load Backend MDB library (Material Design for Bootstrap)
		$this->addScript(
			'backend-mdb-js', 'vendor/mdb/js/mdb.min.js', array('contexts' => 'backend-onload')
		);
		// Load Backend icon font FontAwesome
		$this->addStyle(
			'backend-fontAwesome', 'vendor/fontawesome/css/all.min.css', array('contexts' => 'backend')
		);
	}

	/**
	 * Get the name of the settings file to be installed on new journal
	 * creation.
	 * @return string
	 */
	function getContextSpecificPluginSettingsFile() {
		return $this->getPluginPath() . '/settings.xml';
	}

	/**
	 * Get the name of the settings file to be installed site-wide when
	 * OJS is installed.
	 * @return string
	 */
	function getInstallSitePluginSettingsFile() {
		return $this->getPluginPath() . '/settings.xml';
	}

	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	function getDisplayName() {
		return __('plugins.themes.material.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription() {
		return __('plugins.themes.material.description');
	}
}
