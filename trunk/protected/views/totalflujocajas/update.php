<?php
$this->breadcrumbs=array(
	'Totalflujocajases'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

	$this->menu=array(
	array('label'=>'List Totalflujocajas','url'=>array('index')),
	array('label'=>'Create Totalflujocajas','url'=>array('create')),
	array('label'=>'View Totalflujocajas','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage Totalflujocajas','url'=>array('admin')),
	);
	?>

	<h1>Update Totalflujocajas <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>