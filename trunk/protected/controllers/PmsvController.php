<?php

/**
   Dpto: VTI Informatica 
   area: Gerencia Innovacion.
   fecha: 20/09/2014
   Desctripcion: @Controller  PlanDivisamsv receptor de los datos.
*/
class PmsvController extends Controller
{
	/**
	 * Acciones del controller
	 */
	public function actions()
	{
		return array(
			// captcha action renders the CAPTCHA image displayed on the contact page
			/*'captcha'=>array(
				'class'=>'CCaptchaAction',
				'backColor'=>0xFFFFFF,
			),*/
			// page action renders "static" pages stored under 'protected/views/site/pages'
			// They can be accessed via: index.php?r=site/page&view=FileName
			/*'page'=>array(
				'class'=>'CViewAction',
			),*/
		);
	}

	/**
	  @metodo para renderizar la vista  carga masiva 
	  @PlMsv
	*/
     //$this->redirect(array('update', 'id' => $model->primaryKey));

	 public function actionImportar()
	 {
       $model=new PlmsvForm;

        //print_r($_REQUEST);
		if(isset($_POST['PlmsvForm']) && isset($_POST['PlmsvForm']['file']))
		{
			$model->attributes=$_POST['PlmsvForm'];
			$file = CUploadedFile::getInstance($model,'file');
			if (isset($file))
			  $model->file = $file->name;

			if($model->validate())
			{
		       //print "Validate";
			   $resultado = $model->readcsv($model,$file);
			   if (isset($resultado) && $resultado[1]!=''){
			   	 //$_SESSION['error']=$resultado;
			   	// print_r($resultado);die;
			   	 Yii::app()->session['error'] = $resultado;
			     $this->redirect(array('pmsv/resultado'));
			   }

			}
		}
		$this->render('_emitir',array('model'=>$model));
	 }


	 public function actionResultado()
	 {
       $this->render('_resultado');
	 }

}