class Profile < ActiveRecord::Base
  has_many :users
  attr_accessible :name, :permissions
  serialize :permissions
  
  validates :name, :presence => {:message => "Debe ingresar un Nombre para el Perfil"}
  # validates :permissions, :presence => {:message => "Debe especificar los permisos."}
end
