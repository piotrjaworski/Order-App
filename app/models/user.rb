class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :products
  has_and_belongs_to_many :restaurants
  has_many :orders
  has_many :calls
  has_many :collects
  has_many :rates

  validates :name, presence: true
  validates :password_confirmation, presence: true

  def self.facebook_login(auth_type)
    auth = auth_type
    name = auth["info"]["name"]
    email = auth["info"]["email"]
    uid = auth["uid"]
    if User.find_by_email(email).nil?
      chars = ['a'..'z', '0'..'9', 'A'..'Z'].flat_map &:to_a
      password = chars.sample(16).join("")
      user = User.create(email: email,
                         name: name,
                         uid: uid,
                         provider: "facebook",
                         password: password)
      @user = user
    else
      user = User.find_by_email(email)
      user.update(name: name) if user.name.nil?
      user.update(uid: uid) if user.uid.nil?
      user.update(provider: "facebook") if user.provider.nil?
      @user = user
    end
  end

end
