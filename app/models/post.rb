class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :image_url
  field :status
  field :houdini_request_sent_at, :type => DateTime


  include Houdini::Model

  houdini :moderates_image,
    :identifier => 'example_image_moderation',
    :price => '0.01',
    :title => 'Please moderate image',
    :form_template => File.join(RAILS_ROOT, 'app/views/houdini_templates/post.html.haml'),
    :on_submit => :timestamp_houdini_request,
    :on_postback => :process_image_moderation_answer

  after_create :moderate_image, :if => :image_url

  def moderate_image
    send_later(:send_to_houdini)
  end

  def timestamp_houdini_request(response, body)
    update_attribute(:houdini_request_sent_at, Time.now)
  end

  def process_image_moderation_answer(answer)
    answer[:flagged] == 'no' ? approve! : flag!
  end
end
