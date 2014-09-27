<?php

class ArchivoscsvController extends Controller
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
		'actions'=>array('index','view'),
		'users'=>array('*'),
		),
		array('allow', // allow authenticated user to perform 'create' and 'update' actions
		'actions'=>array('importcsv','update'),
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

/**
* Creates a new model.
* If creation is successful, the browser will be redirected to the 'view' page.
*/
public function actionExportcsv()
{
	$model=new Archivoscsv;
	

	// Uncomment the following line if AJAX validation is needed
	// $this->performAjaxValidation($model);

	if(isset($_POST['Archivoscsv']))
	{
		$nombre_tem = $this->NewGuid().'.csv';

		$model->proyecto_id=3;
		$model->tipo_csv=1;
		$model->attributes=$_POST['Archivoscsv'];
		$archivo=CUploadedFile::getInstance($model,'archivo');
		$model->archivo = $nombre_tem;
		if($model->save())
		{
			$archivo->saveAs('csv/'.$model->archivo);

			$archivo = Yii::app()->basePath."\\csv\ ".$model->archivo;

			$fila = 1;
			$errores='';
			if (($gestor = fopen($archivo, "r")) !== FALSE) {
			    while (($datos = fgetcsv($gestor, 6, ",")) !== FALSE) {
			        
			        $numero = count($datos);
			        //echo "<p> $numero de campos en la línea $fila: <br /></p>\n";

			        if($numero==6)
			        {
				    	$cronograma = new Cronogramaexport;

				    	if($datos[0])
				    		$cronograma->insumo	= $datos[0];
				    	if($datos[1])
				    		$cronograma->cod_arancelario = $datos[1];
				    	if($datos[2]){
				    		$cunidad = GenUnidades::model()->find('dunidad=:unidad',array(':unidad'=>$datos[2]))->cunidad;
				    		if($cunidad)
				    			$cronograma->unidad_id = $cunidad;
				    		else
				    			//$errores .= '<br> unidad: '.$cunidad.' no existe';
				    	}
				    	if($datos[3])
				    		$cronograma->cantidad = $datos[3];
				    	if($datos[4])
				    		$cronograma->costo_total = $datos[4];
				    	if($datos[5])
				    		$cronograma->fecha_estimada	= $datos[5];

				    	if($cronograma->save())
				    	{
				    		//echo 'Registro número: '.$fila.' guardado satisfactoriamente.'
				    	}
			        }else
			        	//$errores .= '<br>\n Falta una coplumna en la linea: '.$fila;


			        $fila++;
			        /*for ($c=0; $c < $numero; $c++) {
			            echo $datos[$c] . "<br />\n";
			        }*/
			    }
			    fclose($gestor);
			}

			$this->redirect(array('view','id'=>$model->id));
		}
	}

	$this->render('importcsv',array(
		'model'=>$model,
	));
}

public function actionImportcsv()
{

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
