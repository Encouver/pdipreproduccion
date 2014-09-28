<?php
/* @var $this SiteController */

$this->pageTitle=Yii::app()->name;
?>
<div class="relleno">
	<div style="padding: 75px; text-align: center;">
<p class="title_1">Bienvenido al Sistema de Plan de Divisas</p>
<p>selecciones las opciones que usted dispone en el men&uacute; <b>Herramientas</b></p>
	</div>
</div>

<?php 

$model = new Flujocajas;
$this->widget('ext.editable.EditableDetailView', array(
    'id' => 'flujo_caja',
    'data' => $model,
    'url' => $this->createUrl('user/update'),  //common submit url for all editables
    'attributes'=>array(
        'user_name',
        array(  //select loaded from database
            'name' => 'group_id',
            'editable' => array(
                'type' => 'select',
                'source' => CHtml::listData(Group::model()->findAll(), 'group_id', 'group_name')
             )
        ),
        array(  //select loaded from array
            'name' => 'user_sex',
            'editable' => array(
                'type'    => 'select',
                'source'  => array(0 => 'Male', 1 => 'Female'),
                'prepend' => 'Hidden'
            )
        ),             
        array(  //select loaded from ajax. Text is colored by 'onRender' event
            'name' => 'user_status',
            'value' => Chtml::value($model, 'status.status_text'),
            'editable' => array(
                'type'   => 'select',
                'source' => $this->createUrl('user/getstatuslist'),
                'onRender' => 'js: function(e, edt) {
                      var colors = {1: "green", 2: "blue", 3: "red", 4: "gray"};
                      $(this).css("color", colors[edt.value]);    
                 }',                
            )
        ),
        array(
            'name' => 'user_dob',
            'editable' => array(
                'type' => 'date',
                'viewformat' => 'dd/mm/yyyy'
               )
        ),
        'user_comment',
        'created_at',  //not editable as attribute is not safe
    )
));

?>