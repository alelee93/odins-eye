# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
password = "Password1!"

tag_types = ["Math", "Computer Science", "Programming", "Algorithms"]
reaction_types = ["like", "dislike", "genius", "report"]
tag_types.map!{ |tag| TagType.create(name: tag) }
reaction_types.map!{ |reaction| ReactionType.create(name: reaction)}
admin = User.create(name: "Admin", email: "admin@odinseye.com", password: "Adminpassword123!@#", password_confirmation: "Adminpassword123!@#", admin: true)
micah = User.create(name: "Micah Shute", email: "micah.shute@gmail.com", password: password, password_confirmation: password, bio: "My name is Micah and I like programming", image_path: "https://i.imgur.com/2jzzqWF.jpg", facebook_url: "https://www.facebook.com/micah.shute", github_url: "https://github.com/micahshute", linkedin_url: "https://www.linkedin.com/in/micahshute/")
taylor = User.create(name: "Taylor Swift", email:"taylor@swift.com", password: password, password_confirmation: password, bio: "I am secretly in love with Micah Shute")
voldi = User.create(name: "Lord Voldimort", email: "darkLord@killhp.com", password: password, password_confirmation: password, bio: "I like water sports, killing muggles and making #horcruxes", image_path: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2015/09/10/12/Ralph-Fiennes-Voldemort.jpg?w968%20968w,%20https://static.independent.co.uk/s3fs-public/thumbnails/image/2015/09/10/12/Ralph-Fiennes-Voldemort.jpg?w375%20375w,%20https://static.independent.co.uk/s3fs-public/thumbnails/image/2015/09/10/12/Ralph-Fiennes-Voldemort.jpg?w768%20768w%22%20src=%22https://static.independent.co.uk/s3fs-public/thumbnails/image/2015/09/10/12/Ralph-Fiennes-Voldemort.jpg?w968h681")
first_topic = Topic.create(user: micah, title: "What is the Fourier Transform?", content: "No, I really don't know. Can anyone tell me?") 
first_reply = first_topic.posts.build(user: micah, content: "An equation mapping time domain to the frequency domain")
first_topic.tags << Tag.new(tag_type: TagType.find_by(name: "math"))
first_topic.save

cs_topic = Topic.create(user: micah, title: "Sorting algorithms", content: "# Sorting Stuff \n Here's what you have to know about sorting algorithms. First of all, everyone talks about them but nobody uses them. Also, every language has built-in sorting that is most likely better than what you could make yourself")
cs_topic.tag("Computer Science", "Programming", "Beginners")
cs_topic.save
classroom = Classroom.new(name: "Math Class", professor: micah)

classroom.save

vtopic = Topic.create(user: voldi, title: "Good nosejob guy?", content: "If it turns out well ill give you lots of money and power. if not ill probs kill ya. Any suggestions leave below plz!")
student_lounge = classroom.topics.build(user: micah, title: "Student Lounge", classroom: classroom)
announcements = classroom.topics.build(user: micah, title: "Announcements", classroom: classroom)
class_topic = classroom.topics.build(user: micah, title: "Math stuff?", classroom: classroom)

class_topic.tags << Tag.new(tag_type: TagType.find_by(name: "math"))
classroom.save

classroom.students << taylor
classroom.tags << Tag.new(tag_type: TagType.find_by(name: "math"))
classroom.save
taylor.following << micah
micah.save

taylor.like(first_topic)
admin.like(first_reply)
taylor.dislike(first_reply)
taylor.message(micah, "I love you")
micah.message(taylor, "I know")
taylor.message(micah, "You stuck-up, half-witted, scruffy-looking nerf herder!")
micah.message(taylor, "Who's scruffy-lookin?")
micah.message(voldi, "There's nothing to see. I used to live here, you know")
voldi.message(micah, "You're going to die here, you know. Convenient.")
taylor.posts << Post.create(postable: first_reply, content: "Look what you made me do")
taylor.posts.last.posts << Post.create(user: micah, content: "Why does it feel so good")
taylor.like(micah.posts.last)
micah.like(micah.posts.last)
voldi.like(micah.posts.last)
micah.like(taylor.posts.last)
taylor.save

first_topic.tags << Tag.create(tag_type: tag_types[0])

first_topic.save


blog_post = Topic.new(user: taylor, title: "How to program a queue", content:
'# Programming a Queue.
--------------------
A queue is a limited version of an array. It is useful because it provides a simple abstraction for systems which require its specific functionality.

As a wise man once said:

> Queues are cool.

Things that use a queue:

* Searching through a trie (breadth-first-search)
* First-in-line applications

### So, how do you make a queue? 

(Btw, $E=mc^2$)

__You need 2 methods:__ `pop` and `push`. `pop` will remove the 0th element in the array and return it, and `push` will add an item to the end of the array.


~~~ ruby
def what?
  42
end
~~~

~~~ruby 
class Queue

    attr_reader :data

    def initialize(arr)
        @data = arr
    end

    def pop
        r_val = @data[0]
        @data = @data.slice(1, @data.length - 1)
        return r_val
    end

    def push(val)
        @data[@data.length] = val
    end

end
~~~


~~~
    Also, you can put stuff in here that isn\'t a language
~~~

1. list 1 item 1
    1. nested list item 1
    2. nested list item 2
10. list 1 item 2
    1. nested list item 1


| Header1 | Header2 | Header3 |
|:--------|:-------:|--------:|
| cell1   | cell2   | cell3   |
| cell4   | cell5   | cell6   |
|----
| cell1   | cell2   | cell3   |
| cell4   | cell5   | cell6   |
|=====
| Foot1   | Foot2   | Foot3
{: rules="groups"}

This is *emphasized*, _this_ too!

A [link](http://kramdown.gettalong.org)
to the kramdown homepage.

This is a text with a
footnote[^2].

[^2]:
    And here is the definition.

    > With a quote!



This is *red*{: style="color: red"}.
'
)

blog_post.save