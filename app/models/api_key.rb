class ApiKey < ApplicationRecord
  belongs_to :user
  validates :api_key, presence: true, uniqueness: true

  before_create :init_api_key

  private

  def init_api_key
    self.api_key = SecureRandom.alphanumeric(50)
    self.frequency = 0
  end

   # subscription_type = AllKey.find_by(api_key: params[:api_key]).subscription_type
       
   #  if subscription_type == 1
   #    curr_obj = AllKey.find_by(api_key: @api_key)
   #    created_time = curr_obj.created_at
   #    one_day_from_created_time = created_time+1.day
   #    if Time.now-1.day > created_time
   #      curr_obj.frequency = 1
   #      curr_obj.created_at = Time.now
   #      curr_obj.save
   #    elsif Time.now < one_day_from_created_time && curr_obj.frequency+1 > 500
   #      render json: { error: 'Daily limit reached' }, status: 401
   #      elsif Time.now < one_day_from_created_time && curr_obj.frequency + 1 <= 500
   #        curr_obj.frequency = curr_obj.frequency + 1
   #        curr_obj.save
   #      end
   #    elsif subscription_type == 2
   #      curr_obj = AllKey.find_by(api_key: @api_key)
   #      created_time = curr_obj.created_at
   #      one_day_from_created_time = created_time+1.day
   #      if Time.now-1.day>created_time
   #        curr_obj.frequency = 1
   #        curr_obj.created_at = Time.now
   #        curr_obj.save
   #      elsif Time.now < one_day_from_created_time && curr_obj.frequency+1>2000
   #        render json: {error: 'Daily limit reached'}, status: 401
   #      elsif Time.now < one_day_from_created_time && curr_obj.frequency+1 <= 2000
   #        curr_obj.frequency = curr_obj.frequency+1
   #        curr_obj.save
   #      end
   #      elsif subscription_type == 3
   #        curr_obj = AllKey.find_by(api_key: @api_key)
   #        created_time = curr_obj.created_at
   #        one_day_from_created_time = created_time+1.day
   #        if Time.now-1.day>created_time
   #          curr_obj.frequency = 1
   #          curr_obj.created_at = Time.now
   #          curr_obj.save
   #        elsif Time.now < one_day_from_created_time && curr_obj.frequency+1>10000
   #          render json: {error: 'Daily limit reached'}, status: 401
   #          elsif Time.now < one_day_from_created_time && curr_obj.frequency+1 <= 10000
   #            curr_obj.frequency = curr_obj.frequency+1
   #            curr_obj.save
   #          end
   #      end
   #  end
end
