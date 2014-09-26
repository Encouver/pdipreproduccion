<link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/login.css" />
<?php
/* @var $this SiteController */
/* @var $model LoginForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - Inicio de Sesión';
$this->breadcrumbs=array(
	'Login',
);
?>

	<?php $form=$this->beginWidget('booster.widgets.TbActiveForm', array(
		'id'=>'verticalForm',
		'enableClientValidation'=>true,
		'clientOptions'=>array(
		'validateOnSubmit'=>true,
		),
	)); ?>

	<div id="header">
		<span class="title_1">Iniciar Sesi&oacute;n</span>
	</div>

<div class="relleno">
	
	<?php	$form = $this->beginWidget(
		'booster.widgets.TbActiveForm',
			array(
				'id' => 'verticalForm',
				'type' => 'horizontal',
				'htmlOptions' => array('class' => 'well'), // for inset effect
					)
				);
	?>
	
	<?php echo $form->errorSummary($model); ?>
	
	<p class="hint"><i class="glyphicon glyphicon-info-sign"></i> Los campos con <span class="required">*</span> son requeridos.</p>
		
			<?php echo $form->textFieldGroup($model,'username'); ?>
				&nbsp;
			<?php echo $form->passwordFieldGroup($model,'password'); ?>
					
		<hr class="hr" />
		
		<?php
			$this->widget('booster.widgets.TbButton',array('buttonType'=> 'submit','label' => 'Entrar','context' => 'primary',));
		?>
	
	<?php $this->endWidget(); ?>

<?php $this->endWidget(); ?>

</div><!-- relleno -->