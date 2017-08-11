FactoryGirl.define do
  factory :campaign do
    name "MyCampaign"
    status 0;

    trait :invalid do
      name nil
    end
  end
end