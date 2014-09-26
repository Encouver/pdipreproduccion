<?php

Yii::setPathOfAlias('booster', dirname(__FILE__) . DIRECTORY_SEPARATOR . '../extensions/booster');

// uncomment the following to define a path alias
// Yii::setPathOfAlias('local','path/to/local-folder');

// This is the main Web application configuration. Any writable
// CWebApplication properties can be configured here.
return array(
	'basePath'=>dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
	'name'=>'Plan de Divisas',
	'language'=>'es', // Este es el lenguaje en el que querés que muestre las cosas
	'sourceLanguage'=>'es',
	'theme'=>'booster',

	

	// autoloading model and component classes
	'import'=>array(
		'application.models.*',
		'application.components.*',
	),

	'modules'=>array(
		// uncomment the following to enable the Gii tool
		
		  
		'gii'=>array(
			'class'=>'system.gii.GiiModule',
			'password'=>'1234',
			// If removed, Gii defaults to localhost only. Edit carefully to taste.
			'ipFilters'=>array('127.0.0.1','::1'),
			'generatorPaths' => array(
 				'booster.gii'
 			),
		),
		
	),

	// application components
	'components'=>array(
		'booster' => array(     //booster
    		'class' => 'ext.booster.components.Booster',
			'responsiveCss' => true,
		),
		'user'=>array(
			// enable cookie-based authentication
			'allowAutoLogin'=>true,
		),
		// uncomment the following to enable URLs in path-format
		
		/*'urlManager'=>array(
			'urlFormat'=>'path',
			'rules'=>array(
				'<controller:\w+>/<id:\d+>'=>'<controller>/view',
				'<controller:\w+>/<action:\w+>/<id:\d+>'=>'<controller>/<action>',
				'<controller:\w+>/<action:\w+>'=>'<controller>/<action>',
			),
		),*/
		
		/*'db'=>array(
			'connectionString' => 'sqlite:'.dirname(__FILE__).'/../data/testdrive.db',
		),*/
		// uncomment the following to use a MySQL database
		/*
		'db'=>array(
			'connectionString' => 'mysql:host=localhost;dbname=testdrive',
			'emulatePrepare' => true,
			'username' => 'root',
			'password' => '',
			'charset' => 'utf8',
		),
		*/
         // configuracion de base de datos
	    /*'db'=>array(
			//'class'=>"ext.oci8Pdo.OciDbConnection",
			'connectionString' => "oci:dbname=//bddesarrollo.pruebas.cadivi.gob.ve:1521/DBPRE",
			//'emulatePrepare' => true,
			'username' => 'sicad',
			'password' => '1',
			//'charset' => 'charset=AL32UTF8;',
			//'enableProfiling' => true,
            //'enableParamLogging' => true,
		),*/
        'db'=>array(
           'class'=> 'CDbConnection',
           'connectionString' => 'pgsql:host=localhost;port=5432;dbname=Prueba',
           //'emulatePrepare' => true,
           'username' => 'divisa',
           'password' => 'divisa',
           'charset' => 'utf8',
        ),
		'errorHandler'=>array(
			// use 'site/error' action to display errors
			'errorAction'=>'site/error',
		),
		'log'=>array(
			'class'=>'CLogRouter',
			'routes'=>array(
				array(
					'class'=>'CFileLogRoute',
					'levels'=>'error, warning',
				),
				// uncomment the following to show log messages on web pages
				/*
				array(
					'class'=>'CWebLogRoute',
				),
				*/
			),
		),
	),

	// preloading 'log' component
	'preload'=>array('log','booster'),   //tenian aqui bootstrap

	'defaultController'=>'site/login',
	// application-level parameters that can be accessed
	// using Yii::app()->params['paramName']
	'params'=>array(
		// this is used in contact page
		'adminEmail'=>'webmaster@example.com',
        'uploadPath'=>dirname(__FILE__).'/../../images/upload',
        'uploadUrl'=>'/images/upload',
	),
);
