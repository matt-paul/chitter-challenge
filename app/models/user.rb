require 'bcrypt'

class User
#
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation
  validates_confirmation_of :password

  property :id, Serial
  property :email, String, required: true, unique: true
  property :handle, String

  property :password_digest, Text
  property :time, DateTime

  has n, :peeps


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    User.first(email: email)
  end

  def nice_time
    "2pm"
  end

end
