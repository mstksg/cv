require 'faker'

module FakerHelpers
  def fake_paragraph(length=3)
    Faker::Lorem.paragraph(length)
  end

  def fake_company
    Faker::Company
  end

  def fake_person
    Faker::Name
  end

  def fake_field
    fake_company.bs.split[-2..-1].join(" ").capitalize
  end
end
