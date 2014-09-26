<?php
$this->breadcrumbs=array(
	'Cronogramaimports'=>array('index'),
	'Create',
);

$this->menu=array(
array('label'=>'List Cronogramaimport','url'=>array('index')),
array('label'=>'Manage Cronogramaimport','url'=>array('admin')),
);
?>

<h1>Create Cronogramaimport</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>