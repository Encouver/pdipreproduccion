<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id),array('view','id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('proyecto_id')); ?>:</b>
	<?php echo CHtml::encode($data->proyecto_id); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('valor_neto')); ?>:</b>
	<?php echo CHtml::encode($data->valor_neto); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('costo_beneficio')); ?>:</b>
	<?php echo CHtml::encode($data->costo_beneficio); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('tasa_retorno')); ?>:</b>
	<?php echo CHtml::encode($data->tasa_retorno); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_registro')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_registro); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estatus')); ?>:</b>
	<?php echo CHtml::encode($data->estatus); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('anos')); ?>:</b>
	<?php echo CHtml::encode($data->anos); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('periodo_id')); ?>:</b>
	<?php echo CHtml::encode($data->periodo_id); ?>
	<br />

	*/ ?>

</div>