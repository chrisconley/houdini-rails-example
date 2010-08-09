require 'spec_helper'

describe Post do
  describe "Houdini" do
    before do
      @post = Post.new(:image_url => 'http://bogus.com/image.jpg')
    end
    it "should send request after create" do
      @post.should_receive(:send_later).with(:send_to_houdini)
      @post.save
    end
    describe "#process_image_moderation_answer" do
      it "should flag image if answer[:flagged] is 'yes'" do
        @post.should_receive(:flag!)
        @post.process_image_moderation_answer({:flagged => 'yes'})
      end

      it "should approve image if answer[:flagged] is 'no'" do
        @post.should_receive(:approve!)
        @post.process_image_moderation_answer({:flagged => 'no'})
      end
    end
  end
end
