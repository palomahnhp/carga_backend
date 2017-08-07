class CreateUserDirs < ActiveRecord::Migration
  def change
    create_table :user_dirs do |t|
      t.string :pernr
      t.string :nif
      t.string :ayre
      t.string :last_name
      t.string :last_name_alt
      t.string :name
      t.string :position_id
      t.string :position_des
      t.string :functional_unit_id
      t.string :functional_unit_des
      t.string :organic_code
      t.string :category
      t.string :category_den
      t.string :level
      t.string :personal_area
      t.string :personal_area_den
      t.string :email
      t.timestamps null: false
    end
  end
end

#Directorio response, used to create UserDir records
# <PERNR>6102</PERNR>
# <NIF>06207000J</NIF>
# <AYRE>MSB007</AYRE>
# <APELLIDO1>SEPULVEDA</APELLIDO1>
# <APELLIDO2>BUSTOS</APELLIDO2>
# <NOMBRE>MAXIMIANO</NOMBRE>
# <ID_PUESTO>30086336</ID_PUESTO>
# <DENOMINACION_PUESTO>JEFE/A DE NEGOCIADO</DENOMINACION_PUESTO>
# <ID_UNIDAD_FUNCIONAL>10000416</ID_UNIDAD_FUNCIONAL>
# <DEN_UNIDAD_FUNCIONAL>NEGOCIADO RELACION ENTIDADES FINANCIERAS, CONCILIAC. ARQUEOS</DEN_UNIDAD_FUNCIONAL>
# <COD_ORGANICO>45820143</COD_ORGANICO>
# <CATEGORIA>C005</CATEGORIA>
# <DEN_CATEGORIA>ADMINISTRATIVO</DEN_CATEGORIA>
# <NIVEL>22</NIVEL>
# <AREA_PERSONAL>F1</AREA_PERSONAL>
# <DEN_AREA_PERSONAL>Funcionario Carrera</DEN_AREA_PERSONAL>
# <EMAIL>sepulvedabm@madrid.es</EMAIL>
