<?php

/**
 * This is the model class for table "pdi.totalflujocajas".
 *
 * The followings are the available columns in table 'pdi.totalflujocajas':
 * @property integer $id
 * @property integer $proyecto_id
 * @property double $valor_neto
 * @property double $costo_beneficio
 * @property double $tasa_retorno
 * @property string $fecha_registro
 * @property string $estatus
 * @property integer $anos
 * @property integer $periodo_id
 *
 * The followings are the available model relations:
 * @property Proyectos $proyecto
 * @property Periodos $periodo
 */
class Totalflujocajas extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'pdi.totalflujocajas';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('proyecto_id, valor_neto, costo_beneficio, tasa_retorno, fecha_registro, anos, periodo_id', 'required'),
			array('proyecto_id, anos, periodo_id', 'numerical', 'integerOnly'=>true),
			array('valor_neto, costo_beneficio, tasa_retorno', 'numerical'),
			array('estatus', 'length', 'max'=>1),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, proyecto_id, valor_neto, costo_beneficio, tasa_retorno, fecha_registro, estatus, anos, periodo_id', 'safe', 'on'=>'search'),
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
			'periodo' => array(self::BELONGS_TO, 'Periodos', 'periodo_id'),
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
			'valor_neto' => 'Valor Neto',
			'costo_beneficio' => 'Costo Beneficio',
			'tasa_retorno' => 'Tasa Retorno',
			'fecha_registro' => 'Fecha Registro',
			'estatus' => 'Estatus',
			'anos' => 'Cantidad de Años',
			'periodo_id' => 'Tipo de Periodo',
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
		$criteria->compare('valor_neto',$this->valor_neto);
		$criteria->compare('costo_beneficio',$this->costo_beneficio);
		$criteria->compare('tasa_retorno',$this->tasa_retorno);
		$criteria->compare('fecha_registro',$this->fecha_registro,true);
		$criteria->compare('estatus',$this->estatus,true);
		$criteria->compare('anos',$this->anos);
		$criteria->compare('periodo_id',$this->periodo_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Totalflujocajas the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
