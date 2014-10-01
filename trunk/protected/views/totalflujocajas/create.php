<?php
$this->breadcrumbs=array(
	'Totalflujocajases'=>array('index'),
	'Create',
);

$this->menu=array(
array('label'=>'List Totalflujocajas','url'=>array('index')),
array('label'=>'Manage Totalflujocajas','url'=>array('admin')),
);
?>

<h1>Create Totalflujocajas</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>