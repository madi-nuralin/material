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

		// Register theme options
		$this->addOption('typography', 'FieldOptions', [
			'type' => 'radio',
			'label' => __('plugins.themes.material.option.typography.label'),
			'description' => __('plugins.themes.material.option.typography.description'),
			'options' => [
				[
					'value' => 'notoSans',
					'label' => __('plugins.themes.material.option.typography.notoSans'),
				],
				[
					'value' => 'notoSerif',
					'label' => __('plugins.themes.material.option.typography.notoSerif'),
				],
				[
					'value' => 'notoSerif_notoSans',
					'label' => __('plugins.themes.material.option.typography.notoSerif_notoSans'),
				],
				[
					'value' => 'notoSans_notoSerif',
					'label' => __('plugins.themes.material.option.typography.notoSans_notoSerif'),
				],
				[
					'value' => 'lato',
					'label' => __('plugins.themes.material.option.typography.lato'),
				],
				[
					'value' => 'lora',
					'label' => __('plugins.themes.material.option.typography.lora'),
				],
				[
					'value' => 'lora_openSans',
					'label' => __('plugins.themes.material.option.typography.lora_openSans'),
				],
				[
					'value' => 'poppins',
					'label' => __('plugins.themes.material.option.typography.poppins'),
				],
			],
			'default' => 'poppins',
		]);

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

		// Load primary stylesheet
		$this->addStyle('stylesheet', 'styles/index.less');

		// Store additional LESS variables to process based on options
		$additionalLessVariables = array();

		/*if ($this->getOption('typography') === 'notoSerif') {
			$this->addStyle('font', 'styles/fonts/notoSerif.less');
			$additionalLessVariables[] = '@font: "Noto Serif", -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen-Sans", "Ubuntu", "Cantarell", "Helvetica Neue", sans-serif;';
		} elseif (strpos($this->getOption('typography'), 'notoSerif') !== false) {
			$this->addStyle('font', 'styles/fonts/notoSans_notoSerif.less');
			if ($this->getOption('typography') == 'notoSerif_notoSans') {
				$additionalLessVariables[] = '@font-heading: "Noto Serif", serif;';
			} elseif ($this->getOption('typography') == 'notoSans_notoSerif') {
				$additionalLessVariables[] = '@font: "Noto Serif", serif;@font-heading: "Noto Sans", serif;';
			}
		} elseif ($this->getOption('typography') == 'lato') {
			$this->addStyle('font', 'styles/fonts/lato.less');
			$additionalLessVariables[] = '@font: Lato, sans-serif;';
		} elseif ($this->getOption('typography') == 'lora') {
			$this->addStyle('font', 'styles/fonts/lora.less');
			$additionalLessVariables[] = '@font: Lora, serif;';
		} elseif ($this->getOption('typography') == 'lora_openSans') {
			$this->addStyle('font', 'styles/fonts/lora_openSans.less');
			$additionalLessVariables[] = '@font: "Open Sans", sans-serif;@font-heading: Lora, serif;';
		} elseif ($this->getOption('typography') == 'poppins') {
			$this->addStyle('font', 'styles/fonts/poppins.less');
			$additionalLessVariables[] = '@font: "Poppins", sans-serif;';
		} else {
			$this->addStyle('font', 'styles/fonts/notoSans.less');
		}*/

		/*// Update colour based on theme option
		if ($this->getOption('baseColour') !== '#1E6292') {
			$additionalLessVariables[] = '@bg-base:' . $this->getOption('baseColour') . ';';
			if (!$this->isColourDark($this->getOption('baseColour'))) {
				$additionalLessVariables[] = '@text-bg-base:rgba(0,0,0,0.84);';
				$additionalLessVariables[] = '@bg-base-border-color:rgba(0,0,0,0.2);';
			}
		}*/

		// Pass additional LESS variables based on options
		if (!empty($additionalLessVariables)) {
			$this->modifyStyle('stylesheet', array('addLessVariables' => join("\n", $additionalLessVariables)));
		}

		$request = Application::get()->getRequest();

		// Load icon font FontAwesome - http://fontawesome.io/
		$this->addStyle(
			'fontAwesome',
			$request->getBaseUrl() . '/lib/pkp/styles/fontawesome/fontawesome.css',
			array('baseUrl' => '')
		);

		// Load icon font FontAwesome
		$this->addStyle(
			'fontawesome',
			'vendor/fontawesome/css/fontawesome.css'
		);

		// Load MDB library (Material Design for Bootstrap)
		$this->addStyle(
			'mdb',
			'vendor/mdb/css/mdb.min.css'
		);

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

		/**
		 * Add scripts
		 */
		// Load jQuery from a CDN or, if CDNs are disabled, from a local copy.
		$min = Config::getVar('general', 'enable_minified') ? '.min' : '';
		$jquery = $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jquery/jquery' . $min . '.js';
		$jqueryUI = $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jqueryui/jquery-ui' . $min . '.js';
		// Use an empty `baseUrl` argument to prevent the theme from looking for
		// the files within the theme directory
		$this->addScript('jQuery', $jquery, array('baseUrl' => ''));
		$this->addScript('jQueryUI', $jqueryUI, array('baseUrl' => ''));

		// Load MDB library (Material Design for Bootstrap)
		$this->addScript('mdb', 'vendor/mdb/js/mdb.min.js');

		// Load custom JavaScript for this theme
		$this->addScript('material', 'js/main.js');

		// Add navigation menu areas for this theme
		$this->addMenuArea(array('primary', 'user'));



		// Backend
		$this->addStyle(
			'backend-stylesheet',
			'styles/backend/index.less',
			array('contexts' => 'backend')
		);
		// Load MDB library (Material Design for Bootstrap)
		$this->addStyle(
			'backend-mdb',
			'vendor/mdb/css/mdb.min.css',
			array('contexts' => 'backend')
		);
		// Load MDB library (Material Design for Bootstrap)
		$this->addScript(
			'backend-mdb',
			'vendor/mdb/js/mdb.min.js',
			array('contexts' => 'backend2')
		);
		// Load icon font FontAwesome
		$this->addStyle(
			'fontawesome',
			'vendor/fontawesome/css/all.min.css',
			array('contexts' => 'backend')
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
