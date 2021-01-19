class User < ApplicationRecord
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum status: {
    needs_confirmation: 0,
    active: 1,
    rejected: 2,
    deactivated: 3
  }

  scope :outstanding_access_requests, -> {
    unscoped.where(status: :needs_confirmation)
  }

  validates :full_name, presence: true
  validates :access_needed, presence: true, if: Proc.new { |record| record.new_record? }

  attr_reader :access_needed

  def access_needed=(value)
    @access_needed = value

    if new_record?
      self.type = @access_needed
    end
  end

  ##### Devise overrides #####
  def active_for_authentication?
    # only users that have been marked as "active" can sign in
    super && active?
  end
end
