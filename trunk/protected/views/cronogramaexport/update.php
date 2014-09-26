<?php
$this->breadcrumbs=array(
	'Cronogramaexports'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

	$this->menu=array(
	array('label'=>'List Cronogramaexport','url'=>array('index')),
	array('label'=>'Create Cronogramaexport','url'=>array('create')),
	array('label'=>'View Cronogramaexport','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage Cronogramaexport','url'=>array('admin')),
	);
	?>

	<h1>Update Cronogramaexport <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>