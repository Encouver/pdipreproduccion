<?php

/**
 * This is the model class for table "pdi.datosbasicos".
 *
 * The followings are the available columns in table 'pdi.datosbasicos':
 * @property integer $id
 * @property string $empresa_id
 * @property string $num_declaracion
 * @property string $fecha_islr
 * @property double $monto_islr
 * @property integer $num_empleados
 * @property string $numero_declaracionivss
 * @property string $fecha_ivss
 * @property string $valido
 */
class Datosbasicos extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'pdi.datosbasicos';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('empresa_id, num_declaracion, fecha_islr, monto_islr, num_empleados, numero_declaracionivss, fecha_ivss', 'required'),
			array('num_empleados', 'numerical', 'integerOnly'=>true),
			array('monto_islr', 'numerical'),
			array('num_declaracion, numero_declaracionivss', 'length', 'max'=>10),
			array('valido', 'length', 'max'=>1),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, empresa_id, num_declaracion, fecha_islr, monto_islr, num_empleados, numero_declaracionivss, fecha_ivss, valido', 'safe', 'on'=>'search'),
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
			'id' => 'ID',
			'empresa_id' => 'Empresa',
			'num_declaracion' => 'Num Declaracion',
			'fecha_islr' => 'Fecha Islr',
			'monto_islr' => 'Monto Islr',
			'num_empleados' => 'Num Empleados',
			'numero_declaracionivss' => 'Numero Declaracionivss',
			'fecha_ivss' => 'Fecha Ivss',
			'valido' => 'Valido',
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

		$criteria->compare('id',$this->id);
		$criteria->compare('empresa_id',$this->empresa_id,true);
		$criteria->compare('num_declaracion',$this->num_declaracion,true);
		$criteria->compare('fecha_islr',$this->fecha_islr,true);
		$criteria->compare('monto_islr',$this->monto_islr);
		$criteria->compare('num_empleados',$this->num_empleados);
		$criteria->compare('numero_declaracionivss',$this->numero_declaracionivss,true);
		$criteria->compare('fecha_ivss',$this->fecha_ivss,true);
		$criteria->compare('valido',$this->valido,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * @return CDbConnection the database connection used for this class
	 */
	public function getDbConnection()
	{
		return Yii::app()->db2;
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Datosbasicos the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
