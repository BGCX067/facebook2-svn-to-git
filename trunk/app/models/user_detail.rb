class UserDetail < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :realname,
                        :message => "- 真实姓名是必须的！"
end
