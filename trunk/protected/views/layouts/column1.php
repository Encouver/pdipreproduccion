<?php /* @var $this Controller */ ?>
<?php $this->beginContent('//layouts/main'); ?>
<div class="row">	
	<div id="layout" class="<?php if(!Yii::app()->user->isGuest): echo 'col-xs-4 col-md-3'; else: echo 'disable';  endif ?>">
		<div class="menu_item">
			<div id="herramienta"><span class="title_2"><center>HERRAMIENTAS</center></span></div>
				<?php
					$this->widget('booster.widgets.TbMenu',array(
						'type' => 'list',
						'items'=>array(
								array('label'=>'Inicio','icon'=>'home', 'url'=>array('/site/index'), 'visible'=>!Yii::app()->user->isGuest),
								array('label'=>'Registrar Plan de Divisa','icon'=>'plus', 'url'=>array('/site/page', 'view'=>'about'), 'visible'=>!Yii::app()->user->isGuest),									
								array('label'=>'Masivo','icon'=>'plus', 'url'=>array('/pmsv/importar'), 'visible'=>!Yii::app()->user->isGuest),
								/*array('label'=>'Iniciar Sesión', 'url'=>array('/site/login'), 'visible'=>Yii::app()->user->isGuest),*/
								array('label'=>'Salir', 'icon'=>'off', 'url'=>array('/site/logout'), 'visible'=>!Yii::app()->user->isGuest)
								),
						)); 		
				?>
		</div>
	</div>	
	<div id="layout" class="<?php if(!Yii::app()->user->isGuest): echo 'col-xs-8 col-md-9'; else: echo 'col-md-12';  endif ?>">
		<div id="heading">
			<div class="head"><span class="title_4">Plan de Divisas</span><span class="pull-right title_2"><?php if(!Yii::app()->user->isGuest): echo "<i class='glyphicon glyphicon-user'></i>&nbsp;".Yii::app()->user->name; endif ?></span></div>
		</div>			
		<div id="content">
			<?php echo $content; ?>
		</div><!-- content -->
		
	</div>
	
</div>

<div id="footer">
	<div class="row">
        <div class="col-md-3"><img class="img-responsive" src="images/logofoot.svg" /></div>
        <div class="col-md-6">
        	<div class="btn-group">
        		<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-envelope"></span></button>
        		<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-file"></span></button>
        		<button class="btn btn-default" type="button"><span class="glyphicon glyphicon-info-sign"></span></button>        		
      		</div>        	
        </div>
        <div class="col-md-3"><p>CENCOEX garantiza la confidencialidad de los datos suministrados amparados en la ley de asuntos informáticos vigente.</p></div>
      </div>				
	</div><!-- footer -->
	
	<?php $this->endContent(); ?>