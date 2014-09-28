<?php

/**
 * This is the model class for table "pdi.exportaciones_paises".
 *
 * The followings are the available columns in table 'pdi.exportaciones_paises':
 * @property integer $id
 * @property string $cpais
 * @property integer $cronograma_id
 *
 * The followings are the available model relations:
 * @property Cronograma $cronograma
 */
class ExportacionesPaises extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'pdi.exportaciones_paises';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('cronograma_id', 'numerical', 'integerOnly'=>true),
			array('cpais', 'length', 'max'=>6),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, cpais, cronograma_id', 'safe', 'on'=>'search'),
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
			'cronograma' => array(self::BELONGS_TO, 'Cronograma', 'cronograma_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'cpais' => 'Cpais',
			'cronograma_id' => 'Cronograma',
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
		$criteria->compare('cpais',$this->cpais,true);
		$criteria->compare('cronograma_id',$this->cronograma_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return ExportacionesPaises the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
