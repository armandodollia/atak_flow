class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  
  def authenticate(password)
    self.password == password
  end
  
  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end
  
  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

  def self.authenticate(params)
    user = User.find_by(username: params[:username])
    return user if user && user.password == params[:password]
  end
end
