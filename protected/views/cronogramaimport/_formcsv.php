<?php echo CHtml::beginForm('/pdipreproduccion/index.php?r=cronogramaimport/subircsv','post',array('enctype' => 'multipart/form-data')); 
echo CHtml::fileField('Archivos CSV','',array('accept'=>'.csv')); 
 //echo CHtml::submitButton('Subir','',array()); 
?>
<div class="form-actions">
<?php $this->widget('booster.widgets.TbButton', array(
'buttonType'=>'submit',
'context'=>'primary',
'label'=>$model->isNewRecord ? 'Create' : 'Save',
)); ?>
</div>
<?php
echo CHtml::endForm(); ?>