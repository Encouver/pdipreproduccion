<?php
$this->breadcrumbs=array(
	'Archivoscsvs'=>array('index'),
	'Exportcsv',
);

$this->menu=array(
array('label'=>'List Archivoscsv','url'=>array('index')),
array('label'=>'Manage Archivoscsv','url'=>array('admin')),
);
if($errores)
	echo $errores;
?>

<h1>Create Archivoscsv</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>