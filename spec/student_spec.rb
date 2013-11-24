require '../lib/student'

describe do Student, "#initialize" do 

  student Student.new("Joe", "www.twitter.com", "tumblr.com")

  it "should initialize with three instance variables: name, twitter and blog" do
    expect(student.name).to eq("Joe")
    expect(student.twitter).to eq("www.twitter.com")
    expect(student.blog).to eq("tumblr.com")
  end
end
