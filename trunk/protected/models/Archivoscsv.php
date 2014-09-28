<?php

/**
 * This is the model class for table "pdi.archivoscsv".
 *
 * The followings are the available columns in table 'pdi.archivoscsv':
 * @property integer $id
 * @property integer $proyecto_id
 * @property string $archivo
 * @property integer $tipo_csv
 * @property string $fecha
 *
 * The followings are the available model relations:
 * @property Proyectos $proyecto
 */
class Archivoscsv extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'pdi.archivoscsv';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('proyecto_id, archivo, tipo_csv', 'required'),
			array('proyecto_id, tipo_csv', 'numerical', 'integerOnly'=>true),
			array('archivo', 'length', 'max'=>255),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, proyecto_id, archivo, tipo_csv, fecha', 'safe', 'on'=>'search'),
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
			'proyecto' => array(self::BELONGS_TO, 'Proyectos', 'proyecto_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'proyecto_id' => 'Proyecto',
			'archivo' => 'Archivo',
			'tipo_csv' => 'Tipo Csv',
			'fecha' => 'Fecha',
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
		$criteria->compare('proyecto_id',$this->proyecto_id);
		$criteria->compare('archivo',$this->archivo,true);
		$criteria->compare('tipo_csv',$this->tipo_csv);
		$criteria->compare('fecha',$this->fecha,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Archivoscsv the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
