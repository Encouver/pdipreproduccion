<?php
$this->breadcrumbs=array(
	'Archivoscsvs'=>array('index'),
	'Importcsv',
);

$this->menu=array(
array('label'=>'List Archivoscsv','url'=>array('index')),
array('label'=>'Manage Archivoscsv','url'=>array('admin')),
);
if($errores)
	echo $errores;
?>

<h1>Subir archivo para import</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>