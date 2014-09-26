<?php

/**
 * This is the model class for table "GEN_USUARIOS".
 *
 * The followings are the available columns in table 'GEN_USUARIOS':
 * @property string $CUSUARIO
 * @property string $CPASSWORD
 * @property string $CAGENCIA
 * @property string $COPERADOR_CAMB
 * @property string $DTIPO_PERSONA
 * @property string $CADUANA
 * @property string $DPREGUNTA
 * @property string $DRESPUESTA
 * @property string $FCREACION
 * @property string $SESION_ID
 */
class GenUsuarios extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'GEN_USUARIOS';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('CUSUARIO, CPASSWORD', 'required'),
			array('CUSUARIO', 'length', 'max'=>50),
			array('CPASSWORD', 'length', 'max'=>32),
			array('CAGENCIA, CADUANA', 'length', 'max'=>5),
			array('COPERADOR_CAMB', 'length', 'max'=>3),
			array('DTIPO_PERSONA', 'length', 'max'=>1),
			array('DPREGUNTA, DRESPUESTA', 'length', 'max'=>70),
			array('SESION_ID', 'length', 'max'=>30),
			array('FCREACION', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('CUSUARIO, CPASSWORD, CAGENCIA, COPERADOR_CAMB, DTIPO_PERSONA, CADUANA, DPREGUNTA, DRESPUESTA, FCREACION, SESION_ID', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'CUSUARIO' => 'Cusuario',
			'CPASSWORD' => 'Cpassword',
			'CAGENCIA' => 'Cagencia',
			'COPERADOR_CAMB' => 'Coperador Camb',
			'DTIPO_PERSONA' => 'Dtipo Persona',
			'CADUANA' => 'Caduana',
			'DPREGUNTA' => 'Dpregunta',
			'DRESPUESTA' => 'Drespuesta',
			'FCREACION' => 'Fcreacion',
			'SESION_ID' => 'Sesion',
		);
	}
	
	public function validatePassword($password)
	 {
	 return $this->hashPassword($password)===$this->CPASSWORD;
	 }
	public function hashPassword($password){
		return md5($password);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('CUSUARIO',$this->CUSUARIO,true);
		$criteria->compare('CPASSWORD',$this->CPASSWORD,true);
		$criteria->compare('CAGENCIA',$this->CAGENCIA,true);
		$criteria->compare('COPERADOR_CAMB',$this->COPERADOR_CAMB,true);
		$criteria->compare('DTIPO_PERSONA',$this->DTIPO_PERSONA,true);
		$criteria->compare('CADUANA',$this->CADUANA,true);
		$criteria->compare('DPREGUNTA',$this->DPREGUNTA,true);
		$criteria->compare('DRESPUESTA',$this->DRESPUESTA,true);
		$criteria->compare('FCREACION',$this->FCREACION,true);
		$criteria->compare('SESION_ID',$this->SESION_ID,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return GenUsuarios the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
