<?

/**
   plan de divisa masivo.
   Dpto: VTI Informatica 
   area: Gerencia Innovacion.
   fecha: 20/09/2014
   Desctripcion: @clase PlanDivisamsv que atendera la carga masiva, trabajara con la 
   clase principal plan de divisas para hacer los registros en los atributos de esa clase.
*/

class PlanDivisamsv extends CFormModel
{
	public $archivo;
	public $verificador;

	/**
	 * Declares the validation rules.
	 */
	public function rules()
	{
		return array(
			// name, email, subject and body are required
			//array('archivo', 'required'),
			array('archivo', 'required'),
			// email has to be a valid email address
			//array('email', 'email'),
			// verifyCode needs to be entered correctly
			array('verificador', 'captcha', 'allowEmpty'=>!CCaptcha::checkRequirements()),
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
			'archivo'=>'Archivo',
			'verificador'=>'Captcha',
		);
	}
}