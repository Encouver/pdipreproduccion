<?

/**
   plan de divisa masivo.
   Dpto: VTI Informatica 
   area: Gerencia Innovacion.
   fecha: 20/09/2014
   Desctripcion: @clase PlanDivisamsv que atendera la carga masiva, trabajara con la 
   clase principal plan de divisas para hacer los registros en los atributos de esa clase.
    codarancel_id integer NOT NULL,
    detarancelario_id integer NOT NULL,
    unidad_id integer NOT NULL,
    fecha_cierre date NOT NULL,
    cantidad integer NOT NULL,
    montousd double precision NOT NULL,
    empresa_id integer NOT NULL,
  CONSTRAINT id_presupuestos PRIMARY KEY (id)
*/

class PlmsvForm extends CFormModel
{
	public $file;
	//public $verificador;
    
	/**
	 * Declares the validation rules.
	 */
	public function rules()
	{
		return array(
			// name, email, subject and body are required
			array('file', 'required'),
			array('file',
				  'file',
				  'types'=>'csv',
				  'maxSize'=>1024*1024*10,
				  'allowEmpty'=>false,
				  'wrongType'=>'Solo es permitido formato .csv',
				  'tooLarge'=>'Limite de 10 MegaBytes'),
			// email has to be a valid email address
			//array('email', 'email'),
			// verifyCode needs to be entered correctly
			//array('verificador', 'captcha', 'allowEmpty'=>!CCaptcha::checkRequirements()),
		);
	}

	/**
	 * Declares customized attribute labels.
	 * If not declared here, an attribute would have a label that is
	 * the same as its name with the first letter in upper case.
	 */
	public function attributeLabels()
	{
		return array(
			'file'=>'file',
			//'verificador'=>'Captcha',
		);
	}

	public function readcsv($modelo,$file)
	{
	   //incializamos variables
	   $linea=1;//con esta variable vamos a indicar la linea que esta generando error
	   unset($registros);
	   $cantidad; 
     //
      //$baseMemory = memory_get_usage();//reduccion de memoria
      //cantidad refleja los registros que van para la base de datos.
       // estos son los arreglos que van a tomar los codigos arancelarios nuevos
       // y las lineas de errores en el momentos de validar con las Regex.
       // lo cual atendera el controlador para enviarlo a la vista
       // establecer las validaciones de cada registro para luego mandarlo
       // por JSON y sea verificado a través de la vista.
       //define ("_error",array());
       //define ("_cod",array());
       $errores = array('fallos'=>array('linea'=>array(),
                                        'mensaje'=>array()
                       )); // lineas de errores
       $codigos = array('codigos'=>array()); // codigos que no posee la empresa

       if (isset($modelo,$file)):
          //$file = CUploadedFile::getInstance($modelo,'file');
          try{
            if ($fp =fopen($file->tempName,"r")):

              while ($registros=fgetcsv($fp,1000,';')) 
              {
              	//$count=0;
              	$errores="";

              	 $PlmsvForm = new PlmsvForm;
                    //print_r($this->presupuesto->codarancel_id);die;
                    $mensaje[$linea]=self::__setVariables($registros);
                    //print_r($falla);die;
                    

                $linea++;
              }
              fclose($fp);
               //print_r($mensaje);
                if (isset($mensaje) && $mensaje[1]!=''):
                  return $mensaje;
                endif;               
              //print_r($cantidad); die;//vamos hacer la impresion de lo que contiene esta variable
              
            else:
              // throw new CHttpException(404,'fallo carga de los datos.');
              print("fallo");
            endif;
          }catch(Exception $e)
          {
             print ("Error de Lectura");
          }



       endif;
	}

  /**
    @clean_validation
    En este metodo estatico va a validar 
    y a filtrar todos los valores que van a registrarse 
    en la tabla temporal.
    se quitaran las comillas dobles y simples, seguidamente
  */

    public function otras_reglas()
    {
       return  array(
	   	  '0'=>array(
	   		 'regex'=>'/^[\d]{1,20}([\d]{1,10}|[\.])+[\d]$/',
	   	     'mensaje'=>'Codigo arancelario debe ir  Ejm: 325.3252.000'
	   	   ),
	   	  '1'=>array(
             'regex'=>'/^[\d]{1,100}$/',
             'mensaje'=>'Las unidades de medida se coloca en numeros ejem: 1'  
	   	   ),
         '2'=>array(
           'regex'=>'/^[0-9]{2}\/?[0-9]{2}\/?[0-9]{4}$/',
           'mensaje'=>'La fecha debe ir 02/12/2014' 
          ),

         '3' =>array(
            'regex'=>'/^[\d]{1,80}$/',
            'mensaje'=>'El monto en $ puede contener . y solo Numeros'
          ),

         '4' =>array(
            'regex'=>'/^[\d]{1,10}([\.]{1})?[0-9]{1,2}$/',
            'mensaje'=>'El monto en $ puede contener . y solo Numeros'
          ),
	    );  
    }

    // en esta funcion vamos a validar 
    // el tipo de datos y si esta vacio para que el usuario lo verifique
    static private function validacion_regex($datos,$c,$regex,$validacion)
    {
       // error me va informar si esta vacio//
		$mensaje;
    $c = $c+1;
		 if (isset($datos)):
		    if (!preg_match($regex,$datos)):
		    	return  $info = array('entrada'=>'Columna  '.$c,'mensaje'=>$validacion);
		    endif;  
		 else:
		   $mensaje='Campo esta vacio';
		   return $mensaje;
		 endif;
    
    }
    // aqui separamos el array que viene 
    // de fgetcsv y asi asignar los valores 
    // a cada variable
    public function __setVariables($registros)
    {
      $error_validaciones='';
      $cantidad = count($registros);
     // $cantidad -1;
      //print_r($cantidad);
      for ($i=0; $i <$cantidad-1; $i++) { 

        if (array_key_exists($i, $registros) && $registros[$i]==="")
        {
          return $error_validaciones = "Falta registrar un campo=>".$i.$registros[$i]; break;
        }else if($cantidad<5 || $cantidad>5)
        {
          return $error_validaciones = "Debe colocar por cada linea 5 campos"; break;
        }
       }
       $validaciones = self::otras_reglas();
       for ($j=0; $j<$cantidad-1; $j++) { 
         # code...
         $falla=self::validacion_regex($registros[$j],$j,$validaciones[$j]['regex'],$validaciones[$j]['mensaje']); 
         if (is_array($falla))
         {
           
           $error_validaciones.=" ".$falla['entrada'].$falla['mensaje'];
           continue;

         }else
           continue;

       }
       if (isset($error_validaciones))
       {
          return $error_validaciones;
       }
    }
}