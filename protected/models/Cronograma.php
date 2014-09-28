<?php

/**
 * This is the model class for table "pdi.cronograma".
 *
 * The followings are the available columns in table 'pdi.cronograma':
 * @property integer $id
 * @property string $insumo
 * @property integer $cod_arancelario
 * @property integer $unidad_id
 * @property double $cantidad
 * @property integer $costo_total
 * @property string $fecha_estimada
 * @property string $fecha_registro
 * @property string $valido
 * @property integer $proyecto_id
 * @property string $tipo
 *
 * The followings are the available model relations:
 * @property ExportacionesPaises[] $exportacionesPaises
 */
class Cronograma extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'pdi.cronograma';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id', 'required'),
			array('id, cod_arancelario, unidad_id, costo_total, proyecto_id', 'numerical', 'integerOnly'=>true),
			array('cantidad', 'numerical'),
			array('insumo', 'length', 'max'=>30),
			array('valido', 'length', 'max'=>1),
			array('tipo', 'length', 'max'=>100),
			array('fecha_estimada, fecha_registro', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, insumo, cod_arancelario, unidad_id, cantidad, costo_total, fecha_estimada, fecha_registro, valido, proyecto_id, tipo', 'safe', 'on'=>'search'),
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
			'exportacionesPaises' => array(self::HAS_MANY, 'ExportacionesPaises', 'cronograma_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'insumo' => 'Insumo',
			'cod_arancelario' => 'Cod Arancelario',
			'unidad_id' => 'Unidad',
			'cantidad' => 'Cantidad',
			'costo_total' => 'Costo Total',
			'fecha_estimada' => 'Fecha Estimada',
			'fecha_registro' => 'Fecha Registro',
			'valido' => 'Valido',
			'proyecto_id' => 'Proyecto',
			'tipo' => 'Tipo',
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
		$criteria->compare('insumo',$this->insumo,true);
		$criteria->compare('cod_arancelario',$this->cod_arancelario);
		$criteria->compare('unidad_id',$this->unidad_id);
		$criteria->compare('cantidad',$this->cantidad);
		$criteria->compare('costo_total',$this->costo_total);
		$criteria->compare('fecha_estimada',$this->fecha_estimada,true);
		$criteria->compare('fecha_registro',$this->fecha_registro,true);
		$criteria->compare('valido',$this->valido,true);
		$criteria->compare('proyecto_id',$this->proyecto_id);
		$criteria->compare('tipo',$this->tipo,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Cronograma the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
