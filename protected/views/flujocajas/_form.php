<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'flujocajas-form',
	'enableAjaxValidation'=>false,
)); ?>

<p class="help-block">Fields with <span class="required">*</span> are required.</p>
	<?php 
	if(isset($totalFlujoCajas)){ ?>

      <?php echo $form->errorSummary($totalFlujoCajas); ?>

  		<?php echo $form->labelEx($totalFlujoCajas,'anos'); ?>
  		<?php echo $form->dropDownList($totalFlujoCajas, 'anos', 
  	             array('1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10),
  	             array('empty' => 'año'));
  	       ?>
  	   <?php echo $form->error($totalFlujoCajas,'anos'); ?>

  	  <?php echo $form->labelEx($totalFlujoCajas,'periodo_id'); ?>
  		<?php echo $form->dropDownList($totalFlujoCajas,'periodo_id',CHtml::listData(Periodos::model()->findAll(),'id','nombre'),array('empty' =>'Seleccione'),array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
  		<?php echo $form->error($totalFlujoCajas,'periodo_id'); ?>


  		<?php echo CHtml::button('Cargar', array('submit' => array('flujocajas/create'))); ?>
																	        
	<?php 
	}else{ ?>



    		<div id='navegador-flujo' >

    			<?php echo CHtml::ajaxSubmitButton('<-- Anterior',Yii::app()->createUrl('flujocajas/anterior'),
    															array('success'=>'function(html){ jQuery("#flujocajas-form").empty().html(html); }'), 
    															array('id'=>'_anterior','disabled'=> (Yii::app()->session['periodo']==0 &&
                                                                         Yii::app()->session['ano']==0) )); ?>
    			<div>Año: <?php echo Yii::app()->session['ano']; ?> Periodo: <?php echo Yii::app()->session['periodo']; ?> </div>
    			<?php $ultimo = (Yii::app()->session['periodo']==Yii::app()->session['periodoSel']-1 &&
                                                                         Yii::app()->session['ano']==Yii::app()->session['anoSel']);

                echo CHtml::ajaxSubmitButton('Siguiente -->' ,Yii::app()->createUrl('flujocajas/siguiente'),
    															array('success'=>'function(html){ jQuery("#flujocajas-form").empty().html(html); }'), 
    															array('id'=>'_siguiente','hidden'=>($ultimo)?true:false)); ?>
    		</div>
        <?php 
                        echo CHtml::ajaxSubmitButton('Guardar Todo',Yii::app()->createUrl('flujocajas/gtod'),
                                  array('success'=>'function(html){ jQuery("#resultados").empty().html(html); }'), 
                                  array('id'=>'_guardartodo','hidden'=>(!$ultimo)?true:false
                                   ));
                                                                         ?>

        <?php if(isset($total))
                  echo $form->errorSummary($model,$total);
                else
                  echo $form->errorSummary($model); ?>

      <?php if(isset($total)){
            ?>

          <?php echo $form->textFieldGroup($total,'valor_neto',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

          <?php echo $form->textFieldGroup($total,'costo_beneficio',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

          <?php echo $form->textFieldGroup($total,'tasa_retorno',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

      <?php
        }?>

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

    		<?php //echo $form->textFieldGroup($model,'fecha_registro',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

    		<?php //echo $form->textFieldGroup($model,'estatus',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>1)))); ?>

    		<?php //echo $form->textFieldGroup($model,'proyecto_id',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
    
	<?php 
	} ?>
<?php 

?>
<!--
<div class="form-actions">
	<?php $this->widget('booster.widgets.TbButton', array(
			'buttonType'=>'submit',
			'context'=>'primary',
			'label'=>$model->isNewRecord ? 'Create' : 'Save',
		)); ?>
</div>-->

<?php $this->endWidget(); ?>

<div id="resultados"></div>
