<?php
$this->breadcrumbs=array(
	'Cronogramaexports',
);

$this->menu=array(
array('label'=>'Create Cronogramaexport','url'=>array('create')),
array('label'=>'Manage Cronogramaexport','url'=>array('admin')),
);
?>

<h1>Cronogramaexports</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
