module Templating
  def template_data(view="default")
    return lorem.merge(render_template)
  end

  def content
    return @content if @content

    @content = {}
    @content[:education] = YAML.load_file('data/content/education.yml')
    @content[:work_history] = YAML.load_file('data/content/work_history.yml')
    @content[:projects] = YAML.load_file('data/content/projects.yml')
    @content[:skills] = SmarterCSV.process('data/content/skills.csv')
    @content[:qualities] = YAML.load_file('data/content/qualities.yml')
    @content[:coursework] = YAML.load_file('data/content/coursework.yml')

    return @content
  end

  def render_template(view="default")
    view_yaml = YAML.load_file("data/template/#{view}.yml")
    template = {}

    template[:education] = view_yaml[:template][:education].map do |e|
      edu_content = content[:education][e]
      {
        :institution => edu_content[:institution],
        :title => edu_content[:title],
        :date => edu_content[:date],
        :comments => edu_content[:comments]
      }
    end

    template[:work_history] = view_yaml[:template][:work_history].map do |w|
      work_content = content[:work_history][w]

      {
        :organization => work_content[:organization],
        :title => work_content[:title],
        :description => work_content[:description],
        :year => work_content[:start][:year],
        :from => Time.new(work_content[:start][:year],
                          work_content[:start][:month]).strftime("%b '%y"),
        :to   => Time.new(work_content[:end][:year],
                          work_content[:end][:month]).strftime("%b '%y")
      }
    end

    template[:projects] = view_yaml[:template][:projects].map do |p|
      proj_content = content[:projects][p]
      {
        :field => proj_content[:field],
        :title => proj_content[:title],
        :description => proj_content[:description]
      }
    end

    template[:coursework] = view_yaml[:template][:coursework].map do |c|
      course_content = content[:coursework][c]
      {
        :course => course_content[:course],
        :title => course_content[:title],
        :description => course_content[:description]
      }
    end

    template[:qualities] = content[:qualities][view_yaml[:template][:qualities]]

    template
  end

  def lorem
    { :education   => [
        { :institution => "University of California, San Diego",
          :title       => "B.S. Physics w/ Specialization in Computational Physics",
          :date        => "Spring 2013",
          :comments    => "3.9 GPA" },
        { :institution => "ETS GRE",
          :title       => "Physics (740), General (165/165)",
          :date        => "Winter 2012"}
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
      :projects      => (1..3).map {
        { :field       => fake_field                  , 
          :title       => fake_company.catch_phrase   , 
          :description => fake_paragraph(2)            }
      },
      :qualities     => [fake_paragraph,fake_paragraph],
      :coursework    => (1..3).map {
        { :course      => fake_course                 , 
          :title       => fake_company.catch_phrase   , 
          :description => fake_paragraph(2)            }
      },
    }
  end

end
