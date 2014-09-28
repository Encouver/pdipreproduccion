<?php

/**
 * This is the model class for table "gen_pais".
 *
 * The followings are the available columns in table 'gen_pais':
 * @property string $cpais
 * @property string $dpais
 * @property string $sesion_id
 * @property string $ddocumento_identificacion
 * @property string $cdivisa_aceptada
 * @property string $bfiltroliq
 */
class GenPais extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'gen_pais';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('dpais, cdivisa_aceptada', 'required'),
			array('cpais', 'length', 'max'=>6),
			array('dpais, sesion_id, ddocumento_identificacion', 'length', 'max'=>30),
			array('cdivisa_aceptada', 'length', 'max'=>100),
			array('bfiltroliq', 'length', 'max'=>1),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('cpais, dpais, sesion_id, ddocumento_identificacion, cdivisa_aceptada, bfiltroliq', 'safe', 'on'=>'search'),
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
			'cpais' => 'Cpais',
			'dpais' => 'Dpais',
			'sesion_id' => 'Sesion',
			'ddocumento_identificacion' => 'Ddocumento Identificacion',
			'cdivisa_aceptada' => 'Cdivisa Aceptada',
			'bfiltroliq' => 'Bfiltroliq',
		);
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

		$criteria->compare('cpais',$this->cpais,true);
		$criteria->compare('dpais',$this->dpais,true);
		$criteria->compare('sesion_id',$this->sesion_id,true);
		$criteria->compare('ddocumento_identificacion',$this->ddocumento_identificacion,true);
		$criteria->compare('cdivisa_aceptada',$this->cdivisa_aceptada,true);
		$criteria->compare('bfiltroliq',$this->bfiltroliq,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return GenPais the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
