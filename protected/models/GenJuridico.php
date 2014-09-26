<?php

/**
 * This is the model class for table "GEN_JURIDICO".
 *
 * The followings are the available columns in table 'GEN_JURIDICO':
 * @property integer $BACTUALIX
 * @property string $CRIF
 * @property string $DNOMBRE
 * @property string $DSIGLAS
 * @property string $DDIRECCION
 * @property string $CPAIS
 * @property string $DESTADO
 * @property string $DMUNICIPIO
 * @property string $CTELEFONO
 * @property string $CFAX
 * @property string $CCELULAR
 * @property string $CMAIL_PRIM
 * @property string $CMAIL_SEC
 * @property string $CACTIVIDAD_ECO
 * @property double $MCAPITAL_SUS
 * @property double $MCAPITAL_PAG
 * @property double $MPORCENTAJE_NAC
 * @property double $MPORCENTAJE_EXT
 * @property double $MPROM_ANUAL1
 * @property double $MPROM_ANUAL2
 * @property double $MPROM_ANUAL3
 * @property string $CCEDULA_REP
 * @property string $DCARGO_REP
 * @property string $FREGISTRO_MER
 * @property string $CTOMO_MER
 * @property string $CFOLIO_MER
 * @property string $CREGISTRO_CIR
 * @property string $CREGISTRO_AVI
 * @property string $FREG_AVI
 * @property string $DGAC_OFIC
 * @property string $FINSCRIPCION
 * @property string $DCIUDAD
 * @property string $CRUSAD
 * @property string $DCOD_POSTAL
 * @property double $MPROM_ANUAL_EXP1
 * @property double $MPROM_ANUAL_EXP2
 * @property double $MPROM_ANUAL_EXP3
 * @property string $DPATRONAL
 * @property string $DPROTOCOLO
 * @property string $DREG_CIRC_JUD
 * @property string $CACTIVIDAD_ECO_SEC
 * @property string $CACTIVIDAD_ECO_AUX
 * @property string $CTIPO_EMPRESA
 * @property string $BPASAJERO
 * @property string $BCARGA
 * @property string $BCORREO
 * @property string $DDISTRITO
 * @property string $DDOMICILIO
 * @property string $BPRIMARIA
 * @property string $BSERVICIO
 * @property string $BCOMERCIO
 * @property string $BMANUFACTURA
 * @property string $DEMPRESA_MATRIZ
 * @property string $DNOMBRE_BANCO
 * @property string $DCUENTA_BANCO
 * @property string $DDIR_AGENCIA
 * @property string $NREGISTRO_MER
 * @property string $DREG_INV_EXT
 * @property string $DCALIFICACION
 * @property string $DORGANISMO
 * @property string $DSUDESEG
 * @property string $DCOMERCIAL
 * @property string $DNUM_RES_INST_AVIACION
 * @property string $FINST_AVIACION
 * @property string $DGACETA_INST_AVIACION
 * @property string $BVERIFICADORA
 * @property string $SESION_ID
 * @property string $FIPRODUCTIVIDAD
 * @property string $DEFINANCIERO1
 * @property string $DEFINANCIERO2
 * @property string $DEFINANCIERO3
 * @property string $DINSCRITA
 * @property string $CINCE
 * @property string $CBANAVIH
 * @property string $CNIL
 * @property string $CLICMNPAL
 * @property string $CMAILSITIOELECT
 * @property string $FCIERREEJERECON
 * @property string $CCIUU
 * @property string $CSECTORECON
 * @property string $CPROCAPEXT
 * @property string $CTOTALCANTACCIONES
 * @property integer $SPERSONA
 * @property string $CTELEFONO2
 * @property string $CTELEFONO3
 * @property string $BACTUALIZADO
 * @property double $SEMPRESA
 * @property string $CPARROQUIA
 * @property string $DCALLE_AV
 * @property string $DESQUINA
 * @property string $DVEREDA
 * @property string $DURB_BARR
 * @property string $DEDIF_CC
 * @property string $DPISO
 * @property string $DOFICINA
 * @property string $CDOC_RL
 * @property string $CREGISTRONOTARIA_RL
 * @property string $CTOMODOC_RL
 * @property string $CPROTOCOLO_RL
 * @property string $FDOC_RL
 * @property string $DDECLARAC_IVA1
 * @property string $DDECLARAC_IVA2
 * @property string $DDECLARAC_IVA3
 * @property string $CTIPO_CONTRIBUYENTE
 * @property string $DZONA_SECTOR
 * @property string $DPARCELA
 * @property string $BSEDES_SUCUR
 * @property double $CTIPO_REG
 * @property string $DDISTRITOAC
 * @property string $DDISTRITORL
 * @property double $CTIPO_PERS_JUR
 * @property double $COFIC_REG_NOT
 * @property string $DCONJ_CENTRO
 * @property double $COFIC_REG_NOT_RL
 * @property double $CTIPO_REG_RL
 * @property string $DDECLARAC_ISLR1
 * @property string $DDECLARAC_ISLR2
 * @property string $DDECLARAC_ISLR3
 * @property string $BBORRADO
 * @property string $FBORRADO
 * @property string $BEXENTO
 * @property integer $SPKSECTOR
 */
class GenJuridico extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'GEN_JURIDICO';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('BACTUALIX, SEMPRESA, DDECLARAC_ISLR1, DDECLARAC_ISLR2, DDECLARAC_ISLR3, BBORRADO, FBORRADO, BEXENTO', 'required'),
			array('BACTUALIX, SPERSONA, SPKSECTOR', 'numerical', 'integerOnly'=>true),
			array('MCAPITAL_SUS, MCAPITAL_PAG, MPORCENTAJE_NAC, MPORCENTAJE_EXT, MPROM_ANUAL1, MPROM_ANUAL2, MPROM_ANUAL3, MPROM_ANUAL_EXP1, MPROM_ANUAL_EXP2, MPROM_ANUAL_EXP3, SEMPRESA, CTIPO_REG, CTIPO_PERS_JUR, COFIC_REG_NOT, COFIC_REG_NOT_RL, CTIPO_REG_RL', 'numerical'),
			array('CRIF, DSUDESEG', 'length', 'max'=>15),
			array('DNOMBRE, DDIRECCION, CREGISTRO_CIR, CREGISTRONOTARIA_RL', 'length', 'max'=>250),
			array('DSIGLAS, CTOMO_MER, CFOLIO_MER, DCOD_POSTAL, DCALIFICACION, CTOTALCANTACCIONES, CDOC_RL, CTOMODOC_RL, CPROTOCOLO_RL', 'length', 'max'=>10),
			array('CPAIS', 'length', 'max'=>6),
			array('DESTADO, DMUNICIPIO, CMAIL_PRIM, CMAIL_SEC, DREG_CIRC_JUD, DDISTRITO, CMAILSITIOELECT, DESQUINA, DVEREDA, DDISTRITOAC, DDISTRITORL', 'length', 'max'=>50),
			array('CTELEFONO, CFAX, CCELULAR, CREGISTRO_AVI, DGAC_OFIC, CRUSAD, DPATRONAL, DPROTOCOLO, DCUENTA_BANCO, DREG_INV_EXT, DNUM_RES_INST_AVIACION, DGACETA_INST_AVIACION, DINSCRITA, CBANAVIH, CNIL, CCIUU, CSECTORECON, CPROCAPEXT, CTELEFONO2, CTELEFONO3', 'length', 'max'=>20),
			array('CACTIVIDAD_ECO, CACTIVIDAD_ECO_SEC, CACTIVIDAD_ECO_AUX, CTIPO_EMPRESA, DEFINANCIERO1, DEFINANCIERO2, DEFINANCIERO3', 'length', 'max'=>4),
			array('CCEDULA_REP, CINCE', 'length', 'max'=>12),
			array('DCARGO_REP', 'length', 'max'=>150),
			array('DCIUDAD, DCOMERCIAL, SESION_ID', 'length', 'max'=>30),
			array('BPASAJERO, BCARGA, BCORREO, BPRIMARIA, BSERVICIO, BCOMERCIO, BMANUFACTURA, BVERIFICADORA, BACTUALIZADO, BBORRADO, BEXENTO', 'length', 'max'=>1),
			array('DDOMICILIO, DEMPRESA_MATRIZ, DNOMBRE_BANCO, DORGANISMO, DCALLE_AV, DURB_BARR, DEDIF_CC, DOFICINA', 'length', 'max'=>70),
			array('DDIR_AGENCIA, DZONA_SECTOR, DPARCELA, DCONJ_CENTRO', 'length', 'max'=>100),
			array('NREGISTRO_MER', 'length', 'max'=>9),
			array('CLICMNPAL, DDECLARAC_IVA1, DDECLARAC_IVA2, DDECLARAC_IVA3, DDECLARAC_ISLR1, DDECLARAC_ISLR2, DDECLARAC_ISLR3', 'length', 'max'=>25),
			array('CPARROQUIA, DPISO, BSEDES_SUCUR', 'length', 'max'=>5),
			array('CTIPO_CONTRIBUYENTE', 'length', 'max'=>3),
			array('FREGISTRO_MER, FREG_AVI, FINSCRIPCION, FINST_AVIACION, FIPRODUCTIVIDAD, FCIERREEJERECON, FDOC_RL', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('BACTUALIX, CRIF, DNOMBRE, DSIGLAS, DDIRECCION, CPAIS, DESTADO, DMUNICIPIO, CTELEFONO, CFAX, CCELULAR, CMAIL_PRIM, CMAIL_SEC, CACTIVIDAD_ECO, MCAPITAL_SUS, MCAPITAL_PAG, MPORCENTAJE_NAC, MPORCENTAJE_EXT, MPROM_ANUAL1, MPROM_ANUAL2, MPROM_ANUAL3, CCEDULA_REP, DCARGO_REP, FREGISTRO_MER, CTOMO_MER, CFOLIO_MER, CREGISTRO_CIR, CREGISTRO_AVI, FREG_AVI, DGAC_OFIC, FINSCRIPCION, DCIUDAD, CRUSAD, DCOD_POSTAL, MPROM_ANUAL_EXP1, MPROM_ANUAL_EXP2, MPROM_ANUAL_EXP3, DPATRONAL, DPROTOCOLO, DREG_CIRC_JUD, CACTIVIDAD_ECO_SEC, CACTIVIDAD_ECO_AUX, CTIPO_EMPRESA, BPASAJERO, BCARGA, BCORREO, DDISTRITO, DDOMICILIO, BPRIMARIA, BSERVICIO, BCOMERCIO, BMANUFACTURA, DEMPRESA_MATRIZ, DNOMBRE_BANCO, DCUENTA_BANCO, DDIR_AGENCIA, NREGISTRO_MER, DREG_INV_EXT, DCALIFICACION, DORGANISMO, DSUDESEG, DCOMERCIAL, DNUM_RES_INST_AVIACION, FINST_AVIACION, DGACETA_INST_AVIACION, BVERIFICADORA, SESION_ID, FIPRODUCTIVIDAD, DEFINANCIERO1, DEFINANCIERO2, DEFINANCIERO3, DINSCRITA, CINCE, CBANAVIH, CNIL, CLICMNPAL, CMAILSITIOELECT, FCIERREEJERECON, CCIUU, CSECTORECON, CPROCAPEXT, CTOTALCANTACCIONES, SPERSONA, CTELEFONO2, CTELEFONO3, BACTUALIZADO, SEMPRESA, CPARROQUIA, DCALLE_AV, DESQUINA, DVEREDA, DURB_BARR, DEDIF_CC, DPISO, DOFICINA, CDOC_RL, CREGISTRONOTARIA_RL, CTOMODOC_RL, CPROTOCOLO_RL, FDOC_RL, DDECLARAC_IVA1, DDECLARAC_IVA2, DDECLARAC_IVA3, CTIPO_CONTRIBUYENTE, DZONA_SECTOR, DPARCELA, BSEDES_SUCUR, CTIPO_REG, DDISTRITOAC, DDISTRITORL, CTIPO_PERS_JUR, COFIC_REG_NOT, DCONJ_CENTRO, COFIC_REG_NOT_RL, CTIPO_REG_RL, DDECLARAC_ISLR1, DDECLARAC_ISLR2, DDECLARAC_ISLR3, BBORRADO, FBORRADO, BEXENTO, SPKSECTOR', 'safe', 'on'=>'search'),
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
			'BACTUALIX' => 'Bactualix',
			'CRIF' => 'Crif',
			'DNOMBRE' => 'Dnombre',
			'DSIGLAS' => 'Dsiglas',
			'DDIRECCION' => 'Ddireccion',
			'CPAIS' => 'Cpais',
			'DESTADO' => 'Destado',
			'DMUNICIPIO' => 'Dmunicipio',
			'CTELEFONO' => 'Ctelefono',
			'CFAX' => 'Cfax',
			'CCELULAR' => 'Ccelular',
			'CMAIL_PRIM' => 'Cmail Prim',
			'CMAIL_SEC' => 'Cmail Sec',
			'CACTIVIDAD_ECO' => 'Cactividad Eco',
			'MCAPITAL_SUS' => 'Mcapital Sus',
			'MCAPITAL_PAG' => 'Mcapital Pag',
			'MPORCENTAJE_NAC' => 'Mporcentaje Nac',
			'MPORCENTAJE_EXT' => 'Mporcentaje Ext',
			'MPROM_ANUAL1' => 'Mprom Anual1',
			'MPROM_ANUAL2' => 'Mprom Anual2',
			'MPROM_ANUAL3' => 'Mprom Anual3',
			'CCEDULA_REP' => 'Ccedula Rep',
			'DCARGO_REP' => 'Dcargo Rep',
			'FREGISTRO_MER' => 'Fregistro Mer',
			'CTOMO_MER' => 'Ctomo Mer',
			'CFOLIO_MER' => 'Cfolio Mer',
			'CREGISTRO_CIR' => 'Cregistro Cir',
			'CREGISTRO_AVI' => 'Cregistro Avi',
			'FREG_AVI' => 'Freg Avi',
			'DGAC_OFIC' => 'Dgac Ofic',
			'FINSCRIPCION' => 'Finscripcion',
			'DCIUDAD' => 'Dciudad',
			'CRUSAD' => 'Crusad',
			'DCOD_POSTAL' => 'Dcod Postal',
			'MPROM_ANUAL_EXP1' => 'Mprom Anual Exp1',
			'MPROM_ANUAL_EXP2' => 'Mprom Anual Exp2',
			'MPROM_ANUAL_EXP3' => 'Mprom Anual Exp3',
			'DPATRONAL' => 'Dpatronal',
			'DPROTOCOLO' => 'Dprotocolo',
			'DREG_CIRC_JUD' => 'Dreg Circ Jud',
			'CACTIVIDAD_ECO_SEC' => 'Cactividad Eco Sec',
			'CACTIVIDAD_ECO_AUX' => 'Cactividad Eco Aux',
			'CTIPO_EMPRESA' => 'Ctipo Empresa',
			'BPASAJERO' => 'Bpasajero',
			'BCARGA' => 'Bcarga',
			'BCORREO' => 'Bcorreo',
			'DDISTRITO' => 'Ddistrito',
			'DDOMICILIO' => 'Ddomicilio',
			'BPRIMARIA' => 'Bprimaria',
			'BSERVICIO' => 'Bservicio',
			'BCOMERCIO' => 'Bcomercio',
			'BMANUFACTURA' => 'Bmanufactura',
			'DEMPRESA_MATRIZ' => 'Dempresa Matriz',
			'DNOMBRE_BANCO' => 'Dnombre Banco',
			'DCUENTA_BANCO' => 'Dcuenta Banco',
			'DDIR_AGENCIA' => 'Ddir Agencia',
			'NREGISTRO_MER' => 'Nregistro Mer',
			'DREG_INV_EXT' => 'Dreg Inv Ext',
			'DCALIFICACION' => 'Dcalificacion',
			'DORGANISMO' => 'Dorganismo',
			'DSUDESEG' => 'Dsudeseg',
			'DCOMERCIAL' => 'Dcomercial',
			'DNUM_RES_INST_AVIACION' => 'Dnum Res Inst Aviacion',
			'FINST_AVIACION' => 'Finst Aviacion',
			'DGACETA_INST_AVIACION' => 'Dgaceta Inst Aviacion',
			'BVERIFICADORA' => 'Bverificadora',
			'SESION_ID' => 'Sesion',
			'FIPRODUCTIVIDAD' => 'Fiproductividad',
			'DEFINANCIERO1' => 'Definanciero1',
			'DEFINANCIERO2' => 'Definanciero2',
			'DEFINANCIERO3' => 'Definanciero3',
			'DINSCRITA' => 'Dinscrita',
			'CINCE' => 'Cince',
			'CBANAVIH' => 'Cbanavih',
			'CNIL' => 'Cnil',
			'CLICMNPAL' => 'Clicmnpal',
			'CMAILSITIOELECT' => 'Cmailsitioelect',
			'FCIERREEJERECON' => 'Fcierreejerecon',
			'CCIUU' => 'Cciuu',
			'CSECTORECON' => 'Csectorecon',
			'CPROCAPEXT' => 'Cprocapext',
			'CTOTALCANTACCIONES' => 'Ctotalcantacciones',
			'SPERSONA' => 'Spersona',
			'CTELEFONO2' => 'Ctelefono2',
			'CTELEFONO3' => 'Ctelefono3',
			'BACTUALIZADO' => 'Bactualizado',
			'SEMPRESA' => 'Sempresa',
			'CPARROQUIA' => 'Cparroquia',
			'DCALLE_AV' => 'Dcalle Av',
			'DESQUINA' => 'Desquina',
			'DVEREDA' => 'Dvereda',
			'DURB_BARR' => 'Durb Barr',
			'DEDIF_CC' => 'Dedif Cc',
			'DPISO' => 'Dpiso',
			'DOFICINA' => 'Doficina',
			'CDOC_RL' => 'Cdoc Rl',
			'CREGISTRONOTARIA_RL' => 'Cregistronotaria Rl',
			'CTOMODOC_RL' => 'Ctomodoc Rl',
			'CPROTOCOLO_RL' => 'Cprotocolo Rl',
			'FDOC_RL' => 'Fdoc Rl',
			'DDECLARAC_IVA1' => 'Ddeclarac Iva1',
			'DDECLARAC_IVA2' => 'Ddeclarac Iva2',
			'DDECLARAC_IVA3' => 'Ddeclarac Iva3',
			'CTIPO_CONTRIBUYENTE' => 'Ctipo Contribuyente',
			'DZONA_SECTOR' => 'Dzona Sector',
			'DPARCELA' => 'Dparcela',
			'BSEDES_SUCUR' => 'Bsedes Sucur',
			'CTIPO_REG' => 'Ctipo Reg',
			'DDISTRITOAC' => 'Ddistritoac',
			'DDISTRITORL' => 'Ddistritorl',
			'CTIPO_PERS_JUR' => 'Ctipo Pers Jur',
			'COFIC_REG_NOT' => 'Cofic Reg Not',
			'DCONJ_CENTRO' => 'Dconj Centro',
			'COFIC_REG_NOT_RL' => 'Cofic Reg Not Rl',
			'CTIPO_REG_RL' => 'Ctipo Reg Rl',
			'DDECLARAC_ISLR1' => 'Ddeclarac Islr1',
			'DDECLARAC_ISLR2' => 'Ddeclarac Islr2',
			'DDECLARAC_ISLR3' => 'Ddeclarac Islr3',
			'BBORRADO' => 'Bborrado',
			'FBORRADO' => 'Fborrado',
			'BEXENTO' => 'Bexento',
			'SPKSECTOR' => 'Spksector',
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

		$criteria->compare('BACTUALIX',$this->BACTUALIX);
		$criteria->compare('CRIF',$this->CRIF,true);
		$criteria->compare('DNOMBRE',$this->DNOMBRE,true);
		$criteria->compare('DSIGLAS',$this->DSIGLAS,true);
		$criteria->compare('DDIRECCION',$this->DDIRECCION,true);
		$criteria->compare('CPAIS',$this->CPAIS,true);
		$criteria->compare('DESTADO',$this->DESTADO,true);
		$criteria->compare('DMUNICIPIO',$this->DMUNICIPIO,true);
		$criteria->compare('CTELEFONO',$this->CTELEFONO,true);
		$criteria->compare('CFAX',$this->CFAX,true);
		$criteria->compare('CCELULAR',$this->CCELULAR,true);
		$criteria->compare('CMAIL_PRIM',$this->CMAIL_PRIM,true);
		$criteria->compare('CMAIL_SEC',$this->CMAIL_SEC,true);
		$criteria->compare('CACTIVIDAD_ECO',$this->CACTIVIDAD_ECO,true);
		$criteria->compare('MCAPITAL_SUS',$this->MCAPITAL_SUS);
		$criteria->compare('MCAPITAL_PAG',$this->MCAPITAL_PAG);
		$criteria->compare('MPORCENTAJE_NAC',$this->MPORCENTAJE_NAC);
		$criteria->compare('MPORCENTAJE_EXT',$this->MPORCENTAJE_EXT);
		$criteria->compare('MPROM_ANUAL1',$this->MPROM_ANUAL1);
		$criteria->compare('MPROM_ANUAL2',$this->MPROM_ANUAL2);
		$criteria->compare('MPROM_ANUAL3',$this->MPROM_ANUAL3);
		$criteria->compare('CCEDULA_REP',$this->CCEDULA_REP,true);
		$criteria->compare('DCARGO_REP',$this->DCARGO_REP,true);
		$criteria->compare('FREGISTRO_MER',$this->FREGISTRO_MER,true);
		$criteria->compare('CTOMO_MER',$this->CTOMO_MER,true);
		$criteria->compare('CFOLIO_MER',$this->CFOLIO_MER,true);
		$criteria->compare('CREGISTRO_CIR',$this->CREGISTRO_CIR,true);
		$criteria->compare('CREGISTRO_AVI',$this->CREGISTRO_AVI,true);
		$criteria->compare('FREG_AVI',$this->FREG_AVI,true);
		$criteria->compare('DGAC_OFIC',$this->DGAC_OFIC,true);
		$criteria->compare('FINSCRIPCION',$this->FINSCRIPCION,true);
		$criteria->compare('DCIUDAD',$this->DCIUDAD,true);
		$criteria->compare('CRUSAD',$this->CRUSAD,true);
		$criteria->compare('DCOD_POSTAL',$this->DCOD_POSTAL,true);
		$criteria->compare('MPROM_ANUAL_EXP1',$this->MPROM_ANUAL_EXP1);
		$criteria->compare('MPROM_ANUAL_EXP2',$this->MPROM_ANUAL_EXP2);
		$criteria->compare('MPROM_ANUAL_EXP3',$this->MPROM_ANUAL_EXP3);
		$criteria->compare('DPATRONAL',$this->DPATRONAL,true);
		$criteria->compare('DPROTOCOLO',$this->DPROTOCOLO,true);
		$criteria->compare('DREG_CIRC_JUD',$this->DREG_CIRC_JUD,true);
		$criteria->compare('CACTIVIDAD_ECO_SEC',$this->CACTIVIDAD_ECO_SEC,true);
		$criteria->compare('CACTIVIDAD_ECO_AUX',$this->CACTIVIDAD_ECO_AUX,true);
		$criteria->compare('CTIPO_EMPRESA',$this->CTIPO_EMPRESA,true);
		$criteria->compare('BPASAJERO',$this->BPASAJERO,true);
		$criteria->compare('BCARGA',$this->BCARGA,true);
		$criteria->compare('BCORREO',$this->BCORREO,true);
		$criteria->compare('DDISTRITO',$this->DDISTRITO,true);
		$criteria->compare('DDOMICILIO',$this->DDOMICILIO,true);
		$criteria->compare('BPRIMARIA',$this->BPRIMARIA,true);
		$criteria->compare('BSERVICIO',$this->BSERVICIO,true);
		$criteria->compare('BCOMERCIO',$this->BCOMERCIO,true);
		$criteria->compare('BMANUFACTURA',$this->BMANUFACTURA,true);
		$criteria->compare('DEMPRESA_MATRIZ',$this->DEMPRESA_MATRIZ,true);
		$criteria->compare('DNOMBRE_BANCO',$this->DNOMBRE_BANCO,true);
		$criteria->compare('DCUENTA_BANCO',$this->DCUENTA_BANCO,true);
		$criteria->compare('DDIR_AGENCIA',$this->DDIR_AGENCIA,true);
		$criteria->compare('NREGISTRO_MER',$this->NREGISTRO_MER,true);
		$criteria->compare('DREG_INV_EXT',$this->DREG_INV_EXT,true);
		$criteria->compare('DCALIFICACION',$this->DCALIFICACION,true);
		$criteria->compare('DORGANISMO',$this->DORGANISMO,true);
		$criteria->compare('DSUDESEG',$this->DSUDESEG,true);
		$criteria->compare('DCOMERCIAL',$this->DCOMERCIAL,true);
		$criteria->compare('DNUM_RES_INST_AVIACION',$this->DNUM_RES_INST_AVIACION,true);
		$criteria->compare('FINST_AVIACION',$this->FINST_AVIACION,true);
		$criteria->compare('DGACETA_INST_AVIACION',$this->DGACETA_INST_AVIACION,true);
		$criteria->compare('BVERIFICADORA',$this->BVERIFICADORA,true);
		$criteria->compare('SESION_ID',$this->SESION_ID,true);
		$criteria->compare('FIPRODUCTIVIDAD',$this->FIPRODUCTIVIDAD,true);
		$criteria->compare('DEFINANCIERO1',$this->DEFINANCIERO1,true);
		$criteria->compare('DEFINANCIERO2',$this->DEFINANCIERO2,true);
		$criteria->compare('DEFINANCIERO3',$this->DEFINANCIERO3,true);
		$criteria->compare('DINSCRITA',$this->DINSCRITA,true);
		$criteria->compare('CINCE',$this->CINCE,true);
		$criteria->compare('CBANAVIH',$this->CBANAVIH,true);
		$criteria->compare('CNIL',$this->CNIL,true);
		$criteria->compare('CLICMNPAL',$this->CLICMNPAL,true);
		$criteria->compare('CMAILSITIOELECT',$this->CMAILSITIOELECT,true);
		$criteria->compare('FCIERREEJERECON',$this->FCIERREEJERECON,true);
		$criteria->compare('CCIUU',$this->CCIUU,true);
		$criteria->compare('CSECTORECON',$this->CSECTORECON,true);
		$criteria->compare('CPROCAPEXT',$this->CPROCAPEXT,true);
		$criteria->compare('CTOTALCANTACCIONES',$this->CTOTALCANTACCIONES,true);
		$criteria->compare('SPERSONA',$this->SPERSONA);
		$criteria->compare('CTELEFONO2',$this->CTELEFONO2,true);
		$criteria->compare('CTELEFONO3',$this->CTELEFONO3,true);
		$criteria->compare('BACTUALIZADO',$this->BACTUALIZADO,true);
		$criteria->compare('SEMPRESA',$this->SEMPRESA);
		$criteria->compare('CPARROQUIA',$this->CPARROQUIA,true);
		$criteria->compare('DCALLE_AV',$this->DCALLE_AV,true);
		$criteria->compare('DESQUINA',$this->DESQUINA,true);
		$criteria->compare('DVEREDA',$this->DVEREDA,true);
		$criteria->compare('DURB_BARR',$this->DURB_BARR,true);
		$criteria->compare('DEDIF_CC',$this->DEDIF_CC,true);
		$criteria->compare('DPISO',$this->DPISO,true);
		$criteria->compare('DOFICINA',$this->DOFICINA,true);
		$criteria->compare('CDOC_RL',$this->CDOC_RL,true);
		$criteria->compare('CREGISTRONOTARIA_RL',$this->CREGISTRONOTARIA_RL,true);
		$criteria->compare('CTOMODOC_RL',$this->CTOMODOC_RL,true);
		$criteria->compare('CPROTOCOLO_RL',$this->CPROTOCOLO_RL,true);
		$criteria->compare('FDOC_RL',$this->FDOC_RL,true);
		$criteria->compare('DDECLARAC_IVA1',$this->DDECLARAC_IVA1,true);
		$criteria->compare('DDECLARAC_IVA2',$this->DDECLARAC_IVA2,true);
		$criteria->compare('DDECLARAC_IVA3',$this->DDECLARAC_IVA3,true);
		$criteria->compare('CTIPO_CONTRIBUYENTE',$this->CTIPO_CONTRIBUYENTE,true);
		$criteria->compare('DZONA_SECTOR',$this->DZONA_SECTOR,true);
		$criteria->compare('DPARCELA',$this->DPARCELA,true);
		$criteria->compare('BSEDES_SUCUR',$this->BSEDES_SUCUR,true);
		$criteria->compare('CTIPO_REG',$this->CTIPO_REG);
		$criteria->compare('DDISTRITOAC',$this->DDISTRITOAC,true);
		$criteria->compare('DDISTRITORL',$this->DDISTRITORL,true);
		$criteria->compare('CTIPO_PERS_JUR',$this->CTIPO_PERS_JUR);
		$criteria->compare('COFIC_REG_NOT',$this->COFIC_REG_NOT);
		$criteria->compare('DCONJ_CENTRO',$this->DCONJ_CENTRO,true);
		$criteria->compare('COFIC_REG_NOT_RL',$this->COFIC_REG_NOT_RL);
		$criteria->compare('CTIPO_REG_RL',$this->CTIPO_REG_RL);
		$criteria->compare('DDECLARAC_ISLR1',$this->DDECLARAC_ISLR1,true);
		$criteria->compare('DDECLARAC_ISLR2',$this->DDECLARAC_ISLR2,true);
		$criteria->compare('DDECLARAC_ISLR3',$this->DDECLARAC_ISLR3,true);
		$criteria->compare('BBORRADO',$this->BBORRADO,true);
		$criteria->compare('FBORRADO',$this->FBORRADO,true);
		$criteria->compare('BEXENTO',$this->BEXENTO,true);
		$criteria->compare('SPKSECTOR',$this->SPKSECTOR);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return GenJuridico the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
