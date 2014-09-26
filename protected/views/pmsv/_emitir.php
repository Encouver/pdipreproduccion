<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'presupuesto-form',
	'enableAjaxValidation'=>false,
	'stateful'=>true, 
	'htmlOptions' => array('enctype' => 'multipart/form-data'),
)); ?>

<?Yii::app()->clientScript->registerCoreScript('jquery');?>
<script>
   $(document).ready(function(){
      //script para eliminar un input mal generado por yiibooster
      //$("#ytPlmsvForm_file").remove();
   });
</script>
<p class="help-block">Campos <span class="required">*</span> son requeridos.</p>

<?php echo $form->errorSummary($model); ?>

	<?php echo $form->fileFieldGroup($model,'file',array('wrapperHtmlOptions' => array(
    'class' => 'col-sm-5',))); ?>
   <?//php echo $form->fileField($model,'file',array());?>
    
     <?//php echo $form->fileField($model,'file');?>
    <?//php echo CHtml::activeFileField($model, 'file'); ?>
    <?//php echo CHtml::FileField('PlmsvForm[file]',''); ?>



	<div class="form-actions">
	<?php $this->widget('booster.widgets.TbButton', array(
			'buttonType'=>'submit',
			'context'=>'primary',
			'label'=>'Subir' ,
		)); ?>
</div>

<?php $this->endWidget(); ?>