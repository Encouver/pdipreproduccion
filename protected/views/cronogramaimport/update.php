<?php
$this->breadcrumbs=array(
	'Cronogramaimports'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

	$this->menu=array(
	array('label'=>'List Cronogramaimport','url'=>array('index')),
	array('label'=>'Create Cronogramaimport','url'=>array('create')),
	array('label'=>'View Cronogramaimport','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage Cronogramaimport','url'=>array('admin')),
	);
	?>

	<h1>Update Cronogramaimport <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>