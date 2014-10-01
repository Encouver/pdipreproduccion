<?php
$this->breadcrumbs=array(
	'Totalflujocajases'=>array('index'),
	$model->id,
);

$this->menu=array(
array('label'=>'List Totalflujocajas','url'=>array('index')),
array('label'=>'Create Totalflujocajas','url'=>array('create')),
array('label'=>'Update Totalflujocajas','url'=>array('update','id'=>$model->id)),
array('label'=>'Delete Totalflujocajas','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Totalflujocajas','url'=>array('admin')),
);
?>

<h1>View Totalflujocajas #<?php echo $model->id; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		'id',
		'proyecto_id',
		'valor_neto',
		'costo_beneficio',
		'tasa_retorno',
		'fecha_registro',
		'estatus',
		'anos',
		'periodo_id',
),
)); ?>
