
<? if (isset(Yii::app()->session['error'])):?>
<div id="header">
  <span class="title_1">Fallas en el Registro</span>
  <span class="pull-right">
 </div>
	  <div class="relleno">
         <fieldset>
           <legend>Errores</legend>
	  	<div>
          <? $resultado =Yii::app()->session['error'];
             unset(Yii::app()->session['error']);
          ?>
          <?//print_r($resultado);die;?>
		  <? for ($i=0; $i <count($resultado) ; $i++) { 
		  	  print($resultado[$i+1]);
		     }?>  
		</div>
        </fieldset>	  	
	  </div>
  
 <?endif;?>


