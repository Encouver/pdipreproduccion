<?php

class ArchivoscsvController extends Controller
{
/**
* @var string the default layout for the views. Defaults to '//layouts/column2', meaning
* using two-column layout. See 'protected/views/layouts/column2.php'.
*/
//public $layout='//layouts/column2';
	public $salida;
	public $out;
	public $estatus;



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
		'actions'=>array('index','view'),
		'users'=>array('*'),
		),
		array('allow', // allow authenticated user to perform 'create' and 'update' actions
		'actions'=>array('import','update','export'),
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
private function NewGuid() { 
                $stamp = @date("Ymdhis");
                $s = strtoupper(md5(uniqid($stamp,true))); 
                $guidText = 
                        substr($s,0,8). 
                        substr($s,8,4). 
                        substr($s,12,4). 
                        substr($s,16,4). 
                        substr($s,20); 
                return $guidText;
	}


public function actionView($id)
{
$this->render('view',array(
'model'=>$this->loadModel($id),
));
}

public function Cronograma($model, $tipoCronograma = 'exportacion'){
	
	//Cronogramas::

	$sql="select * from pdi.cronogramas";
	$connection=Yii::app()->db; 
	$command = $connection->createCommand($sql);
	//$rowCount=$command->execute(); // execute the non-query SQL
	$dataReader=$command->query(); // execute a query SQL

	print_r($dataReader);

	foreach ($dataReader as $key => $value) {
		# code...
		echo $value;
	}

	die("probando");
	$errores='';
	// Uncomment the following line if AJAX validation is needed
	// $this->performAjaxValidation($model);
		
	$nc=7;
	$vista = 'export';
	if($tipoCronograma == 'importacion'){
		$nc=6;
		$vista = 'import';
	}

	if(isset($_POST['Archivoscsv']))
	{
		$nombre_tem = $this->NewGuid().'.csv';

		$model->proyecto_id=3;
		$model->tipo_csv=$tipoCronograma;
		if($tipoCronograma == 'importacion')
			$model->tipo_csv=$tipoCronograma;

		$model->attributes=$_POST['Archivoscsv'];
		$archivo=CUploadedFile::getInstance($model,'archivo');
		if($archivo)
		{
			$model->archivo = $nombre_tem;
		}
		
		//Archivoscsv::model()->deleteAll('proyecto_id=:proyecto_id and tipo_csv=:tipo',array(':proyecto_id'=>$model->proyecto_id, ':tipo'=>$tipoCronograma));
		
		
		//if($model->save())
		//{
			//$archivo->saveAs('csv/'.$tipoCronograma.'/'.$model->archivo);

			//$archivo = dirname(Yii::app()->request->scriptFile).'/csv/'.$tipoCronograma.'/'.$model->archivo;


			//$command = 'C:\Users\EdgarLeal\Desktop\data-integration\pan.sh -file:C:\Program Files (x86)\Apache Software Foundation\Apache2.2\htdocs\pdipreproduccion\protected\etl\carga_masiva.ktr -param:proyecto_id='.$model->proyecto_id.' -param:ruta='.$archivo.' -param:tipo='.$tipoCronograma;

			$command = '/home/www-data/data-integration/pan.sh -file:/home/www-data/data-integration/carga_masiva.ktr -param:proyecto_id=4 -param:ruta=/app/pdi-des/csv/exportacion/FF865AF7CBDBE277DBA818561F2419F2.csv -param:tipo=exportaciones';
;
	
			$this->salida = exec($command ,$this->out,$this->estatus);
			
		//}
	}

	$this->render($vista,array(
		'model'=>$model,'errores'=>$this->estatus
	));

}
/**
* Creates a new model.
* If creation is successful, the browser will be redirected to the 'view' page.
*/
public function actionExport()
{
	$model=new Archivoscsv;

	$this->Cronograma($model,'exportacion');
}

public function actionImport()
{
	$model=new Archivoscsv;

	$this->Cronograma($model,'importacion');	
}

public function actionDownload()
	{
		$file = 'ruta.rar';
		//echo $file;
        return Yii::app()->getRequest()->sendFile('archivo.rar',@file_get_contents($file),'application/x-rar-compressed');
		
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

if(isset($_POST['Archivoscsv']))
{
$model->attributes=$_POST['Archivoscsv'];
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
$dataProvider=new CActiveDataProvider('Archivoscsv');
$this->render('index',array(
'dataProvider'=>$dataProvider,
));
}

/**
* Manages all models.
*/
public function actionAdmin()
{
$model=new Archivoscsv('search');
$model->unsetAttributes();  // clear any default values
if(isset($_GET['Archivoscsv']))
$model->attributes=$_GET['Archivoscsv'];

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
$model=Archivoscsv::model()->findByPk($id);
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
if(isset($_POST['ajax']) && $_POST['ajax']==='archivoscsv-form')
{
echo CActiveForm::validate($model);
Yii::app()->end();
}
}
}
