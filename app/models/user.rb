class User < ActiveRecord::Base
  ROLES = ['Студент','Преподаватель', 'Администратор']
  has_secure_password

  has_many :documents
  has_many :presentations

  scope :ordering, ->{order(:login)}

  validates :login, presence: true, length: {in: 3..200}
  validates :full_name, presence: true, length: {in: 3..200}
  validates :password, length: {minimum: 6}, presence: {if: :new_record?}, allow_blank: {unless: :new_record?}
  validates :role, presence: true, inclusion: {in: 0...ROLES.size}

  def admin?
    role == 2
  end

  def prepod?
    role == 1
  end

  def student?
    role == 0
  end

  def edit_by?(u)
    u && (self == u || u.admin?)
  end
end
