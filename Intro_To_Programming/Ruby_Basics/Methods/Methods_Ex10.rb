names = ['Dave', 'Sally', 'George', 'Jessica']
activities = ['walking', 'running', 'cycling']

def name(names)
    names.sample
end

def activity(activities)
    activities.sample
end


def sentence(name, activity)
    name + " went " + activity + " today!"
end

puts sentence(name(names), activity(activities))


########################################


def sentence
    
    names = ['Dave', 'Sally', 'George', 'Jessica']
    activities = ['walking', 'running', 'cycling']
    
    def name(names)
        names.sample
    end
    
    def activity(activities)
        activities.sample
    end
   
name(names) + " went " + activity(activities)

end


puts sentence