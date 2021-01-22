family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }

immediate_family = []

family.select {|k, v| immediate_family << v if k == :sisters || k == :brothers}

 p immediate_family.flatten