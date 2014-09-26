<?php
$this->breadcrumbs=array(
	'Cronogramaimports',
);

$this->menu=array(
array('label'=>'Create Cronogramaimport','url'=>array('create')),
array('label'=>'Manage Cronogramaimport','url'=>array('admin')),
);
?>

<h1>Cronogramaimports</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
