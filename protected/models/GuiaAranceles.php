<?php

/**
 * This is the model class for table "GEN_GUIA_ARANCELES".
 *
 * The followings are the available columns in table 'GEN_GUIA_ARANCELES':
 * @property integer $CID
 * @property string $CARANCEL
 * @property string $DARANCEL
 * @property integer $BACTIVO
 * @property string $FREGISTRO
 * @property string $CUSUARIO
 * @property double $SPKSECTORES
 * @property double $SPKSECTORES2
 * @property double $SPKSUBSECTORES
 * @property integer $NGRUPOSECTOR
 * @property integer $NSOLVENCIARUBROS
 */
class GuiaAranceles extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'GEN_GUIA_ARANCELES';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array("CID, CARANCEL, DARANCEL, BACTIVO, FREGISTRO, CUSUARIO, SPKSECTORES, NGRUPOSECTOR, NSOLVENCIARUBROS", 'required'),
			array('CID, BACTIVO, NGRUPOSECTOR, NSOLVENCIARUBROS', 'numerical', 'integerOnly'=>true),
			array('SPKSECTORES, SPKSECTORES2, SPKSUBSECTORES', 'numerical'),
			array('CARANCEL', 'length', 'max'=>15),
			array('DARANCEL', 'length', 'max'=>1000),
			array('CUSUARIO', 'length', 'max'=>50),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('CID, CARANCEL, DARANCEL, BACTIVO, FREGISTRO, CUSUARIO, SPKSECTORES, SPKSECTORES2, SPKSUBSECTORES, NGRUPOSECTOR, NSOLVENCIARUBROS', 'safe', 'on'=>'search'),
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
			'CID' => 'Cid',
			'CARANCEL' => 'Carancel',
			'DARANCEL' => 'Darancel',
			'BACTIVO' => 'Bactivo',
			'FREGISTRO' => 'Fregistro',
			'CUSUARIO' => 'Cusuario',
			'SPKSECTORES' => 'Spksectores',
			'SPKSECTORES2' => 'Spksectores2',
			'SPKSUBSECTORES' => 'Spksubsectores',
			'NGRUPOSECTOR' => 'Ngruposector',
			'NSOLVENCIARUBROS' => 'Nsolvenciarubros',
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

		$criteria->compare("CID",$this->CID);
		$criteria->compare("CARANCEL",$this->CARANCEL,true);
		$criteria->compare("DARANCEL",$this->DARANCEL,true);
		$criteria->compare("BACTIVO",$this->BACTIVO);
		$criteria->compare("FREGISTRO",$this->FREGISTRO,true);
		$criteria->compare("CUSUARIO",$this->CUSUARIO,true);
		$criteria->compare("SPKSECTORES",$this->SPKSECTORES);
		$criteria->compare("SPKSECTORES2",$this->SPKSECTORES2);
		$criteria->compare("SPKSUBSECTORES",$this->SPKSUBSECTORES);
		$criteria->compare("NGRUPOSECTOR",$this->NGRUPOSECTOR);
		$criteria->compare("NSOLVENCIARUBROS",$this->NSOLVENCIARUBROS);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return GuiaAranceles the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
