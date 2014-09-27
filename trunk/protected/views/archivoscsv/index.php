<?php
$this->breadcrumbs=array(
	'Archivoscsvs',
);

$this->menu=array(
array('label'=>'Create Archivoscsv','url'=>array('importcsv')),
array('label'=>'Manage Archivoscsv','url'=>array('admin')),
);
?>

<h1>Archivoscsvs</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
