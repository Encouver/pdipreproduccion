<?php
$this->breadcrumbs=array(
	'Flujocajases'=>array('index'),
	'Create',
);

$this->menu=array(
array('label'=>'List Flujocajas','url'=>array('index')),
array('label'=>'Manage Flujocajas','url'=>array('admin')),
);
?>

<h1>Create Flujocajas</h1>

<?php if(isset($totalFlujoCajas))
		echo $this->renderPartial('_form', array('model'=>$model,'totalFlujoCajas'=>$totalFlujoCajas));
	  else
	   	echo $this->renderPartial('_form', array('model'=>$model,'total'=>$total)); ?>