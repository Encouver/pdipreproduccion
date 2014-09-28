<?php
$this->breadcrumbs=array(
	'Flujocajases'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

	$this->menu=array(
	array('label'=>'List Flujocajas','url'=>array('index')),
	array('label'=>'Create Flujocajas','url'=>array('create')),
	array('label'=>'View Flujocajas','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage Flujocajas','url'=>array('admin')),
	);
	?>

	<h1>Update Flujocajas <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>