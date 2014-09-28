<?php

/**
 * This is the model class for table "pdi.cronogramas".
 *
 * The followings are the available columns in table 'pdi.cronogramas':
 * @property string $insumo
 * @property integer $cod_arancelario
 * @property integer $unidad_id
 * @property integer $cantidad
 * @property double $costo_total
 * @property string $fecha_estimada
 * @property integer $pais_destino
 * @property string $fecha_registro
 * @property string $valido
 * @property integer $proyecto_id
 * @property string $tipo
 * @property integer $id
 *
 * The followings are the available model relations:
 * @property ExportacionesPaises[] $exportacionesPaises
 */
class Cronogramas extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'pdi.cronogramas';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('cod_arancelario, unidad_id, cantidad, proyecto_id', 'numerical', 'integerOnly'=>true),
			array('costo_total', 'numerical'),
			array('insumo', 'length', 'max'=>30),
			array('valido', 'length', 'max'=>1),
			array('tipo', 'length', 'max'=>100),
			array('fecha_estimada, fecha_registro', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('insumo, cod_arancelario, unidad_id, cantidad, costo_total, fecha_estimada, pais_destino, fecha_registro, valido, proyecto_id, tipo, id', 'safe', 'on'=>'search'),
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
			'id' => 'ID',
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
		$criteria->compare('id',$this->id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Cronogramas the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
