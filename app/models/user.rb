class User < ApplicationRecord
  validates :display_name, presence: true, uniqueness: true
  before_validation :uniq_display_name!, on: :create

  has_many :event_signups

  def display_name=(value)
    super(value&.strip)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def sign_or_unsign_for_event(event)
    if already_signed_up?(event)
      unsign_for_event(event)
    else
      signup_for_event(event)
    end
  end

  def signup_for_event(event)
    EventSignup.create(user: self, event: event)
  end

  def unsign_for_event(event)
    event_signups.where(event_id: event.id).first.destroy
  end

  def already_signed_up?(event)
    event_signups.find_by(event_id: event.id).present?
  end

  private

  # Makes the display_name unique by appending a number to it if necessary.
  # "Gleb" => Gleb 1"
  def uniq_display_name!
    if display_name.present?
      new_display_name = display_name
      i  = 0
      while User.exists?(display_name: new_display_name)
        new_display_name = "#{display_name} #{i += 1}"
      end
      self.display_name = new_display_name
    end
  end
end
