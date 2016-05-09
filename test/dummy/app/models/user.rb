class User < ActiveRecord::Base
  devise :invalidatable
end
