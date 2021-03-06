class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  accepts_nested_attributes_for :user, reject_if: proc {|attributes| attributes['username'].blank?}


  def users_attributes=(users_attributes)
    users_attributes.values.each do |users_attribute|
      user = User.find_or_create_by(users_attribute)
      self.post_users.build(user: user)
    end
  end
  # def users_attributes=(user_attributes)
  #   user_attributes.values.each do |user_attribute|
  #     if user_attribute[:username].present?
  #       user = User.find_or_create_by(user_attribute)
  #       if !self.users.include?(user)
  #         self.comments.build(:user => user)
  #       end
  #     end
  #   end
  # end
end
