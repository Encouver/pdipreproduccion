<?php
/* @var $this SiteController */

$this->pageTitle=Yii::app()->name . ' - About';
$this->breadcrumbs=array(
	'About',
);

?>
<div id="header">
		<span class="title_1">Registro del Plan de Divisas Masivo</span>
		<span class="pull-right"><a><i class="glyphicon glyphicon-envelope"></i></a>&nbsp;&nbsp;<a><i class="glyphicon glyphicon-file"></i></a>&nbsp;&nbsp;<a><i class="glyphicon glyphicon-info-sign"></i></a></span>
	</div>
<div class="relleno">
	
<form role="form">

<fieldset>
	<legend>Datos Empresa</legend>
		<div class="row">
		<?php foreach($info as $valor){ ?>
			<div class="col-xs-6 col-md-6">
					<div class="form-group">
						<label for="exampleInputEmail1">Nombre de la empresa</label>
						<input type="email" class="form-control" id="exampleInputEmail1" placeholder="<?php echo $valor.DNOMBRE; ?>">
					</div>
				</div>
				<div class="col-xs-6 col-md-6">
					<div class="form-group">
				    	<label for="exampleInputPassword1">RIF</label>
				    	<input type="text" class="form-control" id="exampleInputPassword1" placeholder="<?php echo $valor.CRIF; ?>">
				  	</div>
				</div>
			<?PHP } ?>
		</div>
</fieldset>
<fieldset>
	<legend>Informaci&oacute;n Fiscal</legend>
		<div class="row">
			<div class="col-xs-4 col-md-4">
				<div class="form-group">
		    		<label for="exampleInputPassword1">N&uacute;mero ultima declaraci&oacute;n ISRL</label>
		    		<input type="text" class="form-control" id="exampleInputPassword1" placeholder="N&uacute;mero ultima declaraci&oacute;n ISRL">
		  		</div>
			</div>
			<div class="col-xs-4 col-md-4">
				<div class="form-group">
					<label for="exampleInputEmail1">Fecha declaraci&oacute;n</label>
					<input type="email" class="form-control" id="exampleInputEmail1" placeholder="Fecha declaraci&oacute;n">
				</div>
			</div>
			<div class="col-xs-4 col-md-4">
				<div class="form-group">
					<label for="exampleInputEmail1">Monto declarado</label>
					<input type="email" class="form-control" id="exampleInputEmail1" placeholder="Monto declarado">
				</div>
			</div>
		</div>
</fieldset>
<fieldset>
	<legend>Informaci&oacute;n IVSS</legend>
		<div class="row">
			<div class="col-xs-4 col-md-4">
			<div class="form-group">
				<label for="exampleInputEmail1">Fecha declaraci&oacute;n</label>
				<input type="email" class="form-control" id="exampleInputEmail1" placeholder="Fecha declaraci&oacute;n">
			</div>
			</div>
			<div class="col-xs-4 col-md-4">
				<div class="form-group">
					<label for="exampleInputEmail1">N&uacute;mero de empleados a su cargo</label>
					<input type="email" class="form-control" id="exampleInputEmail1" placeholder="N&uacute;mero de empleados a su cargo">
				</div>
			</div>
			<div class="col-xs-4 col-md-4">
				<div class="form-group">
					<label for="exampleInputEmail1">Fecha cotizaci&oacute; IVSS</label>
					<input type="email" class="form-control" id="exampleInputEmail1" placeholder="Fecha cotizaci&oacute; IVSS">
				</div>
			</div>
		</div>
</fieldset>
	<div class="row">
		<div class="col-md-12">
			<div class="form-group">
    			<label for="exampleInputFile">Carga masiva</label>
    			<input type="file" id="exampleInputFile">
    			<p class="help-block">Seleccione el archivo para realizar la carga masiva.</p>
  			</div>
  		</div>		
		<hr />
		<div class="col-md-12">
			<button type="submit" class="btn btn-primary">Registrar</button>
		</div>
	</div><!-- row -->

</form>

</div><!-- relleno -->