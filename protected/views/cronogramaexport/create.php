<?php
$this->breadcrumbs=array(
	'Cronogramaexports'=>array('index'),
	'Create',
);

$this->menu=array(
array('label'=>'List Cronogramaexport','url'=>array('index')),
array('label'=>'Manage Cronogramaexport','url'=>array('admin')),
);
?>

<h1>Create Cronogramaexport</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>