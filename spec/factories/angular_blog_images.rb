# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :angular_blog_image, :class => 'Image' do
    src "MyString"
  end
end
