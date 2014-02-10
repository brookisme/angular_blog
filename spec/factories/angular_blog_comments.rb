# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :angular_blog_comment, :class => 'Comment' do
    post nil
    email "MyString"
    name "MyString"
    content "MyText"
  end
end
