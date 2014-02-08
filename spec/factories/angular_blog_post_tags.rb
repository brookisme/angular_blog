# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :angular_blog_post_tag, :class => 'PostTag' do
    post nil
    tag nil
  end
end
