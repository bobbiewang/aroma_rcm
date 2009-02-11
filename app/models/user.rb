require 'digest/sha1'

class User < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  validate :password_non_blank

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  def self.encrypted_password(pwd, salt)
    Digest::SHA1.hexdigest(pwd + "wibble" + salt)
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?

    self.salt = object_id.to_s + rand.to_s
    self.hashed_password = User.encrypted_password(pwd, salt)
  end

  def after_destroy
    if User.count.zero?
      raise "Can't delete last user"
    end
  end

  private

  def password_non_blank
    errors.add_to_base("Missing password" ) if hashed_password.blank?
  end
end
