<?php
$this->breadcrumbs=array(
	'Flujocajases'=>array('index'),
	$model->id,
);

$this->menu=array(
array('label'=>'List Flujocajas','url'=>array('index')),
array('label'=>'Create Flujocajas','url'=>array('create')),
array('label'=>'Update Flujocajas','url'=>array('update','id'=>$model->id)),
array('label'=>'Delete Flujocajas','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Flujocajas','url'=>array('admin')),
);
?>

<h1>View Flujocajas #<?php echo $model->id; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		'id',
		'inversion',
		'prestamo',
		'ingresos',
		'costos',
		'reinversion',
		'valor_residual',
		'pagos',
		'depreciacion_negativo',
		'utilidad_antesimp',
		'utilidad_despuesimp',
		'impuestos',
		'depreciacion_positivo',
		'flujo_operativo',
		'flujo_proyectado',
		'ingresos_rcb',
		'costos_rcb',
		'ingresos_rcbact',
		'costos_rcbact',
		'fecha_registro',
		'estatus',
		'proyecto_id',
),
)); ?>
