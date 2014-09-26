<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id),array('view','id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('insumo')); ?>:</b>
	<?php echo CHtml::encode($data->insumo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('cod_arancelario')); ?>:</b>
	<?php echo CHtml::encode($data->cod_arancelario); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('unidad_id')); ?>:</b>
	<?php echo CHtml::encode($data->unidad_id); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('cantidad')); ?>:</b>
	<?php echo CHtml::encode($data->cantidad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('costo_total')); ?>:</b>
	<?php echo CHtml::encode($data->costo_total); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_estimada')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_estimada); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('pais_destino')); ?>:</b>
	<?php echo CHtml::encode($data->pais_destino); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_registro')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_registro); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('valido')); ?>:</b>
	<?php echo CHtml::encode($data->valido); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('proyecto_id')); ?>:</b>
	<?php echo CHtml::encode($data->proyecto_id); ?>
	<br />

	*/ ?>

</div>