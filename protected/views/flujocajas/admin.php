<?php
$this->breadcrumbs=array(
	'Flujocajases'=>array('index'),
	'Manage',
);

$this->menu=array(
array('label'=>'List Flujocajas','url'=>array('index')),
array('label'=>'Create Flujocajas','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('flujocajas-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Manage Flujocajases</h1>

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
'id'=>'flujocajas-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'columns'=>array(
		'id',
		'inversion',
		'prestamo',
		'ingresos',
		'costos',
		'reinversion',
		/*
		'valor_residual',
		'pagos',
		'depreciacion_negativo',
		'utilidad_antesimp',
		'utilidad_despuesimp',
		'impuestos',
		'depreciacion_positivo',
		'flujo_operativo',
		'flujo_proyectado',
		'ingresos_rcb',
		'costos_rcb',
		'ingresos_rcbact',
		'costos_rcbact',
		'fecha_registro',
		'estatus',
		'proyecto_id',
		*/
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
