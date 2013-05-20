module Templating
  def template_data(view="general")
    return lorem.merge(render_template(view))
  end

  def cv_content
    return @cv_content if @cv_content

    @cv_content = {}
    @cv_content[:education] = YAML.load_file('data/content/education.yml')
    @cv_content[:work_history] = YAML.load_file('data/content/work_history.yml')
    @cv_content[:projects] = YAML.load_file('data/content/projects.yml')
    @cv_content[:skills] = SmarterCSV.process('data/content/skills.csv',
                                            :col_sep => '|')
    @cv_content[:qualities] = YAML.load_file('data/content/qualities.yml')
    @cv_content[:coursework] = YAML.load_file('data/content/coursework.yml')

    return @cv_content
  end

  def template_index
    return @template_index if @template_index
    @template_index = YAML.load_file('data/template/index.yml')
    return @template_index
  end

  def select_template(view="general")
    template_index.keys.select { |k| template_index[k].include? view }.first || :general
  end

  def render_template(view="general")
    view_name = select_template(view)
    view_yaml = YAML.load_file("data/template/#{view_name}.yml")
    template = {}

    template[:view] = view_name
    template[:education] = view_yaml[:template][:education].map do |e|
      edu_content = cv_content[:education][e]
      {
        :institution => edu_content[:institution],
        :title => edu_content[:title],
        :date => edu_content[:date],
        :comments => edu_content[:comments]
      }
    end

    template[:work_history] = view_yaml[:template][:work_history].map do |w|
      work_content = cv_content[:work_history][w]

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
      proj_content = cv_content[:projects][p]
      {
        :field => proj_content[:field],
        :title => proj_content[:title],
        :description => proj_content[:description]
      }
    end

    template[:coursework] = view_yaml[:template][:coursework].map do |c|
      course_content = cv_content[:coursework][c]
      {
        :course => course_content[:course],
        :title => course_content[:title],
        :description => course_content[:description]
      }
    end

    template[:skills] = select_skills(view_yaml[:template][:skills])

    template[:qualities] = cv_content[:qualities][view_yaml[:template][:qualities]]

    template
  end

  # def select_skills_mix(distribution)
  #   distskills = distribution.map do |dist|
  #     content[:skills].select { |s| s[:primary] == dist[:category] }.first(dist[:amount]).reverse
  #   end.reverse

  #   max_dist = distribution.map { |d| d[:amount] }.max

  #   ([nil]*max_dist).zip(*distskills).flatten.select { |s| s }.map { |s| s[:skill] }.reverse
  # end

  def select_skills(distribution)
    distribution.map do |dist|
      primaries = cv_content[:skills].select { |s| s[:primary] == dist[:category] }
      secondaries = cv_content[:skills].select { |s| s[:secondary] == dist[:category] }
      (primaries+secondaries).first(dist[:amount]).map do |s|
        { :skill => s[:skill], :primary => s[:primary], :secondary => s[:secondary] }
      end
    end.flatten.uniq { |s| s[:skill] }
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
