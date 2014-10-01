<?php
$this->breadcrumbs=array(
	'Totalflujocajases',
);

$this->menu=array(
array('label'=>'Create Totalflujocajas','url'=>array('create')),
array('label'=>'Manage Totalflujocajas','url'=>array('admin')),
);
?>

<h1>Totalflujocajases</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
