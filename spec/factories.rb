FactoryGirl.define do

  factory :user do
    login             "AAA001"
    name              Faker::Name.first_name
    last_name         Faker::Name.last_name
    last_name_alt     Faker::Name.last_name
    document          "12345678A"
    email             Faker::Internet.free_email
    phone_number      Faker::PhoneNumber.subscriber_number(9)
    user_role         User.user_roles[:respondent]
  end

  factory :campaign do
    name              "MyCampaign"
    status            0
  end

  factory :unit do
    campaign
    name              Faker::Lorem.word
    self.alias        Faker::Lorem.word
    unit_number       Faker::Number.between(1, 9)
  end

  factory :position do
    name              Faker::Lorem.word
    position_number   Faker::Number.between(1, 9)
    unit
  end

  factory :function do
    position
    name              Faker::Lorem.sentence(7)
    not_norm          false
  end

  factory :response do
    user
    function
    time_per          Faker::Number.between(1, 100)
  end

end