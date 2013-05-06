module Templating
  def template_data(view="default")
    return lorem
  end

  def lorem
    { :education   => [
        { :institution => "University of California, San Diego",
          :title       => "B.S. Physics w/ Specialization in Computational Physics",
          :date        => "Spring 2013"     }
      ],
      :work_history  => (0..4).map { |year|
        { :year         => 2013-year                    , 
          :organization => fake_company.name            , 
          :title        => fake_person.title            , 
          :description  => fake_paragraph               , 
          :from         => "Oct '#{13-year}"            , 
          :to           => "May '#{13-year+1}"           }
      },
      :skills        => (1..12).map { |n| fake_person.title.split.sample },
      :projects      => (1..12).map {
        { :field       => fake_field                  , 
          :title       => fake_company.catch_phrase   , 
          :description => fake_paragraph(2)            }
      },
      :qualities     => fake_paragraph
    }
  end

end
