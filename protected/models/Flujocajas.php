<?php

/**
 * This is the model class for table "pdi.flujocajas".
 *
 * The followings are the available columns in table 'pdi.flujocajas':
 * @property integer $id
 * @property double $inversion
 * @property double $prestamo
 * @property double $ingresos
 * @property double $costos
 * @property double $reinversion
 * @property double $valor_residual
 * @property double $pagos
 * @property double $depreciacion_negativo
 * @property double $utilidad_antesimp
 * @property double $utilidad_despuesimp
 * @property double $impuestos
 * @property double $depreciacion_positivo
 * @property double $flujo_operativo
 * @property double $flujo_proyectado
 * @property double $ingresos_rcb
 * @property double $costos_rcb
 * @property double $ingresos_rcbact
 * @property double $costos_rcbact
 * @property string $fecha_registro
 * @property string $estatus
 * @property integer $proyecto_id
 *
 * The followings are the available model relations:
 * @property Proyectos $proyecto
 */
class Flujocajas extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'pdi.flujocajas';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('inversion, prestamo, ingresos, costos, reinversion, valor_residual, pagos, depreciacion_negativo, utilidad_antesimp, utilidad_despuesimp, impuestos, depreciacion_positivo, flujo_operativo, flujo_proyectado, ingresos_rcb, costos_rcb, ingresos_rcbact, costos_rcbact, fecha_registro, proyecto_id', 'required'),
			array('proyecto_id', 'numerical', 'integerOnly'=>true),
			array('inversion, prestamo, ingresos, costos, reinversion, valor_residual, pagos, depreciacion_negativo, utilidad_antesimp, utilidad_despuesimp, impuestos, depreciacion_positivo, flujo_operativo, flujo_proyectado, ingresos_rcb, costos_rcb, ingresos_rcbact, costos_rcbact', 'numerical'),
			array('estatus', 'length', 'max'=>1),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, inversion, prestamo, ingresos, costos, reinversion, valor_residual, pagos, depreciacion_negativo, utilidad_antesimp, utilidad_despuesimp, impuestos, depreciacion_positivo, flujo_operativo, flujo_proyectado, ingresos_rcb, costos_rcb, ingresos_rcbact, costos_rcbact, fecha_registro, estatus, proyecto_id', 'safe', 'on'=>'search'),
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
			'inversion' => 'Inversion',
			'prestamo' => 'Prestamo',
			'ingresos' => 'Ingresos',
			'costos' => 'Costos',
			'reinversion' => 'Reinversion',
			'valor_residual' => 'Valor Residual',
			'pagos' => 'Pagos',
			'depreciacion_negativo' => 'Depreciacion Negativo',
			'utilidad_antesimp' => 'Utilidad Antesimp',
			'utilidad_despuesimp' => 'Utilidad Despuesimp',
			'impuestos' => 'Impuestos',
			'depreciacion_positivo' => 'Depreciacion Positivo',
			'flujo_operativo' => 'Flujo Operativo',
			'flujo_proyectado' => 'Flujo Proyectado',
			'ingresos_rcb' => 'Ingresos Rcb',
			'costos_rcb' => 'Costos Rcb',
			'ingresos_rcbact' => 'Ingresos Rcbact',
			'costos_rcbact' => 'Costos Rcbact',
			'fecha_registro' => 'Fecha Registro',
			'estatus' => 'Estatus',
			'proyecto_id' => 'Proyecto',
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
		$criteria->compare('inversion',$this->inversion);
		$criteria->compare('prestamo',$this->prestamo);
		$criteria->compare('ingresos',$this->ingresos);
		$criteria->compare('costos',$this->costos);
		$criteria->compare('reinversion',$this->reinversion);
		$criteria->compare('valor_residual',$this->valor_residual);
		$criteria->compare('pagos',$this->pagos);
		$criteria->compare('depreciacion_negativo',$this->depreciacion_negativo);
		$criteria->compare('utilidad_antesimp',$this->utilidad_antesimp);
		$criteria->compare('utilidad_despuesimp',$this->utilidad_despuesimp);
		$criteria->compare('impuestos',$this->impuestos);
		$criteria->compare('depreciacion_positivo',$this->depreciacion_positivo);
		$criteria->compare('flujo_operativo',$this->flujo_operativo);
		$criteria->compare('flujo_proyectado',$this->flujo_proyectado);
		$criteria->compare('ingresos_rcb',$this->ingresos_rcb);
		$criteria->compare('costos_rcb',$this->costos_rcb);
		$criteria->compare('ingresos_rcbact',$this->ingresos_rcbact);
		$criteria->compare('costos_rcbact',$this->costos_rcbact);
		$criteria->compare('fecha_registro',$this->fecha_registro,true);
		$criteria->compare('estatus',$this->estatus,true);
		$criteria->compare('proyecto_id',$this->proyecto_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Flujocajas the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
