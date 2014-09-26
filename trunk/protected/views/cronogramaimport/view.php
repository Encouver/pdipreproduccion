<?php
$this->breadcrumbs=array(
	'Cronogramaimports'=>array('index'),
	$model->id,
);

$this->menu=array(
array('label'=>'List Cronogramaimport','url'=>array('index')),
array('label'=>'Create Cronogramaimport','url'=>array('create')),
array('label'=>'Update Cronogramaimport','url'=>array('update','id'=>$model->id)),
array('label'=>'Delete Cronogramaimport','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Cronogramaimport','url'=>array('admin')),
);
?>

<h1>View Cronogramaimport #<?php echo $model->id; ?></h1>

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
		'fecha_registro',
		'valido',
		'proyecto_id',
),
)); ?>
