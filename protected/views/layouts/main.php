<?php /* @var $this Controller */ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="language" content="en" />

	<!-- bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/protected/extensions/booster/assets/bootstrap/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/protected/extensions/booster/assets/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/protected/extensions/booster/assets/bootstrap/css/bootstrap-theme.css" />
	<!--[if lt IE 8]>
	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/ie.css" media="screen, projection" />
	<![endif]-->

	<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/main.css" />
	<link style="diplay: none;" rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/form.css" />
  
  	<title><?php echo CHtml::encode($this->pageTitle); ?></title>
</head>

<body>
<?php    

/*
$this->widget(
    'booster.widgets.TbNavbar',
    array(
    'type' => 'null',
	'collapse' => true,
    'brand' => 'Plan de Divisas',
    'fixed' => false,
    'fluid' => false,
    'items' => array(
    array(
    'class' => 'booster.widgets.TbMenu',
    'type' => 'navbar',
    'items' => array(
    array('label' => 'Home', 'url' => '#', 'active' => true),
    array('label' => 'Link', 'url' => '#'),
    array('label' => 'Link', 'url' => '#'),
    )
    )
    )
    )
    );*/
   
?>
	
<div class="container">

<div id="page">

	<div class="row">
		<div class="col-xs-12">
			<div id="barra">
				<img class="img-responsive" src="images/barra.svg"/>
			</div><!-- barra -->
			<div id="logo">
				<img class="img-responsive" src="images/logo.svg" />
			</div><!-- logo -->			
		</div><!-- col-xs-12 -->
	</div><!-- row  -->				
		
			<?php echo $content; ?>	
	
	<div class="clear"></div>
	
	</div><!-- page -->

</div><!-- container -->

<script type="text/javascript" src="<?php echo Yii::app()->request->baseUrl; ?>/protected/extensions/booster/assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<?php echo Yii::app()->request->baseUrl; ?>/protected/extensions/booster/assets/bootstrap/js/bootstrap.js"></script>
</body>
</html>
