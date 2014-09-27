<?php
$this->breadcrumbs=array(
	'Archivoscsvs'=>array('index'),
	$model->id,
);

$this->menu=array(
array('label'=>'List Archivoscsv','url'=>array('index')),
array('label'=>'Create Archivoscsv','url'=>array('importcsv')),
array('label'=>'Update Archivoscsv','url'=>array('update','id'=>$model->id)),
array('label'=>'Delete Archivoscsv','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Archivoscsv','url'=>array('admin')),
);
?>

<h1>View Archivoscsv #<?php echo $model->id; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		'id',
		'proyecto_id',
		'archivo',
		'tipo_csv',
		'fecha',
),
)); ?>
