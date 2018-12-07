class Log < ApplicationRecord
  enum log_type: [:application, :email, :text, :fax, :payment, :phone]
end
