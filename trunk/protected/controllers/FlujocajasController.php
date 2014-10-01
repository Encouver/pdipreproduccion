<?php

class FlujocajasController extends Controller
{
/**
* @var string the default layout for the views. Defaults to '//layouts/column2', meaning
* using two-column layout. See 'protected/views/layouts/column2.php'.
*/
//public $layout='//layouts/column2';

/**
* @return array action filters
*/
public function filters()
{
return array(
'accessControl', // perform access control for CRUD operations
);
}

/**
* Specifies the access control rules.
* This method is used by the 'accessControl' filter.
* @return array access control rules
*/
public function accessRules()
{
return array(
array('allow',  // allow all users to perform 'index' and 'view' actions
'actions'=>array('index','view', 'siguiente','anterior','gtod','actualizar'),
'users'=>array('*'),
),
array('allow', // allow authenticated user to perform 'create' and 'update' actions
'actions'=>array('create','update'),
'users'=>array('*'),
),
array('allow', // allow admin user to perform 'admin' and 'delete' actions
'actions'=>array('admin','delete'),
'users'=>array('*'),
),
array('deny',  // deny all users
'users'=>array('*'),
),
);
}

/**
* Displays a particular model.
* @param integer $id the ID of the model to be displayed
*/
public function actionView($id)
{
	$this->render('view',array(
		'model'=>$this->loadModel($id),
	));
}

public function actionAnterior(){
	$modelos = Yii::app()->session['modelos'];

	$periodoAno = Yii::app()->session['periodoSel'];
	$anos = Yii::app()->session['anoSel'];

	if(isset($_POST['Flujocajas']))
	{
		if(isset($modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]))
		{
			$modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]->attributes = $_POST['Flujocajas'];
			if($modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]->validate()){
				//echo 'bien';
			}
		}
	}

	if(isset($_POST['Totalflujocajas'])){
		$total = new Totalflujocajas;
		$total->attributes =  $_POST['Totalflujocajas'];
		Yii::app()->session['totalFlujoCajas']->valor_neto = $total->valor_neto;
		Yii::app()->session['totalFlujoCajas']->costo_beneficio = $total->costo_beneficio;
		Yii::app()->session['totalFlujoCajas']->tasa_retorno = $total->tasa_retorno;

		Yii::app()->session['totalFlujoCajas']->validate(array('valor_neto','costo_beneficio','tasa_retorno'));
	}

		Yii::app()->session['periodo'] = Yii::app()->session['periodo'] - 1;
		if(Yii::app()->session['periodo']<0)
			Yii::app()->session['periodo'] = $periodoAno-1;	
		if(Yii::app()->session['periodo'] == $periodoAno-1){	
			if(Yii::app()->session['ano'] > 0)	
				Yii::app()->session['ano']= Yii::app()->session['ano'] - 1;
			else
			{
				Yii::app()->session['periodo']+=1;
				Yii::app()->session['periodo']=abs(Yii::app()->session['periodo'] % $periodoAno);
			}

		}

	Yii::app()->session['modelos'] = $modelos;

	$this->renderPartial('_form',array(
		'model'=>$modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']],'total'=>Yii::app()->session['totalFlujoCajas']
	));
}
public function actionSiguiente(){
	$modelos = Yii::app()->session['modelos'];

	$periodoAno = Yii::app()->session['periodoSel'];
	$anos = Yii::app()->session['anoSel'];

	if(isset($_POST['Flujocajas']))
	{
		if(isset($modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]))
		{
			$modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]->attributes = $_POST['Flujocajas'];
			if($modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]->validate()){
				//echo 'bien';
				Yii::app()->session['periodo']+=1;
				Yii::app()->session['periodo']=abs(Yii::app()->session['periodo'] % $periodoAno);
				if(Yii::app()->session['periodo'] == 0){	
					if(Yii::app()->session['ano'] < $anos)	
						Yii::app()->session['ano']+=1;
					else
					{
						$this->redirect(array('index'));
						Yii::app()->session['periodo']=Yii::app()->session['periodo'] - 1;
						Yii::app()->session['periodo']=abs(Yii::app()->session['periodo'] % $periodoAno);
					}
				}
			}
		}
	}

	if(isset($_POST['Totalflujocajas'])){
		$total = new Totalflujocajas;
		$total->attributes =  $_POST['Totalflujocajas'];
		Yii::app()->session['totalFlujoCajas']->valor_neto = $total->valor_neto;
		Yii::app()->session['totalFlujoCajas']->costo_beneficio = $total->costo_beneficio;
		Yii::app()->session['totalFlujoCajas']->tasa_retorno = $total->tasa_retorno;

		Yii::app()->session['totalFlujoCajas']->validate(array('valor_neto','costo_beneficio','tasa_retorno'));

	}

	
	Yii::app()->session['modelos'] = $modelos;
	
		$this->renderPartial('_form',array(
			'model'=>$modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']],'total'=>Yii::app()->session['totalFlujoCajas']
		));

}

public function actionGtod()
{

	//echo '<h1>ENTRE</h1>';

	$modelos = Yii::app()->session['modelos'];
	$totalFlujoCajas = Yii::app()->session['totalFlujoCajas'];

	$periodoAno = Yii::app()->session['periodoSel'];
	$anos = Yii::app()->session['anoSel'];

	if(isset($_POST['Totalflujocajas'])){
		$total = new Totalflujocajas;
		$total->attributes =  $_POST['Totalflujocajas'];
		$totalFlujoCajas->valor_neto = $total->valor_neto;
		$totalFlujoCajas->costo_beneficio = $total->costo_beneficio;
		$totalFlujoCajas->tasa_retorno = $total->tasa_retorno;
	}
	if(isset($_POST['Flujocajas']))
	{
		$modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]->attributes = $_POST['Flujocajas'];
		$error  = !$modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]->validate();
		$error =  !$totalFlujoCajas->validate() || $error;
		if($error)
		{
				$this->renderPartial('_form',array(
				'model'=>$modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']],'total'=>$totalFlujoCajas
				));
				Yii::app()->end();
				
		}

	}

	$transaction = Yii::app()->db->beginTransaction();
	try
	{
		for($i=0; $i<=$anos; $i++)
		{
			for($j=0;$j<$periodoAno;$j++){
				if($modelos[$i][$j]->save())
				{

				}else{throw new Exception("Hubo un error guardando los datos.", 1);

				}
			}
		}

			if($totalFlujoCajas->save()){
			}else throw new Exception(CHtml::errorSummary($totalFlujoCajas), 1);


	  	$transaction->commit();

	  	$this->limpiarSessions();

		 echo CHtml::link('Registro completado',array('flujocajas/admin'));

	}catch(Exception $e)
	{
	    $transaction->rollback();
	    throw $e;
	}


}

/**
* Creates a new model.
* If creation is successful, the browser will be redirected to the 'view' page.
*/

public function actionCreate()
{	  			  
	$model=new Flujocajas;
	$totalFlujoCajas = new Totalflujocajas;
	// Uncomment the following line if AJAX validation is needed
	// $this->performAjaxValidation($model);

	$proyecto_id = 3;

	// Solo puede haber un plan para cada proyecto.
	if(Totalflujocajas::model()->find('proyecto_id=?',array($proyecto_id)))
		$this->redirect(array('admin'));

	if(isset(Yii::app()->session['modelos']) && isset(Yii::app()->session['totalFlujoCajas'])){
		$modelos = Yii::app()->session['modelos'];
		$totalFlujoCajas = Yii::app()->session['totalFlujoCajas'];
		
		if(isset($_POST['Flujocajas']))
		{
			$modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]->attributes=$_POST['Flujocajas'];	

			if($modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]->validate()){
				//$this->redirect(array('view','id'=>$model->id));
			}
		}

		$this->render('create',array(
		'model'=>$model, 'total'=>$totalFlujoCajas
		));
		Yii::app()->end();
	}
	elseif(isset($_POST['Totalflujocajas']))
	{
		$totalFlujoCajas->attributes = $_POST['Totalflujocajas'];
		
		if($totalFlujoCajas->validate(array('periodo_id','anos')))
		{	
			$totalFlujoCajas->proyecto_id = $proyecto_id;
			$totalFlujoCajas->estatus = 1;

			Yii::app()->session['totalFlujoCajas'] = $totalFlujoCajas;

			$periodoAno = Periodos::model()->find('id=?',array($totalFlujoCajas->periodo_id))->valor;

			$modelos[][] = new Flujocajas;
			for($i=0; $i<=$totalFlujoCajas->anos; $i++)
			{
				for($j=0;$j<$periodoAno;$j++){
					$modelos[$i][$j] = new Flujocajas;
					$modelos[$i][$j]->proyecto_id = $proyecto_id;
					$modelos[$i][$j]->ano = $i;
					$modelos[$i][$j]->periodo = $j;
				}
			}

			Yii::app()->session['modelos'] = $modelos;

			Yii::app()->session['ano'] = 0;
			Yii::app()->session['periodo'] = 0;
			Yii::app()->session['periodoSel'] = $periodoAno;
			Yii::app()->session['anoSel'] = $totalFlujoCajas->anos;

		$this->render('create',array(
		'model'=>$modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']], 'total'=>$totalFlujoCajas
		));

		Yii::app()->end();
		}


	}


	$this->render('create',array(
	'model'=>$model, 'totalFlujoCajas'=>$totalFlujoCajas
	));
}
	private function limpiarSessions(){
		if(isset(Yii::app()->session['modelos']))
	  	unset(Yii::app()->session['modelos']);
	  if(isset(Yii::app()->session['totalFlujoCajas']))
	  	unset(Yii::app()->session['totalFlujoCajas']);
	  if(isset(Yii::app()->session['ano']))
	  	unset(Yii::app()->session['ano']);
	  if(isset(Yii::app()->session['periodo']))
	  	unset(Yii::app()->session['periodo']);
	  if(isset(Yii::app()->session['anoSel']))
	  	unset(Yii::app()->session['anoSel']);
	  if(isset(Yii::app()->session['periodoSel']))
	  	unset(Yii::app()->session['periodoSel']);
	  }
// Recibe el id del proyecto
public function actionUpdate($id)
{

		$this->limpiarSessions();
	
	$model = new Flujocajas;
	$totalFlujoCajas = new Totalflujocajas;

	if(!isset(Yii::app()->session['modelos']) && !isset(Yii::app()->session['totalFlujoCajas'])){
		$totalFlujoCajas = Totalflujocajas::model()->find('proyecto_id=?',array($id));		
		$flujoCajas = Flujocajas::model()->findAll('proyecto_id=?', array($id));
		
		if($totalFlujoCajas && $flujoCajas){
			Yii::app()->session['totalFlujoCajas'] = $totalFlujoCajas;
			$periodo = Periodos::model()->find('id=?',array($totalFlujoCajas->periodo_id));
				if(count($flujoCajas) == ($totalFlujoCajas->anos+1)*$periodo->valor)
				{
					//Se cargo bien
					$modelos[][] = new Flujocajas;
					foreach ($flujoCajas as $key => $value) {
						$modelos[$value->ano][$value->periodo] = $value;	
					}

					Yii::app()->session['modelos'] = $modelos;
					Yii::app()->session['totalFlujoCajas'] = $totalFlujoCajas;

					Yii::app()->session['ano'] = 0;
					Yii::app()->session['periodo'] = 0;
					Yii::app()->session['periodoSel'] = $periodo->valor;
					Yii::app()->session['anoSel'] = $totalFlujoCajas->anos;

				}else
				{
					//problema en la carga
				}

		
		$this->render('update',array(
			'model'=> Yii::app()->session['modelos'][Yii::app()->session['ano']][Yii::app()->session['periodo']], 
			'total'=> Yii::app()->session['totalFlujoCajas']
		));
		}
	}

}

/**
* Updates a particular model.
* If update is successful, the browser will be redirected to the 'view' page.
* @param integer $id the ID of the model to be updated
*//*
public function actionUpdate($id)
{
	$model=$this->loadModel($id);

	// Uncomment the following line if AJAX validation is needed
	// $this->performAjaxValidation($model);

	if(isset($_POST['Flujocajas']))
	{
		$model->attributes=$_POST['Flujocajas'];
		if($model->save())
			$this->redirect(array('view','id'=>$model->id));
	}

	$this->render('update',array(
		'model'=>$model,
	));
}*/

public function actionDelete($id)
{

	
	$transaction = Yii::app()->db->beginTransaction();
	try
	{
		if(Totalflujocajas::model()->deleteAll('proyecto_id=?', array($id))){
		}else throw new Exception('No se pudo eliminar.', 1);

		if(Flujocajas::model()->deleteAll('proyecto_id=?', array($id))){
		}else throw new Exception('No se pudo eliminar.', 1);

	  	$transaction->commit();

	}catch(Exception $e)
	{
	    $transaction->rollback();
	    throw $e;
	}

	$this->redirect(array('admin'));
}


/**
* Deletes a particular model.
* If deletion is successful, the browser will be redirected to the 'admin' page.
* @param integer $id the ID of the model to be deleted
*//*
public function actionDelete($id)
{
	if(Yii::app()->request->isPostRequest)
	{
	// we only allow deletion via POST request
	$this->loadModel($id)->delete();

	// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
	if(!isset($_GET['ajax']))
		$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
	}
	else
		throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
}*/

/**
* Lists all models.
*/
public function actionIndex()
{
$dataProvider=new CActiveDataProvider('Flujocajas');
$this->render('index',array(
'dataProvider'=>$dataProvider,
));
}

/**
* Manages all models.
*/
public function actionAdmin()
{
	$this->limpiarSessions();
	
	$model=new Totalflujocajas('search');
	$model->unsetAttributes();  // clear any default values
	if(isset($_GET['Totalflujocajas']))
		$model->attributes=$_GET['Totalflujocajas'];

	$this->render('admin',array(
	'model'=>$model,
	));
}

/**
* Returns the data model based on the primary key given in the GET variable.
* If the data model is not found, an HTTP exception will be raised.
* @param integer the ID of the model to be loaded
*/
public function loadModel($id)
{
$model=Flujocajas::model()->findByPk($id);
if($model===null)
throw new CHttpException(404,'The requested page does not exist.');
return $model;
}

/**
* Performs the AJAX validation.
* @param CModel the model to be validated
*/
protected function performAjaxValidation($model)
{
if(isset($_POST['ajax']) && $_POST['ajax']==='flujocajas-form')
{
echo CActiveForm::validate($model);
Yii::app()->end();
}
}
}
