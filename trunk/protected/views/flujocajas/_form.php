<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'flujocajas-form',
	'enableAjaxValidation'=>false,
)); ?>

<p class="help-block">Fields with <span class="required">*</span> are required.</p>

<?php echo $form->errorSummary($model); ?>

	<?php 
	if(!isset($totalFlujoCajas->anos) && !isset($totalFlujoCajas->periodo_id)){ ?>

		<?php echo $form->labelEx($totalFlujoCajas,'anos'); ?>
		<?php echo $form->dropDownList($totalFlujoCajas, 'anos', 
	             array('1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10),
	             array('empty' => 'daño'));
	       ?>
	    <?php echo $form->error($totalFlujoCajas,'anos'); ?>

	    <?php echo $form->labelEx($totalFlujoCajas,'periodo_id'); ?>
		<?php echo $form->dropDownList($totalFlujoCajas,'periodo_id',CHtml::listData(Periodos::model()->findAll(),'id','nombre'),array('empty' =>'Seleccione'),array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
		<?php echo $form->error($totalFlujoCajas,'periodo_id'); ?>


		<?php echo CHtml::ajaxButton('Cargar', Yii::app()->createUrl('/pdipreproduccion/index.php?r=flujocajas/create'),array(
														        'type'=>'POST',
														        'dataType'=>'json',
														        'success'=>'function(html){ jQuery("#your_id").empty().html(html); }'
														        ) ); ?>
	<?php 
	}else{ ?>

		<?php echo $form->textFieldGroup($model,'inversion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'prestamo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'ingresos',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'costos',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'reinversion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'valor_residual',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'pagos',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'depreciacion_negativo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'utilidad_antesimp',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'utilidad_despuesimp',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'impuestos',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'depreciacion_positivo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'flujo_operativo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'flujo_proyectado',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'ingresos_rcb',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'costos_rcb',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'ingresos_rcbact',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'costos_rcbact',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'fecha_registro',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php echo $form->textFieldGroup($model,'estatus',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>1)))); ?>

		<?php echo $form->textFieldGroup($model,'proyecto_id',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

	<?php 
	} ?>
<?php 

/*$this->widget('ext.editable.EditableField', array(
    'type'      => 'text',
    'model'     => $model,
    'attribute' => 'inversion',
    'url'       => $this->createUrl('user/update'),  //url for submit data
));*/
/*
$data = new CActiveDataProvider('Flujocajas');
$data->setData($model);
$this->widget('booster.widgets.TbGridView', array(
    'id' => 'flujo_caja',
    'itemsCssClass'=>'table table-striped table-bordered table-condensed',
    'dataProvider' => $data,
 	'columns'=>array(
 		 array(
           'class' => 'ext.editable.EditableColumn',
           'name' => 'inversion',
           'headerHtmlOptions' => array('style' => 'width: 110px'),
           'editable' => array(
                  'url'        => $this->createUrl('flujocajas/create'),
                  'placement'  => 'right',
                  'inputclass' => 'span3',
              )               
        ),
       array(
           'class' => 'ext.editable.EditableColumn',
           'name' => 'user_name',
           'headerHtmlOptions' => array('style' => 'width: 110px'),
           'editable' => array(
                  'url'        => $this->createUrl('flujocajas/create'),
                  'placement'  => 'right',
                  'inputclass' => 'span3',
              )               
        ),
        
        array( 
              'class' => 'ext.editable.EditableColumn',
              'name' => 'user_sex',
              //we need not to set value, it will be auto-taken from source
              'headerHtmlOptions' => array('style' => 'width: 60px'),
              'editable' => array(
                  'type'    => 'select',
                  'url'     => $this->createUrl('user/update'),
                  'source'  => array(0 => 'Male', 1 => 'Female'),
              )
         ),            
        
        array( 
              'class' => 'ext.editable.EditableColumn',
              'name' => 'user_status',
              'value' => 'CHtml::value($data, "status.status_text")', //we need to set value because source is url
              'headerHtmlOptions' => array('style' => 'width: 100px'),
              'editable' => array(
                  'type'     => 'select',
                  'url'      => $this->createUrl('user/update'),
                  'source'   => $this->createUrl('user/getstatuslist'),
                  'onRender' => 'js: function(e, editable) {
                      var colors = {1: "green", 2: "blue", 3: "red", 4: "gray"};
                      $(this).css("color", colors[editable.value]);    
                  }'                       
              )
         ),
      
         array( 
              'class' => 'ext.editable.EditableColumn',
              'name' => 'user_dob',
              'headerHtmlOptions' => array('style' => 'width: 100px'),
              'editable' => array(
                  'type'          => 'date',
                  'viewformat'    => 'dd.mm.yyyy',
                  'url'           => $this->createUrl('user/update'),
                  'placement'     => 'right',
              )
         ), 
         
         array( 
            'class' => 'ext.editable.EditableColumn',
            'name' => 'user_comment',
            'editable' => array(
                'type'      => 'textarea',
                'url'       => $this->createUrl('user/update'),
                'placement' => 'left',
            )
          ), 
    ),
));
*/
?>

<div class="form-actions">
	<?php $this->widget('booster.widgets.TbButton', array(
			'buttonType'=>'submit',
			'context'=>'primary',
			'label'=>$model->isNewRecord ? 'Create' : 'Save',
		)); ?>
</div>

<?php $this->endWidget(); ?>
