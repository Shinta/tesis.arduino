# encoding: utf-8
class User < ActiveRecord::Base
  belongs_to :profile
  attr_accessible :name, :lastname, :username, :password, :profile_id, :cellphone, :send_notification
  
  validates_presence_of :name, :message => "Debe ingresar el Nombre"
  validates_presence_of :lastname, :message => "Debe ingresar el Apellido"
  validates_presence_of :username, :message => "Debe ingresar el Nombre de Usuario"
  validates :username, :uniqueness => {:message => "El nombre de Usuario ingresado ya existe."}, :unless => Proc.new {|u| u.username != u.username_was}
  validates_presence_of :password, :message => "Debe ingresar la Contraseña", :on => :create
  validate :cellphone_for_notification
  
  before_save :generate_password_update
  
  scope :to_notificate, where("send_notification = 1 and cellphone is not null")

  def full_name
    "#{self.name} #{self.lastname}"
  end

  def authenticate(written_password)
  	Digest::SHA256.hexdigest(written_password + self.salt) == self.password
  end
  def have_access?(group, permission)
    access = self.profile.permissions[group][permission] rescue nil
    return true if access == "1"
    return false
  end

  protected
  def generate_password_update
    puts "generate_password_update"
    if self.password.blank?
      self.password = self.password_was
    else
     	self.change_password
    end
  end
  def change_password
    puts "change_password"
  	self.salt = Digest::SHA1.hexdigest(self.username + self.digest_key + Time.now.to_s) if self.salt.blank?
  	self.password = Digest::SHA256.hexdigest(self.password + self.salt)
  end
  def digest_key
    "queAburridoArbolPerroDibujito.I.013"
  end
  def cellphone_for_notification
    self.errors.add(:cellphone, "Debe completar el Celular para recibir notificaciones.") if self.send_notification? && self.cellphone.blank?
  end
end
