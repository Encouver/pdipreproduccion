<?php
$this->breadcrumbs=array(
	'Flujocajases',
);

$this->menu=array(
array('label'=>'Create Flujocajas','url'=>array('create')),
array('label'=>'Manage Flujocajas','url'=>array('admin')),
);
?>

<h1>Flujocajases</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
