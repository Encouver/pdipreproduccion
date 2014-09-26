<?php /* @var $this Controller */ ?>
<?php $this->beginContent('//layouts/main'); ?>

	<div id="content">
		<?php echo $content; ?>
	</div><!-- content -->


	<div id="sidebar">
	<?php
						$this->widget('booster.widgets.TbMenu',array(
							'type' => 'list',
							'items'=>array(
									array('label'=>'Inicio','icon'=>'home', 'url'=>array('/site/index')),
									array('label'=>'Registrar Plan de Divisa','icon'=>'plus', 'url'=>array('/site/page', 'view'=>'about')),									
									/*array('label'=>'Iniciar Sesión', 'url'=>array('/site/login'), 'visible'=>Yii::app()->user->isGuest),*/
									array('label'=>'Cerrar Sesión ('.Yii::app()->user->name.')', 'icon'=>'off', 'url'=>array('/site/logout'), 'visible'=>!Yii::app()->user->isGuest)
									),
							)); 		
					?>
	<?php
		$this->beginWidget('zii.widgets.CPortlet', array(
			'title'=>'Operations',
		));
		$this->widget('zii.widgets.CMenu', array(
			'items'=>$this->menu,
			'htmlOptions'=>array('class'=>'operations'),
		));
		$this->endWidget();
	?>
	</div><!-- sidebar -->

<?php $this->endContent(); ?>