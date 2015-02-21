class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :restaurants_added

  has_and_belongs_to_many :products
  has_and_belongs_to_many :restaurants
  has_many :orders
  has_many :calls
  has_many :collects
  has_many :rates

  validates :name, presence: true
  validates :password_confirmation, presence: true

  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
  end

  def restaurants_added
    Restaurant.where(creator_id: self.id).count
  end

  def self.facebook_login(auth_type)
    auth = auth_type
    name = auth["info"]["name"]
    email = auth["info"]["email"]
    uid = auth["uid"]
    User.find_by_email(email).nil? ? create_user_from_facebook(email, name, uid) : login_user_from_facebook(email, name, uid)
  end

  def self.create_user_from_facebook(email, name, uid)
    chars = ['a'..'z', '0'..'9', 'A'..'Z'].flat_map &:to_a
    password = chars.sample(16).join("")
    user = User.create(email: email, name: name, uid: uid, provider: "facebook", password: password)
    @user = user
  end

  def self.login_user_from_facebook(email, name, uid)
    user = User.find_by_email(email)
    user.update(name: name) if user.name.nil?
    user.update(uid: uid) if user.uid.nil?
    user.update(provider: "facebook") if user.provider.nil?
    @user = user
  end

end
