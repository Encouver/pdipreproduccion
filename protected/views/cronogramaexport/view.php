<?php
$this->breadcrumbs=array(
	'Cronogramaexports'=>array('index'),
	$model->id,
);

$this->menu=array(
array('label'=>'List Cronogramaexport','url'=>array('index')),
array('label'=>'Create Cronogramaexport','url'=>array('create')),
array('label'=>'Update Cronogramaexport','url'=>array('update','id'=>$model->id)),
array('label'=>'Delete Cronogramaexport','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Cronogramaexport','url'=>array('admin')),
);
?>

<h1>View Cronogramaexport #<?php echo $model->id; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		'id',
		'insumo',
		'cod_arancelario',
		'unidad_id',
		'cantidad',
		'costo_total',
		'fecha_estimada',
		'pais_destino',
		'fecha_registro',
		'valido',
		'proyecto_id',
),
)); ?>
