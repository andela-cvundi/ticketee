FactoryGirl.define do

  factory :attachment do

    transient do
      file_to_attach "spec/fixtures/text.txt"
    end

    file { File.open file_to_attach }

  end

end
