<?php

class FlujocajasController extends Controller
{
/**
* @var string the default layout for the views. Defaults to '//layouts/column2', meaning
* using two-column layout. See 'protected/views/layouts/column2.php'.
*/
public $layout='//layouts/column2';

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
'actions'=>array('index','view', 'siguiente','anterior'),
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
	if(isset($modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]))
	{
		$modelos[Yii::app()->session['ano']][Yii::app()->session['periodo']]->attributes = $_POST['Flujocajas'];
		if($modelos->save())
			echo 'bien';
	}
	Yii::app()->session['periodo']-=1;
	Yii::app()->session['periodo']=Yii::app()->session['periodo']%Yii::app()->session['periodoSel'];
	if(Yii::app()->session['periodo'] == Yii::app()->session['periodoSel']-1){	
		if(Yii::app()->session['ano'] > 0)	
			Yii::app()->session['ano']-=1;
	}
	Yii::app()->session['modelos'] = $modelos;
	$this->renderPartial('_form',array(
		'model'=>Yii::app()->session['modelos'][Yii::app()->session['ano']][Yii::app()->session['periodo']],//'totalFlujoCajas'=>$totalFlujoCajas
	));
}
public function actionSiguiente(){
	$modelos = Yii::app()->session['modelos'];	

	if(isset($_POST['Flujocajas']))
	{
		if(isset($modelos[Yii::app()->session['ano'].'_'.Yii::app()->session['periodo']]))
		{
			$modelos[Yii::app()->session['ano'].'_'.Yii::app()->session['periodo']]->attributes = $_POST['Flujocajas'];
			if($modelos[Yii::app()->session['ano'].'_'.Yii::app()->session['periodo']]->save())
				echo 'bien';
		}
	}

	Yii::app()->session['periodo']+=1;
	Yii::app()->session['periodo']=Yii::app()->session['periodo']%Yii::app()->session['periodoSel'];
	if(Yii::app()->['periodo'] == 0){	
		if(Yii::app()->session['ano'] < Yii::app()->session['anoSel'])	
			Yii::app()->session['ano']+=1;
	}
	Yii::app()->session['modelos'] = $modelos;

	$this->renderPartial('_form',array(
		'model'=>Yii::app()->session['modelos'],//'totalFlujoCajas'=>$totalFlujoCajas
	));
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

	if(isset($_POST['Totalflujocajas']))
	{
		$totalFlujoCajas->attributes = $_POST['Totalflujocajas'];

		$valorPeriodo = Periodos::model()->find('id=?',array($totalFlujoCajas->periodo_id))->valor;

		//$modelos = array(array());
		for($i=0; $i<$totalFlujoCajas->anos; $i++)
		{
			for($j=0;$j<$valorPeriodo;$j++)
				$modelos[$i.'_'.$j] = new Flujocajas;
		}
		Yii::app()->session['modelos'] = $modelos;

		Yii::app()->session['ano'] = 0;
		Yii::app()->session['periodo'] = 0;
		Yii::app()->session['periodoSel'] = $valorPeriodo;
		Yii::app()->session['anoSel'] = $totalFlujoCajas->anos;
		/*$this->render('flujo',array(
			'model'=>$model,'totalFlujoCajas'=>$totalFlujoCajas
			));*/
		//Yii::app()->end();
	}

	if(isset($_POST['Flujocajas']))
	{
		$model->attributes=$_POST['Flujocajas'];
		if($model->save())
			$this->redirect(array('view','id'=>$model->id));
	}

	$this->render('create',array(
	'model'=>$model,'totalFlujoCajas'=>$totalFlujoCajas
	));
}

/**
* Updates a particular model.
* If update is successful, the browser will be redirected to the 'view' page.
* @param integer $id the ID of the model to be updated
*/
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
}

/**
* Deletes a particular model.
* If deletion is successful, the browser will be redirected to the 'admin' page.
* @param integer $id the ID of the model to be deleted
*/
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
}

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
$model=new Flujocajas('search');
$model->unsetAttributes();  // clear any default values
if(isset($_GET['Flujocajas']))
$model->attributes=$_GET['Flujocajas'];

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
