# INTRO

Morning Lecture

This morning's lecture is an introduction for the next 2 days. 
You will:
- work on your first app with several models / controllers, on the
next 2 days (they won’t be any lecture tomorrow morning, last day of OOP).

What we'll do:
- 


Introduction to the Food Delivery Exercise
You should make a good introduction for the food delivery:

- It will last 2 days
- Do a demo of what they should program (in the fullstack-solutions repo, launch ruby app.rb)
- there will be a logged in access;
- that they will have several models, controllers and views;
- that for each model, there is one controller and one view (but start by the model);
- The “Routing logic” is not provided, students should not focus on it at first, just models and controllers, and run basic scenario through app.rb;
- that there will be storage as CSV again, and that their should be a repository class for each model;

---
# MODELING DATA
Hello everyone and welcome to the 1st day of MODELING DATA. Today is the first of the 2 days we are gonna use to build our own food delivery app. So in this lecture we are going to learn how to use the MVC framework in situations where you have more than one model.

# REAL APPS HAVE SEVERAL MODELS
# Example: a hospital
we are going to be working with a hospital and our hospital should have:
- a Patient model with 2 inital states, that is, 2 attributes, a name(string) and cured? boolean
- a Room model with 2 inital states, capacity(integer), patients([] of patient instances)

![Image](/home/tatchiwiggers/code/batch-1092/FD-1/hospital.png "hospital")

# 1ST MODEL: PATIENT

# Create patient.rb
class Patient
    def initialize(name, cured)
        @name = name
        @cured = cured || false 
    end
end

Let's add a patient:
tatchi = Patient.new('tatchi', false)

ADD a new attribute boold_type then add patient sarah. run code:
patient.rb:2:in `initialize': wrong number of arguments (given 2, expected 3) (ArgumentError)


What we are eperiencing here is what we call ARGUMENT DEPENDENCY problem and to avoid that we are going to introduce to you today a new way of getting our parameters so that there wont be an argument dependency issue with our class.

So what we'll do is, instead of passing the arguments like we did, we are gonna pass them as a hash:

class Patient
    def initialize(attributes={})
        @name = attributes[:name]
        @cured = attributes[:cured]|| false
        @blood_type = attributes[:blood_type]
    end
end


tatchi = Patient.new(
        {
            name:'tatchi',
            cured: false
        }
    )

p tatchi

OF THE LAST ARGUMENT IS A HASH WE CAN REMOVE THE CURLY BRACES:
sarah = Patient.new(name: 'sarah', cured: false, blood_type: 'O+')
p sarah

ivan = Patient.new(cured: false, blood_type: 'O+', name: 'Iván')
p ivan

empty = Patient.new()
p empty

# If a wanna cure a patient, how can i do that?

def cure!
    @cured = true   
end

sarah = Patient.new(name: 'sarah', cured: false, blood_type: 'O+')
sarah.cure!
p sarah

sarah = Patient.new(name: 'sarah', cured: false, blood_type: 'O+')

puts "Sarah come to the hospital not feeling well... her cured state is #{sarah.cured}."
puts ''

puts "Sarah is being treated..."
sarah.cure!

puts "Sarah's cured state is now #{sarah.cured}!"
puts ''
talk about the importance of ONLY USING GETTERS AND SETTERS AS NEEDED.

# Let's build our room model:
# 2ND MODEL: ROOM

class Room

    def initialize(attributes={})
        @capacity = attributes[:capacity]
        @patients = attributes[:patients] || []
    end
end

Lets create some rooms:
room = Room.new(capacity: 2)
p room

Lets add patients to the room. We wanna be able to do:
room.add(patient)

We need to create a patient here.
 -> we cant
require_relative 'patient'
now we can

olena = Patient.new(name: 'olena', cured: false, blood_type: 'O+')
p olena

Let's add olena to our room:

def add(patient)
    @patients << patient
end

room.add(olena)
p room

alan = Patient.new(name: 'alan', cured: false, blood_type: 'O+')
p alan

room.add(alan)
p room

Let's see our patients array:
room.patients

attr_reader :patients

p room.patients

attr_reader :name
p room.patients.first.name

p "Room 2's first patient is #{room.patients.first.name}."

# which room is sarah in?
# ASSIGNED ROOM TO PATIENT?
if i run olena.room

we need to add :room to patients reader
BUT i get back nil. that is because i have assigned a room to this patient inside my room class. 

so what need need to do in order for it to work is:
   def add(patient)
        patient.room = self
        @patients << patient
    end
room.rb:12:in `add': undefined method `room='
Now we are writing as well as reading - what do e need to do? we need to turn room into an accessor.

run p olena.room


# SO our room has 2 patients:
olena and alan
p room.patients

Now the capacity of my room is 2, what happens if I add a 3rd patient?

add patient -> nothing, now i have three patients in a room with capacity of 2. So lets write a method that will allow us to control the capacity of our rooms.

    def full?
        @capacity == @patients.length  
    end

    puts "is the room full?"
    puts room.full?

Now lets add and if statement to avoid that patients are added to a room if it is at its full capacity.

    def add(patient)
        patient.room = self
        if full?
            puts "room is full, we cannot add anymore patients."
        else
            @patients << patient
        end
    end

p room.patients

Now instead of printing something out to the console, lets raise an exception...
Raising an error halts the entire program at that point (unless the exception is caught), whereas printing the message just writes something to stdout -- the output might be piped to another tool, or someone might not be running your application from the command line, and the print output may never be seen.

raise Exception, "Room is full!" if full?

We can also create our own error class:

class FullRoom < Exception; end
raise FullRoom, "Room is full!" if full?

so if i wanna make this more specific, i can use a begin rescue block.

INSIDE THE CLASS

 begin
        room = Room.new(capacity: 2)
        puts "is the room full?"
        puts room.full?

        olena = Patient.new(name: 'olena', cured: false, blood_type: 'O+')
        room.add(olena)
        puts "is the room full?"
        puts room.full?
    
        alan = Patient.new(name: 'alan', cured: false, blood_type: 'O+')
        room.add(alan)
        puts "is the room full?"
        puts room.full?

        tatchi = Patient.new(name:'tatchi', cured: false)
        room.add(tatchi)
        puts "is the room full?"
        puts room.full?
        
    rescue FullRoom    
        puts "full room, cannot add #{tatchi.name}..."
    end
---

# PERSISTENCE

Okay so we are done with the first part... TALKABOUT WHAT WE HAVE DONE:

No we wanna persist this info in a CSV file

Model the hospitals CSV. -> go online
see PNG

Lets create the csv
patients.csv
id,name,cured,blood_type
1,olena,false,O+
2,alan,false,O+
3,tatchi,false,O+

create a load_csv.rb file
copy slide and do a p row then p row.class

A CSV::Row is part Array and part Hash. It retains an order for the fields and allows duplicates just as an Array would, but also allows you to access fields by name just as you could if they were in a Hash.

All rows returned by CSV will be constructed from this class, if header row processing is activated.

rooms.csv
capacity,patients

# AUTO-INCREMENT
lets create a repo for our patients!!!
patient_repository.rb

# room repo will interact with patient repo
create room_repository.rb
