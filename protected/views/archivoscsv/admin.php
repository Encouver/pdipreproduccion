<?php
$this->breadcrumbs=array(
	'Archivoscsvs'=>array('index'),
	'Manage',
);

$this->menu=array(
array('label'=>'List Archivoscsv','url'=>array('index')),
array('label'=>'Subir archivos import','url'=>array('import')),
array('label'=>'Subir archivos export','url'=>array('export')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('archivoscsv-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Manage Archivoscsvs</h1>

<p>
	You may optionally enter a comparison operator (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>
		&lt;&gt;</b>
	or <b>=</b>) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button btn')); ?>
<div class="search-form" style="display:none">
	<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('booster.widgets.TbGridView',array(
'id'=>'archivoscsv-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'columns'=>array(
		'id',
		'proyecto_id',
		'archivo',
		'tipo_csv',
		'fecha',
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
