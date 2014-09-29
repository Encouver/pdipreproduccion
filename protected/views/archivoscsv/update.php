<?php
$this->breadcrumbs=array(
	'Archivoscsvs'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

	$this->menu=array(
	array('label'=>'List Archivoscsv','url'=>array('index')),
	array('label'=>'Subir archivos import','url'=>array('import')),
	array('label'=>'Subir archivos export','url'=>array('export')),
	array('label'=>'View Archivoscsv','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage Archivoscsv','url'=>array('admin')),
	);
	?>

	<h1>Update Archivoscsv <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>